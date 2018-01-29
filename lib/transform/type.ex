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
  * :datetime

  The following Ecto types not supported:
  * :datetime_usec
  * :naive_datetime_usec
  * :time_usec
  """
  
  def transform(nil, _) do
    {:ok, nil}
  end
  
  def transform(any, target) when target in [:string, :binary] do
    {:ok, to_string(any)}
  end
  
  def transform(integer, :integer) when is_integer(integer) do
    {:ok, integer}
  end
  
  def transform(integer, :datetime) when is_integer(integer) do
    DateTime.from_unix(integer)
  end

  def transform(datetime, :time) when is_integer(datetime) do
    {:ok, datetime} = DateTime.from_unix(datetime)
    Time.from_erl({datetime.hour, datetime.minute, datetime.second})
  end

  def transform(datetime, :naive_datetime) when is_integer(datetime) do
    {:ok, datetime} = DateTime.from_unix(datetime)
    NaiveDateTime.from_erl({
      {datetime.year, datetime.month,  datetime.day},
      {datetime.hour, datetime.minute, datetime.second}
    })
  end

  def transform(source, :integer) when is_float(source) do
    {:ok, trunc(source)}
  end

  def transform(source=%Decimal{}, :integer) do
    {:ok, Decimal.to_integer(source)}
  end

  def transform(source=%Decimal{}, :float) do
    {:ok, Decimal.to_float(source)}
  end

  def transform(source=%Decimal{}, :boolean) do
    {:ok, !Decimal.equal?(source, Decimal.new(0))}
  end

  def transform(source, :boolean) when is_binary(source) do
    {:ok, source !== "false"}
  end

  def transform(source, :boolean) when is_integer(source) or is_float(source) do
    {:ok, source != 0}
  end

  def transform(source, :integer) when is_boolean(source) do
    {:ok, (if source, do: 1, else: 0)}
  end

  def transform(source, :float) when is_boolean(source) do
    {:ok, (if source, do: 1.0, else: 0.0)}
  end

  def transform(source, :decimal) when is_boolean(source) do
    {:ok, (if source, do: Decimal.new(1), else: Decimal.new(0))}
  end

  def transform(value = %Date{}, :naive_datetime) do
    NaiveDateTime.new(value, ~T[00:00:00])
  end

  def transform(value = %Date{}, :datetime) do
    {:ok, naive_datetime} = transform(value, :naive_datetime)
    DateTime.from_naive naive_datetime, "Etc/UTC"
  end

  def transform(_value = %Date{}, :time) do
    {:ok, ~T[00:00:00]}
  end

  def transform(source, :datetime) do
    Ecto.Type.cast(:utc_datetime, source)
  end

  def transform(source, target) do
    Ecto.Type.cast(target, source)
  end

  # With options

  def transform(value, transformation, options, locale \\ "en")

  def transform(value = %NaiveDateTime{}, :string, options, locale) when is_binary(options) do
    Timex.Format.DateTime.Formatter.lformat(value, options, locale)
  end
 
  def transform(value = %Date{}, :string, options, locale) when is_binary(options) do
    Timex.Format.DateTime.Formatter.lformat(value, options, locale)
  end
 
  def transform(string, :date, options, _locale) when is_binary(string) and is_binary(options) do
    {:ok, naive_datetime} = transform(string, :naive_datetime, options)
    transform(naive_datetime, :date)
  end
 
  def transform(string, :naive_datetime, options, _locale) when is_binary(string) and is_binary(options) do
    Timex.Parse.DateTime.Parser.parse(string, options)
  end


  def primitive?(target) do
    Ecto.Type.primitive? target
  end
end
