defmodule ExchangeRate.Api.Util do
  import Plug.Conn

  def respond(conn, {:ok}) do
    conn
    |> send_resp(200, Poison.encode!(%{status: "ok"}))
  end

  def respond(conn, {:ok, data}) do
    conn
    |> send_resp(200, Poison.encode!(%{status: "ok", data: data}))
  end

  def respond(conn, {:error, message}) do
    conn
    |> send_resp(400, Poison.encode!(%{status: "error", message: message}))
  end

  def not_found(conn) do
    conn
    |> send_resp(404, Poison.encode!(%{status: "not found"}))
  end
end
