defmodule ToyAppTest do
  use ExUnit.Case
  doctest ToyApp

  describe "reader" do
    test "should start :ok" do
      {:ok, result} = Reader.start(self())
      assert is_pid(result)
    end

    test "should respond to echo" do
      current_pid = self()
      {:ok, pid} = Reader.start(current_pid)
      send(pid, {current_pid, :echo_in})
      assert_receive :echo_out
    end

    test "should stop on error" do
      current_pid = self()
      {:ok, pid} = Reader.start(current_pid)
      send(pid, {current_pid, {:error, "because I said so"}})
      assert_receive {:error, "because I said so"}
    end

    test "should stop without error" do
      current_pid = self()
      {:ok, pid} = Reader.start(current_pid)
      send(pid, {current_pid, :shutdown_start})
      assert_receive {:ok, :done}
    end
  end
end
