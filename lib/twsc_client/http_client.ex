defmodule TwscClient.HttpClient do
  use HTTPotion.Base
  alias TwscClient.HttpClient

  defp process_url(url) do
    "http://www.tradewindssailing.com" <> url
  end

  def login(username, password) do
    HttpClient.get!(
      "/app/wsdl/Logon-action_Mob.php",
      [
        query: %{
          userid: URI.encode_www_form(username),
          pwd: URI.encode_www_form(password)
        },
      ]
    )
  end

  def logout(_session_id) do
    # TODO: get a logout request via mitm
    :ok
  end

  def reservations(session_id) do
    HttpClient.get("/app/wsdl/Reservations_Mob.php",
      [headers: [cookie: session_id], timeout: 20000, follow_redirects: false])
  end

  def available_boats(session_id, start_date, fleet) do
    query = [
      "StartDate": start_date,
      "fleet": fleet
    ]
    HttpClient.get("/app/wsdl/Availability_Mob.php",
      [
        headers: [cookie: session_id],
        query: query,
        timeout: 20000,
        follow_redirects: false
      ])
  end
end
