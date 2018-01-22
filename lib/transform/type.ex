defmodule Transform.Type do
  # TODO: make Ecto.Type pluggable
  require Ecto.Type

  def transform(value, atom) when atom in [:string, :binary] do
    {:ok, to_string(value)}
  end

  def transform(value, type) do
    Ecto.Type.cast(type, value)
  end  
end
