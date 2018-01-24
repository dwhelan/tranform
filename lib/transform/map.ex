defmodule Transform.Map do
  def transform(source, target) when is_map(target) do
    source
    |> Map.keys
    |> reject_meta_keys
    |> copy_values(source, target)
  end

  def reject_meta_keys keys do
    Enum.reject keys, &meta_key?(&1)
  end

  defp meta_key?(key) when is_atom(key),   do: meta_key? Atom.to_string(key)
  defp meta_key?(key) when is_binary(key), do: Regex.match? ~r/^__/, key
  defp meta_key?(_),                       do: true

  defp copy_values(keys, source, target) do
    Enum.reduce(keys, target, &copy_value(&1, source, &2))
  end

  defp copy_value(key, source, target) do
    Map.put(target, key, Map.get(source, key))
  end
end
