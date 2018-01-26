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

  def transform(string, :date, options) when is_binary(string) do
    Timex.Parse.DateTime.Parser.parse(string, options)
  end

  def primitive?(target) do
    Ecto.Type.primitive? target
  end
end
