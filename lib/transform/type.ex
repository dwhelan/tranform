defmodule Transform.Type do
  # TODO: make Ecto.Type pluggable
  require Ecto.Type
  require Timex

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
  """
  
  def transform(nil, _) do
    {:ok, nil}
  end
  
  def transform(integer, :integer) when is_integer(integer) do
    {:ok, integer}
  end
  
  def transform(integer, :datetime) when is_integer(integer) do
    DateTime.from_unix(integer)
  end

  def transform(integer, :time) when is_integer(integer) do
    {:ok, datetime} = DateTime.from_unix(integer)
    Time.from_erl({datetime.hour, datetime.minute, datetime.second})
  end

  def transform(integer, :naive_datetime) when is_integer(integer) do
    {:ok, datetime} = DateTime.from_unix(integer)
    NaiveDateTime.from_erl({
      {datetime.year, datetime.month,  datetime.day},
      {datetime.hour, datetime.minute, datetime.second}
    })
  end

  def transform(float, :integer) when is_float(float) do
    {:ok, trunc(float)}
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

  def transform(any, :string) do
    {:ok, to_string(any)}
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

  def transform(value, :currency) when is_binary(value) do
    {:ok, decimal} = transform(value, :decimal)
    transform(decimal, :currency)
  end

  def transform(value, :currency) do
    transform(value, :currency, format: "$#,##0.##")
  end

  def transform(source, :datetime) do
    Ecto.Type.cast(:utc_datetime, source)
  end

  def transform(source, target) do
    Ecto.Type.cast(target, source)
  end

  # With formats and locale
  @default_opts [locale: "en"]

  def transform(value, transformation, options)

  def transform(value, :string, options = [format: format]) when is_list(format) do
    IO.inspect 1
    transform(value, :string, localize_format(options))
  end

  def transform(value, :string, opts) when is_list(opts)do
    opts = localize_format(opts)
    Timex.Format.DateTime.Formatter.lformat value, opts[:format], opts[:locale]
  end
 
  def transform(string, :date, options) when is_binary(string) and is_list(options) do
    IO.inspect 4
    {:ok, naive_datetime} = transform string, :naive_datetime, options
    transform naive_datetime, :date
  end
 
  def transform(string, :naive_datetime, options) when is_binary(string) and is_list(options) do
    IO.inspect 5
    Timex.Parse.DateTime.Parser.parse(string, options[:format])
  end
 
  def transform(string, :currency, options) when is_binary(string) do
    IO.inspect 6
    {:ok, decimal} = transform(string, :decimal)
    transform(decimal, :currency, options)
  end

  def transform(number, :currency, options) when is_list(options) do
    IO.inspect :type7
    Cldr.Number.to_string(number, options) |> replace_non_breaking_spaces
  end

  ## On the death march

  # def transform(value, :string, format, locale) when is_binary(format) do
  #   IO.inspect 91
  #   Timex.Format.DateTime.Formatter.lformat value, format, locale
  # end

  def transform(string, :date, format) when is_binary(string) and is_binary(format) do
    IO.inspect 92
    {:ok, naive_datetime} = transform(string, :naive_datetime, format)
    transform(naive_datetime, :date)
  end
 
  def transform(string, :naive_datetime, format) when is_binary(string) and is_binary(format) do
    IO.inspect 93
    Timex.Parse.DateTime.Parser.parse(string, format)
  end

  def transform(value, :currency, format, locale) when is_binary(value) do
    IO.inspect 94
    {:ok, decimal} = transform(value, :decimal)
    transform(decimal, :currency, format, locale)
  end

  def transform(number, :currency, format, locale) do
    IO.inspect 95
    Cldr.Number.to_string(number, format: format, locale: locale) |> replace_non_breaking_spaces
  end

  ## the death match is over

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
