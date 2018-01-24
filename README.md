# TwscClient

Client for Tradewinds Sailing School & Club's reservation system.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `twsc_client` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:twsc_client, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/twsc_client](https://hexdocs.pm/twsc_client).

## Examples

You can read reservations.

```elixir
{:ok, session} = TwscClient.login(login, password)
{:ok, reservations} = TwscClient.reservations(session)
IO.inspect(reservations)
```

```elixir
%{
  "Answerkey" => [
    %{
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
  ],
  "ErrorCode" => 0,
  "Message" => "These are your reserved boats"
}
```

You can see available boats.

***Note: this will

```elixir
{:ok, session} = TwscClient.login(login, password)
{:ok, available} = TwscClient.available_boats(session, [start_date: "2018-01-27", fleet: "Silver"])
IO.inspect(available)
```

```elixir
%{
  "Answerkey" => [
    %{
      "boat_name" => "Megalina",
       "data" => [
        %{
          "boat_status" => %{"first" => false, "second" => false, "third" => false},
          "date" => "01/27/2018"
        },
        %{
          "boat_status" => %{"first" => true, "second" => true, "third" => false},
          "date" => "01/28/2018"
        },
        %{
          "boat_status" => %{"first" => false, "second" => false, "third" => false},
          },
          "date" => "01/29/2018"
        },
	...
      ],
      "last_fleet" => "Silver"
    },
    %{
      "boat_name" => "Orion",
      "data" => [
        %{
          "boat_status" => %{"first" => true, "second" => true, "third" => false},
          "date" => "01/27/2018"
        },
	...
      "last_fleet" => "Silver"
    }
  ],
  "ErrorCode" => 0,
  "Message" => "Data Loaded Successfully"
}
```

Where `first`, and `second` map to the 9am-9pm, 9pm-9am spots. `third`
seems to always be false.

## CLI

```sh
mix escript.build
```

```sh
./twsc_client reservations --login=<user> --password=<password>
```

```sh
./twsc_client available --login=<user> --password=<password> "
./twsc_client available --login=<user> --password=<password> --fleet=Gold --start-date="2018-05-01"
```