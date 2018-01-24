defmodule Transform do
  def transform(value, type) when is_atom(type) do
    Transform.Type.transform value, type
  end

  def transform(source, target = %{__struct__: _}) do
    Transform.Struct.transform source, target
  end
end
