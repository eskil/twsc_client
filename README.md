# TwscClient

**TODO: Add description**

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

# CLI

```
mix escript.build
```

```
./twsc_client reservations --login=<user> --password=<password>
```

```
./twsc_client available --login=<user> --password=<password> "
./twsc_client available --login=<user> --password=<password> --fleet=Gold --start-date="2018-05-01"
```