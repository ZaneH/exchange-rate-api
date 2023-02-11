defmodule ExchangeRate.Currency.Fetch do
  @moduledoc """
  The Fetch module is responsible for fetching currency data from the API.
  """

  @spec fetch_rates_map :: {:ok, any} | {:error, String.t()}
  def fetch_rates_map do
    {:ok, response} = HTTPoison.get("https://open.er-api.com/v6/latest/USD")

    case response do
      %{status_code: 200, body: body} ->
        try do
          json = Poison.decode!(body)
          {:ok, json_rates_to_map(json)}
        rescue
          _ ->
            {:error, "Unable to decode currency data"}
        end

      _ ->
        {:error, "Unable to fetch currency data"}
    end
  end

  defp json_rates_to_map(json) do
    json
    |> Map.get("rates")
    |> Map.new(fn {k, v} -> {String.downcase(k), v} end)
  end
end
