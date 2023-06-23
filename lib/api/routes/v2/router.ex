defmodule ExchangeRate.Api.Routes.V2 do
  alias ExchangeRate.Api.Util
  alias ExchangeRate.Api.Routes.V2.Rates

  use Plug.Router

  plug(:match)
  plug(:dispatch)

  forward("/rates", to: Rates)

  match _ do
    Util.not_found(conn)
  end
end
