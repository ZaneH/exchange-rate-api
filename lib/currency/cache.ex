require Logger

defmodule ExchangeRate.Currency.Cache do
  @moduledoc """
  The Cache module is responsible for caching currency data.
  """

  alias ExchangeRate.Currency.Fetch

  @spec get(String.t()) :: {:ok, any} | {:error, String.t()}
  def get(currency) do
    ConCache.get_or_store(:api_cache, currency, fn ->
      Logger.info("Fetching currency data. No cache hit for #{currency}")

      case Fetch.fetch_rates_map() do
        {:ok, data} ->
          Enum.each(data, fn {currency, rate} ->
            set(currency, rate)
          end)

          data[currency]

        {:error, message} ->
          raise message
      end
    end)
  end

  @spec set(String.t(), any) :: :ok
  def set(currency, data) do
    ConCache.put(:api_cache, currency, data)
  end
end
