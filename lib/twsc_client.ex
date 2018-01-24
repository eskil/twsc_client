defmodule TwscClient do
  @moduledoc """
  Client for accessing reservations, and eventually check avilability and make reservations.
  """

  require Logger

  @http_client Application.get_env(:twsc_client, :http_client) || TwscClient.HttpClient

  @doc """
  Login using the given name and password, which are TWSC reservations system credentials.
  """
  def login(username, password) do
    case @http_client.login(username, password) do
      %{status_code: 200, headers: headers} ->
        session_id = find_session_id(headers["set-cookie"])
        {:ok, session_id}
      response ->
        Logger.warn "[TwscClient] Login Failed"
        Logger.warn "Response #{inspect response}"
        :error
    end
  end

  def logout(session_id) do
    @http_client.logout(session_id)
    :ok
  end

  def reservations(session_id) do
    case @http_client.reservations(session_id) do
      %{status_code: 200, body: body} ->
	Poison.decode(body)
      response ->
        Logger.warn "[TwscClient] Cannot get reservations"
        Logger.warn "Response #{inspect response}"
        :error
    end
  end

  def available_boats(session_id, options \\ []) do
    start_date = Keyword.get(options, :start_date,
      Timex.format!(Timex.now, "%Y-%m-%d", :strftime))
    fleet = Keyword.get(options, :fleet, "Silver")

    case @http_client.available_boats(session_id, start_date, fleet) do
      %{status_code: 200, body: body} ->
	Poison.decode(body)
      response ->
        Logger.warn "[TwscClient] Cannot get available boats"
        Logger.warn "Response #{inspect response}"
        :error
    end
  end

  defp find_session_id(headers) do
    Enum.filter(headers, &String.starts_with?(&1, "PHPSESSID"))
    |> List.first
  end
end
