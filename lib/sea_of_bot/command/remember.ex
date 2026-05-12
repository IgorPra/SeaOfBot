defmodule SeaOfBot.Command.Remember do
  alias SeaOfBot.Store

  def handle_remember(msg) do
    list = msg.content |> String.trim() |> String.split(" ")

    case list do
      ["!lembrar"] ->
        "Use o comando como:\n" <>
        "!lembrar <nome da tarefa> -> para adicionar\n" <>
        "!lembrar done <id> -> para concluir\n" <>
        "!lembrar delete <id> -> para remover"

      ["!lembrar", "done", id_str] ->
        todos = Store.load()
        id = String.to_integer(id_str)
        novos_todos = mark_done(todos, id)
        Store.save(novos_todos)
        "Tarefa ##{id} marcada como concluída!"

      ["!lembrar", "delete", id_str] ->
        todos = Store.load()
        id = String.to_integer(id_str)
        novos_todos = delete(todos, id)
        Store.save(novos_todos)
        "Tarefa ##{id} removida!"

      ["!lembrar" | rest] ->
        nome_tarefa = Enum.join(rest, " ")
        todos = Store.load()
        novos_todos = add(todos, nome_tarefa)
        Store.save(novos_todos)
        "Tarefa adicionada: #{nome_tarefa}"

      _ ->
        "Comando inválido!"
    end
  end

  def handle_memories(msg) do
    if String.starts_with?(msg.content, "!memorias") do
      todos = Store.load()
      list(todos)
    end
  end

  defp new_id, do: :os.system_time(:millisecond)

  def add(todos, name) do
      task = %{id: new_id(), name: name, done: false}
      todos ++ [task]
  end

  def delete(todos, id) do
    Enum.reject(todos, fn t -> t.id == id end)
  end

  def mark_done(todos, id) do
    Enum.map(todos, fn t ->
      if t.id == id, do: Map.put(t, :done, true), else: t
    end)
  end

  def list(todos) do
    if Enum.empty?(todos) do
      "Nenhuma tarefa cadastrada!"
    else
      itens =
        todos
        |> Enum.map(fn t ->
          status = if t.done, do: "✅", else: "❌"
          "[#{status}] ##{t.id} - #{t.name}"
        end)
        |> Enum.join("\n")

      "📝 Suas tarefas:\n" <> itens
    end
  end
end
