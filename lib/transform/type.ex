defmodule Transform.Type do
  # TODO: make Ecto.Type pluggable
  require Ecto.Type

  def transform(source, target) when target in [:string, :binary] do
    {:ok, to_string(source)}
  end

  def transform(source, target) do
    Ecto.Type.cast(target, source)
  end
  
  def primitive?(target) do
    Ecto.Type.primitive? target
  end
end
