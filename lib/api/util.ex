defmodule ExchangeRate.Api.Util do
  import Plug.Conn
  use Number

  def respond(conn, {:ok}) do
    conn
    |> send_resp(200, Poison.encode!(%{status: "ok"}))
  end

  def respond(conn, {:ok, message}) do
    conn
    |> send_resp(200, message)
  end

  def respond(conn, {:error, message}) do
    conn
    |> send_resp(200, message)
  end

  def not_found(conn) do
    conn
    |> send_resp(404, Poison.encode!(%{status: "not found"}))
  end
end
