defmodule SeaOfBot.Command.Age do
  def handle_age(msg) do
    if String.starts_with?(msg.content, "!age") do
      case String.split(msg.content) do
        ["!age", name] ->
          {:ok, response} = HTTPoison.get("https://api.agify.io/?name=#{name}")
          {:ok, json} = Jason.decode(response.body)
          "Idade estimada para #{name}: #{json["age"]}"
        
        _ -> "Use: !age <nome>"
      end
    end
  end
end
