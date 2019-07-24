defmodule Etherscan.API.Contracts do
  @moduledoc """
  Module to wrap Etherscan contract endpoints.

  [Etherscan API Documentation](https://etherscan.io/apis#contracts)
  """

  use Etherscan.API
  use Etherscan.Constants

  @doc """
  Get contract ABI for contracts with verified source code, by `address`.

  [More Info](https://etherscan.io/contractsVerified)

  ## Example

      iex> Etherscan.get_contract_abi("#{@test_contract_address}")
      {:ok, [%{"name" => _, ...} | _] = contract_abi}
  """
  @spec get_contract_abi(address :: String.t(), network :: String.t()) :: {:ok, list()} | {:error, atom()}
  def get_contract_abi(address, network \\ :default)
  def get_contract_abi(address, network) when is_address(address) do
    "contract"
    |> get("getabi", %{address: address}, network)
    |> parse()
    # Decode again. ABI result is JSON
    |> Poison.decode!()
    |> wrap(:ok)
  end

  def get_contract_abi(_, _), do: @error_invalid_address

  @doc """
  Get contract source code for contacts with verified source code

  [More Info](https://etherscan.io/contractsVerified)

      iex> Etherscan.get_contract_source("#{@test_contract_address}")
      {:ok, [%{"name" => _, ...} | _] = contract_source}
  """
  def get_contract_source(address, network \\ :default)
  def get_contract_source(address, network) when is_address(address) do
    "contract"
    |> get("getsourcecode", %{address: address}, network)
    |> parse()
    |> wrap(:ok)
  end

  def get_contract_source(_, _), do: @error_invalid_address
end
