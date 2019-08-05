defmodule Etherscan do
  @moduledoc """
  Documentation for Etherscan.
  """

  alias Etherscan.API

  defdelegate get_balance(address, network), to: API.Accounts
  defdelegate get_balances(addresses, network), to: API.Accounts
  defdelegate get_transactions(address, network), to: API.Accounts
  defdelegate get_transactions(address, params, network), to: API.Accounts
  defdelegate get_ERC20_transactions(address, network), to: API.Accounts
  defdelegate get_ERC20_transactions(address, params, network), to: API.Accounts
  defdelegate get_internal_transactions(address, network), to: API.Accounts
  defdelegate get_internal_transactions(address, params, network), to: API.Accounts
  defdelegate get_internal_transactions_by_hash(transaction_hash, network), to: API.Accounts
  defdelegate get_blocks_mined(address, network), to: API.Accounts
  defdelegate get_blocks_mined(address, params, network), to: API.Accounts
  defdelegate get_uncles_mined(address, network), to: API.Accounts
  defdelegate get_uncles_mined(address, params, network), to: API.Accounts
  defdelegate get_token_balance(address, token_address, network), to: API.Accounts

  defdelegate get_block_and_uncle_rewards(block_number, network), to: API.Blocks

  defdelegate get_contract_abi(address, network), to: API.Contracts
  defdelegate get_contract_source(address, network), to: API.Contracts

  defdelegate get_logs(params, network), to: API.Logs

  defdelegate eth_block_number(network), to: API.Proxy
  defdelegate eth_get_block_by_number(tag, network), to: API.Proxy
  defdelegate eth_get_uncle_by_block_number_and_index(tag, index, network), to: API.Proxy
  defdelegate eth_get_block_transaction_count_by_number(tag, network), to: API.Proxy
  defdelegate eth_get_transaction_by_hash(transaction_hash, network), to: API.Proxy
  defdelegate eth_get_transaction_by_block_number_and_index(tag, index, network), to: API.Proxy
  defdelegate eth_get_transaction_count(address, network), to: API.Proxy
  defdelegate eth_send_raw_transaction(hex, network), to: API.Proxy
  defdelegate eth_get_transaction_receipt(transaction_hash, network), to: API.Proxy
  defdelegate eth_call(to, data, network), to: API.Proxy
  defdelegate eth_get_code(address, tag, network), to: API.Proxy
  defdelegate eth_get_storage_at(address, position, network), to: API.Proxy
  defdelegate eth_gas_price(network), to: API.Proxy
  defdelegate eth_estimate_gas(params, network), to: API.Proxy

  defdelegate get_token_supply(token_address, network), to: API.Stats
  defdelegate get_eth_supply(network), to: API.Stats
  defdelegate get_eth_price(network), to: API.Stats

  defdelegate get_contract_execution_status(transaction_hash, network), to: API.Transactions
  defdelegate get_transaction_receipt_status(transaction_hash, network), to: API.Transactions
end
