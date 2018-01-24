defmodule Transform.Struct do
  def transform(source, target) when is_atom(target) do
    transform source, struct(target)
  end

  def transform(source, target = %{__struct__: _}) do
    source
    |> Map.keys
    |> reject_meta_keys
    |> copy_values(source, target)
  end

  defp reject_meta_keys keys do
    Enum.reject keys, &meta_key?(&1)
  end

  defp meta_key?(key) when is_atom(key),   do: meta_key? Atom.to_string(key)
  defp meta_key?(key) when is_binary(key), do: Regex.match? ~r/^__/, key
  defp meta_key?(_),                       do: true

  defp copy_values(keys, source, target) do
    Enum.reduce(keys, target, fn key, target -> copy_value(key, source, target) end)
  end

  defp copy_value(key, source, target) do
    Map.put(target, to_atom(key), Map.get(source, key))
  end

  defp to_atom(key) when is_atom(key), do: key
  defp to_atom(key),                   do: String.to_atom(key)
end
