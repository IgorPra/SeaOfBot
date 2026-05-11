defmodule SeaOfBot.Command.Emoji do
  def handle_emoji(_msg) do
    {:ok, res} = HTTPoison.get("https://emojihub.yurace.pro/api/random")
    {:ok, json} = Jason.decode(res.body)

    "#{json["name"]} - #{json["htmlCode"] |> List.first()}"
  end
end
