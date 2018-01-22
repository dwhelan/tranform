defmodule Transform.Type do
  # TODO: make Ecto.Type pluggable
  require Ecto.Type

  def transform(atom, value) when atom in [:string, :binary] do
    {:ok, to_string(value)}
  end

  def transform(type, value) do
    Ecto.Type.cast(type, value)
  end  
end
