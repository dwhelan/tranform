defmodule Transform.Struct do
  def transform(source, target) when is_atom(target) do
    transform source, struct(target)
  end

  def transform(source, target = %{__struct__: _}) do
    Transform.Map.transform source, target, &target_key/1
  end

  defp target_key(key) when is_atom(key),   do: key
  defp target_key(key) when is_binary(key), do: String.to_atom(key)
end
