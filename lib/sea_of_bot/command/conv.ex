defmodule SeaOfBot.Command.Conv do
  def handle_conv(msg) do
    if String.starts_with?(msg.content, "!conv") do
      case String.split(msg.content) do
        ["!conv", amount, moeda] ->
          hoje = Date.utc_today() |> Calendar.strftime("%m-%d-%Y")
          moeda = String.upcase(moeda)

          url = "https://olinda.bcb.gov.br/olinda/servico/PTAX/versao/v1/odata/CotacaoMoedaDia(moeda=@moeda,dataCotacao=@dataCotacao)?@moeda='#{moeda}'&@dataCotacao='#{hoje}'&$format=json"

          {:ok, response} = HTTPoison.get(url)
          {:ok, json} = Jason.decode(response.body)

          case json["value"] do
            [dados | _] ->
              taxa = dados["cotacaoVenda"]
              resultado = String.to_float(amount) * taxa
              "Resultado: R$ #{Float.round(resultado, 2)}"

            [] -> "Erro."
          end

        _ -> "Use: !conv 100 USD"
      end
    end
  end
end
