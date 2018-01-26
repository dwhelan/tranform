defmodule Transform.Type do
  # TODO: make Ecto.Type pluggable
  require Ecto.Type
  require Timex

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
