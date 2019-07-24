defmodule Etherscan.BlocksTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  use Etherscan.Constants
  alias Etherscan.{BlockReward, BlockRewardUncle}

  setup_all do
    HTTPoison.start()
    :ok
  end

  describe "get_block_and_uncle_rewards/1" do
    test "returns a block reward struct" do
      use_cassette "get_block_and_uncle_rewards" do
        response = Etherscan.get_block_and_uncle_rewards(@test_block_number, nil)
        assert {:ok, reward} = response
        assert %BlockReward{} = reward
      end
    end

    test "inclues block reward uncle structs" do
      use_cassette "get_block_and_uncle_rewards" do
        response = Etherscan.get_block_and_uncle_rewards(@test_block_number, nil)
        assert {:ok, %BlockReward{uncles: uncles}} = response
        assert [%BlockRewardUncle{} | _] = uncles
      end
    end

    test "with invalid block number" do
      response = Etherscan.get_block_and_uncle_rewards(-5, nil)
      assert {:error, :invalid_block_number} = response
      response = Etherscan.get_block_and_uncle_rewards("fake block", nil)
      assert {:error, :invalid_block_number} = response
    end
  end
end
