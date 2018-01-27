defmodule Transform.Type do
  # TODO: make Ecto.Type pluggable
  require Ecto.Type
  require Timex

  @moduledoc """
  The following Ecto data types are supported:
  * :integer
  * :binary (also :string)
  * :float
  * :decimal
  * :boolean
  * :date
  * :naive_datetime
  * :time

  The following Ecto types not supported:
  * :utc_datetime_usec
  * :naive_datetime_usec
  * :time_usec
  """
  def transform(source, target) when target in [:string, :binary] do
    {:ok, to_string(source)}
  end

  def transform(source, target) do
    Ecto.Type.cast(target, source)
  end

  def transform(string, :date, options) when is_binary(string) and is_map(options) do
    parse_option  = hd(Map.keys(options))
    {:ok, value} = transform(string, :date, parse_option)
    format_option = hd(Map.values(options))

    Timex.Format.DateTime.Formatter.format(value, format_option)
  end

  def transform(string, :date, options) when is_binary(string) and is_binary(options) do
    Timex.Parse.DateTime.Parser.parse(string, options)
  end

  def primitive?(target) do
    Ecto.Type.primitive? target
  end
end
