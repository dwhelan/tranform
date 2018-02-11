defmodule Transform.Type do
  # TODO: make Ecto.Type pluggable
  require Ecto.Type
  require Timex

  @default_opts [locale: "en"]

  @moduledoc """
  The following Ecto data types are supported:
  * :integer
  * :string
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
  * :binary (use :string)
  """
  
  # from nil
  def transform(nil, _) do
    {:ok, nil}
  end
  
  # to :boolean

  def transform(string, :boolean) when is_binary(string) do
    {:ok, string !== "false"}
  end

  def transform(number, :boolean) when is_number(number) do
    {:ok, number != 0}
  end

  def transform(decimal=%Decimal{}, :boolean) do
    {:ok, !Decimal.equal?(decimal, Decimal.new(0))}
  end

  # to :integer

  def transform(boolean, :integer) when is_boolean(boolean) do
    {:ok, (if boolean, do: 1, else: 0)}
  end

  def transform(integer, :integer) when is_integer(integer) do
    {:ok, integer}
  end

  def transform(float, :integer) when is_float(float) do
    {:ok, trunc(float)}
  end

  def transform(decimal=%Decimal{}, :integer) do
    {:ok, Decimal.to_integer(decimal)}
  end

  # to :float

  def transform(boolean, :float) when is_boolean(boolean) do
    {:ok, (if boolean, do: 1.0, else: 0.0)}
  end

  def transform(decimal=%Decimal{}, :float) do
    {:ok, Decimal.to_float(decimal)}
  end

  # to :decimal

  def transform(boolean, :decimal) when is_boolean(boolean) do
    {:ok, (if boolean, do: Decimal.new(1), else: Decimal.new(0))}
  end

  # to :time

  def transform(integer, :time) when is_integer(integer) do
    {:ok, datetime} = DateTime.from_unix(integer)
    Time.from_erl({datetime.hour, datetime.minute, datetime.second})
  end

  # to :date

  # to :datetime

  def transform(integer, :datetime) when is_integer(integer) do
    DateTime.from_unix(integer)
  end

  def transform(date = %Date{}, :datetime) do
    {:ok, naive_datetime} = transform(date, :naive_datetime)
    DateTime.from_naive naive_datetime, "Etc/UTC"
  end

  def transform(value, :datetime) do
    Ecto.Type.cast(:utc_datetime, value)
  end

  # to :naive_datetime

  def transform(integer, :naive_datetime) when is_integer(integer) do
    {:ok, datetime} = DateTime.from_unix(integer)
    NaiveDateTime.from_erl({
      {datetime.year, datetime.month,  datetime.day},
      {datetime.hour, datetime.minute, datetime.second}
    })
  end

  def transform(date = %Date{}, :naive_datetime) do
    NaiveDateTime.new(date, ~T[00:00:00])
  end

  # to :currency

  def transform(string, :currency) when is_binary(string) do
    {:ok, decimal} = transform(string, :decimal)
    transform(decimal, :currency)
  end

  def transform(value, :currency) do
    transform(value, :currency, format: "$#,##0.##")
  end

  # to :string

  def transform(any, :string) do
    {:ok, to_string(any)}
  end

  # default to Ecto type casting

  def transform(source, target) do
    Ecto.Type.cast(target, source)
  end

  # With options

  # to :currency
 
  def transform(string, :currency, options) when is_binary(string) do
    {:ok, decimal} = transform(string, :decimal)
    transform(decimal, :currency, options)
  end

  def transform(number, :currency, options) when is_list(options) do
    Cldr.Number.to_string(number, options) |> replace_non_breaking_spaces
  end

  # to :date

  def transform(string, :date, options) when is_binary(string) and is_list(options) do
    {:ok, naive_datetime} = transform string, :naive_datetime, options
    transform naive_datetime, :date
  end

  # to :naive_datetime
 
  def transform(string, :naive_datetime, options) when is_binary(string) and is_list(options) do
    Timex.Parse.DateTime.Parser.parse(string, options[:format])
  end

  # trim

  def transform(string, :trim, opts) when is_binary(string) and is_list(opts) do
    value = case opts[:format] do
      :all      -> String.trim(string)
      :leading  -> String.trim_leading(string)
      :trailing -> String.trim_trailing(string)
      :none     -> string
    end
    {:ok, value}
  end

  def transform(value, :string, opts) when is_list(opts)do
    opts = localize_format(opts)
    Timex.Format.DateTime.Formatter.lformat value, opts[:format], opts[:locale]
  end

  defp localize_format(opts) do
    opts = Keyword.merge(@default_opts, opts)
    locale = opts[:locale]
    case opts[:format] do
      list when is_list(list) -> Keyword.put(opts, :format, opts[:format][String.to_atom(locale)])
      _ -> opts
    end
  end

  defp replace_non_breaking_spaces({:ok, string}) do
    {:ok, String.replace(string, ~r/\s/u, " ")}
  end

  def primitive?(target) do
    Ecto.Type.primitive? target
  end
end
