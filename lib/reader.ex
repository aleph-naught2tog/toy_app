defmodule Reader do
  @spec start(pid) :: :ok
  def start(starter_pid) do
    new_pid = spawn(fn -> check_mailbox() end)
    send(starter_pid, {:ok, new_pid})
  end

  @spec check_mailbox(:halt) :: {:ok, :done}
  @spec check_mailbox(none) :: no_return
  def check_mailbox(:halt), do: {:ok, :done}
  def check_mailbox() do
    receive do
      {sender, :echo_in} -> send(sender, :echo_out)
    end
  end
end