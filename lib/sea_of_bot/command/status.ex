defmodule SeaOfBot.Command.Status do
  def handle_status(_msg) do
    {:ok, res} = HTTPoison.get("https://api.websitecarbon.com/site?url=google.com")
    {:ok, json} = Jason.decode(res.body)

    if json["green"] do
      "🌱 Site é ecológico"
    else
      "⚠️ Site não é ecológico"
    end
  end
end
