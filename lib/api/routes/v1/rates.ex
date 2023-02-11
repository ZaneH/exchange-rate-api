defmodule ExchangeRate.Api.Routes.V1.Rates do
  use Plug.Router

  alias ExchangeRate.Api.Util
  alias ExchangeRate.Currency.Cache

  plug(:match)
  plug(:dispatch)

  get "/" do
    conn
    |> Util.respond({:ok})
  end

  get "/:currency" do
    currencies = conn.params["currency"] |> String.split(",")

    try do
      rates =
        Enum.map(currencies, fn currency ->
          {currency, Cache.get(currency)}
        end)
        |> Enum.into(%{})
        |> Map.new(fn {k, v} -> {String.downcase(k), v} end)
        |> Map.filter(fn {_k, v} -> v != nil end)

      conn |> Util.respond({:ok, rates})
    rescue
      _ ->
        conn |> Util.respond({:error, "Unable to fetch currency data"})
    end
  end
end
