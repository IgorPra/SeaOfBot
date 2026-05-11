defmodule SeaOfBotTest do
  use ExUnit.Case
  doctest SeaOfBot

  test "greets the world" do
    assert SeaOfBot.hello() == :world
  end
end
