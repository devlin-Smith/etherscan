defmodule Etherscan.API.Stats do
  @moduledoc """
  Module to wrap Etherscan stats endpoints.

  [Etherscan API Documentation](https://etherscan.io/apis#stats)
  """

  use Etherscan.API
  use Etherscan.Constants

  @doc """
  Get total supply of ether.

  ## Example

      iex> Etherscan.get_eth_supply()
      {:ok, #{@test_eth_supply}}
  """
  @spec get_eth_supply :: {:ok, non_neg_integer()}
  def get_eth_supply(network \\ :default) do
    "stats"
    |> get("ethsupply", %{}, network)
    |> parse()
    |> format_balance()
    |> wrap(:ok)
  end

  @doc """
  Get ether price.

  ## Example

      iex> Etherscan.get_eth_price()
      {:ok, %{"ethbtc" => #{@test_eth_btc_price}, "ethusd" => #{@test_eth_usd_price}}}
  """
  @spec get_eth_price :: {:ok, map()}
  def get_eth_price(network \\ :default) do
    "stats"
    |> get("ethprice", %{}, network)
    |> parse()
    |> wrap(:ok)
  end

  @doc """
  Get total supply of ERC20 token, by `token_address`.

  [More Info](https://etherscan.io/apis#tokens)

  ## Example

      iex> Etherscan.get_token_supply("#{@test_token_address}")
      {:ok, #{@test_token_supply}}
  """
  @spec get_token_supply(token_address :: String.t()) ::
          {:ok, non_neg_integer()} | {:error, atom()}
  def get_token_supply(token_address, network \\ :default)
  def get_token_supply(token_address, network) when is_address(token_address) do
    "stats"
    |> get("tokensupply", %{contractaddress: token_address}, network)
    |> parse()
    |> String.to_integer()
    |> wrap(:ok)
  end

  def get_token_supply(_, _), do: @error_invalid_token_address
end
