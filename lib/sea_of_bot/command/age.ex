defmodule SeaOfBot.Command.Age do
  def handle_age(msg) do
    case String.split(msg.content) do
      ["!age"] -> "Use: !age <nome>"
      ["!age", name] -> fetch(name)
      _ -> "Comando inválido"
    end
  end

  defp fetch(name) do
    {:ok, res} = HTTPoison.get("https://api.agify.io/?name=#{name}")
    {:ok, json} = Jason.decode(res.body)

    "Idade estimada para #{name}: #{json["age"]}"
  end
end
