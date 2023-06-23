defmodule ExchangeRate.Api.Router do
  alias ExchangeRate.Api.Util
  alias ExchangeRate.Api.Routes.V1
  alias ExchangeRate.Api.Routes.V2

  use Plug.Router

  plug(
    Corsica,
    origins: "*",
    max_age: 600,
    allow_methods: :all,
    allow_headers: :all
  )

  plug(:match)
  plug(:dispatch)

  forward("/v1", to: V1)
  forward("/v2", to: V2)

  match _ do
    Util.not_found(conn)
  end
end
