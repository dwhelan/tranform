defmodule Transform do
  def transform(type, value) when is_atom(type) do
    Transform.Type.transform(type, value)
  end
end
