defmodule SeaOfBot.Command.Status do
  def handle_status(msg) do
    if msg.content == "!status" do
      {:ok, response} = HTTPoison.get("https://api.websitecarbon.com/site?url=google.com")
      {:ok, json} = Jason.decode(response.body)

      if json["green"] do
        "Site é ecológico"
      else
        "Site não é ecológico"
      end
    end
  end
end
