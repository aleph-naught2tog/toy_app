defmodule ToyAppTest do
  use ExUnit.Case
  doctest ToyApp

  describe "reader" do
    test "should start :ok" do
      {:ok, result} = Reader.start(self())
      assert is_pid(result)
    end

    test "should respond to message" do
      current_pid = self()
      {:ok, pid} = Reader.start(current_pid)
      send(pid, {current_pid, :echo_in})
      assert_receive :echo_out
    end
  end
end
