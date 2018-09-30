defmodule ToyAppTest do
  use ExUnit.Case
  doctest ToyApp

  test "greets the world" do
    assert ToyApp.hello() == :world
  end
end
