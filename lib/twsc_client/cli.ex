defmodule TwscCli do
  @moduledoc """
  twsc_client reads tradewinds sailing school & club boat availability.

  'reservations' to download from tradewinds.
    --login=<tradewinds username>
    --password=<tradewinds password>

  'available' to download from tradewinds.
    --login=<tradewinds username>
    --password=<tradewinds password>
    [--start-date="YYYY-MM-DD"]
    [--fleet=Copper|Bronze|Silver|Gold|Platinum]
  """

  def main(args) do
    args |> parse_args |> process
  end

  defp help() do
    IO.puts @moduledoc
    System.halt(0)
  end

  defp parse_args(args) do
    {options, args, invalid} = OptionParser.parse(
      args,
      strict: [
        login: :string,
        password: :string,
        help: :boolean,
        fleet: :string,
        start_date: :string
      ],
      aliases: [h: :help]
    )
    case options[:help] do
      true  -> help()
      _ -> {options, args, invalid}
    end
  end

  def process({options, ["reservations"], _invalid}) do
    {:ok, session} = TwscClient.login(options[:login], options[:password])
    {:ok, reservations} = TwscClient.reservations(session)
    IO.inspect(reservations)
  end

  def process({options, ["available"], _invalid}) do
    {:ok, session} = TwscClient.login(options[:login], options[:password])
    {:ok, available} = TwscClient.available_boats(session, options)
    IO.inspect(available)
  end

  def process({_options, _commands, _invalid}) do
    IO.puts "Unknown/missing command see --help"
    System.halt(0)
  end
end
