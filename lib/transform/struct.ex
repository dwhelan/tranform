defmodule Transform.Struct do
  def transform(source, target) when is_atom(target) do
    transform source, struct(target)
  end

  def transform(source, target = %{__struct__: _}) do
    source
    |> Map.keys
    |> Transform.Map.reject_meta_keys
    |> copy_values(source, target)
  end

  defp copy_values(keys, source, target) do
    Enum.reduce(keys, target, fn key, target -> copy_value(key, source, target) end)
  end

  defp copy_value(key, source, target) do
    Map.put(target, to_atom(key), Map.get(source, key))
  end

  defp to_atom(key) when is_atom(key), do: key
  defp to_atom(key),                   do: String.to_atom(key)
end
