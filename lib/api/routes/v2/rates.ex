defmodule ExchangeRate.Api.Routes.V2.Rates do
  use Plug.Router

  alias ExchangeRate.Api.Util
  alias ExchangeRate.Currency.Cache

  plug(:match)
  plug(:dispatch)

  get "/" do
    conn
    |> Util.respond({:ok})
  end

  get "/:currency/:amount" do
    currency = conn.params["currency"]
    {amount, _} = conn.params["amount"] |> Float.parse()

    try do
      rate = Cache.get(currency)
      value = amount / rate

      message =
        "#{Number.Currency.number_to_currency(amount, format: "%n", unit: "")} #{String.upcase(currency)} = #{Number.Currency.number_to_currency(value)} USD"

      conn |> Util.respond({:ok, message})
    rescue
      _ ->
        conn |> Util.respond({:error, "Something went wrong. Try !convert currency amount"})
    end
  end
end