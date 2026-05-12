defmodule SeaOfBot.Command.Country do
  def handle_country(msg) do
    if String.starts_with?(msg.content, "!country") do
      case String.split(msg.content) do
        ["!country", code] ->
          {:ok, res} = HTTPoison.get("https://restcountries.com/v3.1/alpha/#{code}")
          {:ok, [json]} = Jason.decode(res.body)
          name = json["name"]["common"]

          {:ok, res2} = HTTPoison.get("https://restcountries.com/v3.1/name/#{name}")
          {:ok, [data]} = Jason.decode(res2.body)
          capital = List.first(data["capital"])
          population = data["population"]

          """
          Nome: #{name}
          Capital: #{capital}
          População: #{population}
          """

        _ -> "Use: !country <codigo_pais> (ex: br)"
      end
    end
  end
end
