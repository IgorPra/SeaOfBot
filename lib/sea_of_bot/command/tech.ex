defmodule SeaOfBot.Command.Tech do
  def handle_tech(msg) do
    if msg.content == "!tech" do
      {:ok, res} = HTTPoison.get("https://hacker-news.firebaseio.com/v0/topstories.json")
      {:ok, ids} = Jason.decode(res.body)

      id = List.first(ids)

      {:ok, res2} = HTTPoison.get("https://hacker-news.firebaseio.com/v0/item/#{id}.json")
      {:ok, news} = Jason.decode(res2.body)

      "#{news["title"]}\n#{news["url"]}"
    end
  end
end
