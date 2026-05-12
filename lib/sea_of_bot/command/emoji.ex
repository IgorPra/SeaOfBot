defmodule SeaOfBot.Command.Emoji do
  def handle_emoji(msg) do
    if msg.content == "!emoji" do
      {:ok, response} = HTTPoison.get("https://emojihub.yurace.pro/api/random")
      {:ok, json} = Jason.decode(response.body)
      "#{json["name"]} - #{json["htmlCode"] |> List.first()}"
    end
  end
end
