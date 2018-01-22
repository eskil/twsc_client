defmodule TwscClientTest do
  use ExUnit.Case
  doctest TwscClient

  test "greets the world" do
    assert TwscClient.hello() == :world
  end
end
