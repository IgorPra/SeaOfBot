defmodule SeaOfBot.Command.Conv do
  def handle_conv(msg) do
    case String.split(msg.content) do
      ["!conv", amount, from, to] -> convert(amount, from, to)
      _ -> "Use: !conv 100 USD BRL"
    end
  end

  defp convert(amount, from, to) do
    url = "https://api.exchangerate.host/convert?from=#{from}&to=#{to}&amount=#{amount}"
    {:ok, res} = HTTPoison.get(url)
    {:ok, json} = Jason.decode(res.body)

    "Resultado: #{json["result"]}"
  end
end
