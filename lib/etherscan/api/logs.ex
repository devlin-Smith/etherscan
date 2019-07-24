defmodule Etherscan.API.Logs do
  @moduledoc """
  Module to wrap Etherscan event log endpoints.

  [Etherscan API Documentation](https://etherscan.io/apis#logs)
  """

  use Etherscan.API
  use Etherscan.Constants
  alias Etherscan.Log

  @operators ["and", "or"]

  @get_logs_default_params %{
    address: nil,
    fromBlock: 0,
    toBlock: "latest",
    topic0: nil,
    topic0_1_opr: nil,
    topic1: nil,
    topic1_2_opr: nil,
    topic2: nil,
    topic2_3_opr: nil,
    topic3: nil
  }

  @doc """
  Returns a list of valid topic operators for `get_logs/1`.

  ## Example

      iex> Etherscan.API.Logs.operators()
      #{@operators |> inspect()}
  """
  @spec operators :: list(String.t())
  def operators, do: @operators

  @doc """
  An alternative API to the native eth_getLogs.

  See `operators/0` for all valid topic operators.

  `params[fromBlock|toBlock]` can be a block number or the string `"latest"`.

  Either the `address` or `topic(x)` params are required.

  For API performance and security considerations, **only the first 1000 results
  are returned.**

  ## Example

      iex> params = %{
        address: "#{@test_topic_address}", # Ethereum blockchain address
        fromBlock: 0, # Start block number
        toBlock: "latest", # End block number
        topic0: "#{@test_topic_0}", # The first topic filter
        topic0_1_opr: "and", # The topic operator between topic0 and topic1
        topic1: "", # The second topic filter
        topic1_2_opr: "and", # The topic operator between topic1 and topic2
        topic2: "", # The third topic filter
        topic2_3_opr: "and", # The topic operator between topic2 and topic3
        topic3: "", # The fourth topic filter
      }
      iex> Etherscan.get_logs(params)
      {:ok, [%Etherscan.Log{}]}
  """
  @spec get_logs(params :: map(), network :: String.t()) :: {:ok, list(Log.t())} | {:error, atom()}
  def get_logs(params, network \\ :default)
  def get_logs(%{address: address}, network) when not is_address(address), do: @error_invalid_address

  def get_logs(%{fromBlock: from_block}, network)
      when not (is_integer(from_block) or from_block == "latest"),
      do: @error_invalid_from_block

  def get_logs(%{toBlock: to_block}, network) when not (is_integer(to_block) or to_block == "latest"),
    do: @error_invalid_to_block

  def get_logs(%{topic0_1_opr: operator}, network) when operator not in @operators,
    do: @error_invalid_topic0_1_opr

  def get_logs(%{topic1_2_opr: operator}, network) when operator not in @operators,
    do: @error_invalid_topic1_2_opr

  def get_logs(%{topic2_3_opr: operator}, network) when operator not in @operators,
    do: @error_invalid_topic2_3_opr

  def get_logs(params, network) when is_map(params) do
    params = merge_params(params, @get_logs_default_params)

    "logs"
    |> get("getLogs", params, network)
    |> parse(as: %{"result" => [%Log{}]})
    |> wrap(:ok)
  end

  def get_logs(_, _), do: @error_invalid_params
end
