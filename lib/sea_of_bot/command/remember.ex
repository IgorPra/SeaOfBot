defmodule SeaOfBot.Command.Remember do
  alias SeaOfBot.Store

  def handle_remember(msg) do
    case String.split(msg.content, " ", parts: 2) do
      ["!lembrar", text] -> save(msg.author.id, text)
      _ -> "Use: !lembrar <texto>"
    end
  end

  def handle_memories(msg) do
    data = Store.load()

    memories =
      data
      |> Map.get("users", %{})
      |> Map.get(to_string(msg.author.id), [])

    if memories == [] do
      "Voce ainda nao salvou nenhuma lembranca. Use: !lembrar <texto>"
    else
      memories
      |> Enum.with_index(1)
      |> Enum.map_join("\n", fn {entry, index} ->
        extra = Map.get(entry, "extra")
        text = Map.get(entry, "text", "")

        if is_binary(extra) and extra != "" do
          "#{index}. #{text} (Sugestao: #{extra})"
        else
          "#{index}. #{text}"
        end
      end)
      |> then(&"Suas lembrancas:\n#{&1}")
    end
  end

  defp save(user_id, text) do
    # Chamada da API externa para salvar uma sugestao junto da lembranca.
    {:ok, res} = HTTPoison.get("https://www.boredapi.com/api/activity")

    case Jason.decode(res.body) do
      {:ok, json} ->
        entry = %{
          "text" => text,
          "extra" => json["activity"]
        }

        data = Store.load()

        users = Map.get(data, "users", %{})

        user_entries = Map.get(users, to_string(user_id), [])

        updated_users = Map.put(users, to_string(user_id), user_entries ++ [entry])

        Store.save(%{"users" => updated_users})

        "Salvo! 💾\nSugestão: #{json["activity"]}"

      _ ->
        "Erro ao acessar API externa."
    end
  end
end
