defmodule SeaOfBot do
  use Nostrum.Consumer

  alias Nostrum.Api.Message

  def handle_event({:MESSAGE_CREATE, msg, _ws}) do
    cond do
      String.starts_with?(msg.content, "!tech") ->
        Message.create(msg.channel_id, SeaOfBot.Command.Tech.handle_tech(msg))

      String.starts_with?(msg.content, "!status") ->
        Message.create(msg.channel_id, SeaOfBot.Command.Status.handle_status(msg))

      String.starts_with?(msg.content, "!github") ->
        Message.create(msg.channel_id, SeaOfBot.Command.Github.handle_github(msg))

      String.starts_with?(msg.content, "!age") ->
        Message.create(msg.channel_id, SeaOfBot.Command.Age.handle_age(msg))

      String.starts_with?(msg.content, "!conv") ->
        Message.create(msg.channel_id, SeaOfBot.Command.Conv.handle_conv(msg))

      String.starts_with?(msg.content, "!emoji") ->
        Message.create(msg.channel_id, SeaOfBot.Command.Emoji.handle_emoji(msg))

      String.starts_with?(msg.content, "!lembrar") ->
        Message.create(msg.channel_id, SeaOfBot.Command.Remember.handle_remember(msg))

      String.starts_with?(msg.content, "!memorias") ->
        Message.create(msg.channel_id, SeaOfBot.Command.Remember.handle_memories(msg))

      String.starts_with?(msg.content, "!country") ->
        Message.create(msg.channel_id, SeaOfBot.Command.Country.handle_country(msg))

      String.starts_with?(msg.content, "!livro") ->
        Message.create(msg.channel_id, SeaOfBot.Command.Livro.handle_livro(msg))

      true ->
        :ignore
    end
  end
end
