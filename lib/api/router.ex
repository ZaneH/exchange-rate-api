defmodule ExchangeRate.Api.Router do
  use Plug.Router

  alias ExchangeRate.Api.Util
  alias ExchangeRate.Api.Routes.V1

  plug(:match)
  plug(:dispatch)

  forward("/v1", to: V1)

  match _ do
    Util.not_found(conn)
  end
end
