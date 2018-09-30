defmodule Reader do
  @spec start(pid) :: :ok
  def start(starter_pid) do
    new_pid = spawn(fn -> check_mailbox(starter_pid) end)
    send(starter_pid, {:ok, new_pid})
  end

  @spec check_mailbox(pid) :: no_return
  def check_mailbox(parent) when is_pid(parent) do
    current = self()
    receive do
      {sender, :echo_in} -> send(sender, :echo_out)
      {^parent, :shutdown_start} -> shutdown(parent)
      {_, {:error, reason}} -> stop(parent, {:error, reason})
      _ -> stop(parent, {:error, "Unexpected message."})
    end
  end

  @spec shutdown(pid) :: {:ok, :done}
  def shutdown(parent_pid) do
    send(parent_pid, {:ok, :done})
  end

  @spec stop(pid, {:error, term}) :: {:error, term}
  def stop(parent_pid, {:error, reason}) do
    send(parent_pid, {:error, reason})
  end
end