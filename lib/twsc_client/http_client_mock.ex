defmodule TwscClient.HttpClientMock do

  def login(_, "valid") do
    %{
      status_code: 200,
      headers: %{"set-cookie" => ["cookie", "PHPSESSID=valid-session-id"]}
    }
  end

  def login(_, _) do
    # TODO: what is the actual error code returned by TWSC?
    %{ status_code: 404 }
  end

  def logout("valid-session-id") do
    %{ status_code: 200 }
  end

  def logout(_) do
    # TODO: what is the actual error code returned by TWSC?
    %{ status_code: 404 }
  end

  def reservations("valid-session-id") do
    %{
      status_code: 200,
      body: """
            {
              "Answerkey":
              [
                {
                  "begins": "2018-02-03T09:00:00",
                  "boat_code": "3504",
                  "boat_fleet": "Silver",
                  "boat_info_test": "6",
                  "boat_mode": "CT3504",
                  "boat_name": "White Wing",
                  "boat_size": "6",
                  "end_date_time": "Saturday February 3 9pm",
                  "slip": "D-106",
                  "start_date_time": "Saturday February 3 9am",
                  "venue_code": "1",
                  "venue_name": "Pt Richmond"
                }
              ],
              "ErrorCode": 0,
              "Message": "These are your reserved boats"
           }
           """
    }
  end
end
