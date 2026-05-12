defmodule SeaOfBot.Store do
  @file_path "store.json"

  def load do
    case File.read(@file_path) do
      {:ok, ""} ->
        []
      {:ok, content} ->
        content
        |> Jason.decode!()
        |> Enum.map(fn t -> %{id: t["id"], name: t["name"], done: t["done"]} end)
      {:error, _} -> []
    end
  end

  def save(dados) do
    dados
    |> Jason.encode!(pretty: true)
    |> then(&File.write!(@file_path, &1))
  end
end
