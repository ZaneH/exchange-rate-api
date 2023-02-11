defmodule ExchangeRate do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      Plug.Cowboy.child_spec(scheme: :http, plug: ExchangeRate.Api.Router, options: [port: 4000]),
      {
        ConCache,
        [
          name: :api_cache,
          global_ttl: :timer.minutes(60),
          ttl_check_interval: :timer.minutes(5)
        ]
      }
    ]

    opts = [strategy: :one_for_one, name: ExchangeRate.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
