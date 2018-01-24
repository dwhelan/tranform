defmodule Transform do
  alias Transform.Type

  def transform(source, target) when is_atom(target) do
    if Type.primitive?(target) do 
      Type.transform source, target
    else # a module
      Transform.Struct.transform source, target
    end
  end

  def transform(source, target = %{__struct__: _}) do
    Transform.Struct.transform source, target
  end
end
