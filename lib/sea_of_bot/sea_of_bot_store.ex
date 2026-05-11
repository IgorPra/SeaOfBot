defmodule SeaOfBot.Store do
  @file_path "store.json"

  def load do
    case File.read(@file_path) do
      {:ok, content} ->
        content
        |> Jason.decode!()
        |> normalize()

      {:error, _} ->
        %{"users" => %{}}
    end
  end

  def save(data) do
    data
    |> Jason.encode!(pretty: true)
    |> then(&File.write!(@file_path, &1))
  end

  defp normalize(%{"users" => users}) when is_map(users), do: %{"users" => users}
  defp normalize(_data), do: %{"users" => %{}}
end
