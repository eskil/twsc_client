defmodule TwscClientTest do
  use ExUnit.Case
  doctest TwscClient

  test "successful login" do
    assert {:ok, _} = TwscClient.login("test_user", "valid")
  end

  test "failed login" do
    assert :error = TwscClient.login("test_user", "invalid")
  end

  test "logout" do
    assert :ok = TwscClient.logout("valid-session-id")
  end

  test "reservations" do
    {:ok, result} = TwscClient.reservations("valid-session-id")
    message = result["Message"]
    reservations = result["Answerkey"]
    assert message == "These are your reserved boats"
    assert Enum.count(reservations) == 1
    reservation = Enum.at(reservations, 0)
    assert reservation == %{
      "begins" => "2018-02-03T09:00:00",
      "boat_code" => "3504",
      "boat_fleet" => "Silver",
      "boat_info_test" => "6",
      "boat_mode" => "CT3504",
      "boat_name" => "White Wing",
      "boat_size" => "6",
      "end_date_time" => "Saturday February 3 9pm",
      "slip" => "D-106",
      "start_date_time" => "Saturday February 3 9am",
      "venue_code" => "1",
      "venue_name" => "Pt Richmond"
    }
  end
end
