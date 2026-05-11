defmodule SeaOfBot.Command.Country do
  def handle_country(msg) do
    case String.split(msg.content) do
      ["!country", code] -> fetch(code)
      _ -> "Use: !country <codigo_pais> (ex: br)"
    end
  end

  defp fetch(code) do
    {:ok, res} = HTTPoison.get("https://restcountries.com/v3.1/alpha/#{code}")
    {:ok, [json]} = Jason.decode(res.body)

    name = json["name"]["common"]

    {:ok, res2} = HTTPoison.get("https://restcountries.com/v3.1/name/#{name}")
    {:ok, [data]} = Jason.decode(res2.body)

    capital = List.first(data["capital"])
    population = data["population"]

    """
    🌍 #{name}
    🏙 Capital: #{capital}
    👥 População: #{population}
    """
  end
end
