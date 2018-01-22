defmodule Transform do
  def transform(value, type) when is_atom(type) do
    Transform.Type.transform(value, type)
  end
end
