defmodule KV.Registry do
  @moduledoc """
  Tutorial MyRegistry genserver, etc
  """
  use GenServer

  # Client API - will add

  @doc """
  Starts the registry
  """
  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  @spec lookup(atom | pid | {atom, any} | {:via, atom, any}, any) :: any
  @doc """
  Looks up the bucket pid for name stored in server
  Returns {:ok, pid} if the bucket exists, :error otherwise
  """
  def lookup(server, name) do
    GenServer.call(server, {:lookup, name})
  end

  @doc """
  Ensures there is a bucket associated with the given name in server
  """
  def create(server, name) do
    GenServer.cast(server, {:create, name})
  end

  # Defining GenServer Callbacks

  # calls -> sync and server must reply, client waits
  # casts -> async, no server reply, client won't wait

  @impl true
  def init(:ok) do
    names = %{}
    refs = %{}
    {:ok, {names, refs}}
  end

  @impl true
  def handle_call({:lookup, name}, _from, state) do
    {names, _} = state
    {:reply, Map.fetch(names, name), state}
  end

  @impl true
  def handle_cast({:create, name}, {names, refs}) do
    if Map.has_key?(names, name) do
      {:noreply, {names, refs}}
    else
      {:ok, pid} = DynamicSupervisor.start_child(MyBucketSupervisor, KV.Bucket)
      ref = Process.monitor(pid)
      refs = Map.put(refs, ref, name)
      names = Map.put(names, name, pid)
      {:noreply, {names, refs}}
    end
  end

  @impl true
  def handle_info({:DOWN, ref, :process, _pid, _reason}, {names, refs}) do
    {name, refs} = Map.pop(refs, ref)
    names = Map.delete(names, name)
    {:noreply, {names, refs}}
  end

  @impl true
  def handle_info(msg, state) do
    require Logger
    Logger.debug("Unexpected message in MyRegistry: #{inspect(msg)}")
    {:noreply, state}
  end
end
