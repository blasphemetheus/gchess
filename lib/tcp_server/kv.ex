defmodule KV do
  @moduledoc """
  Tutorial KV
  """
  use Application

  @impl true
  def start(_type, _args) do
    # we don't use the sup name below directly,
    # it can be useful when inspecting/debugging
    KV.Supervisor.start_link(name: KV.Supervisor)
  end

  def start_link do
    Task.start_link(fn -> loop(%{}) end)
  end

  defp loop(map) do
    receive do
      {:get, key, caller} ->
        send(caller, Map.get(map, key))
        loop(map)

      {:put, key, value} ->
        loop(Map.put(map, key, value))
    end
  end
end
