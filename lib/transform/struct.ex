defmodule Transform.Struct do
  def transform(source, target) when is_atom(target) do
    transform source, struct(target)
  end

  def transform(source, target = %{__struct__: _}) do
    source
    |> Map.keys
    |> remove_meta_keys
    |> copy_values(source, target)
  end

  @does_not_start_with__ ~r/^(?!__).+/

  defp remove_meta_keys keys do
    Enum.filter keys, &keep_key?(&1)
  end

  defp keep_key?(key) when is_atom(key) do
    keep_key? Atom.to_string(key)
  end
  defp keep_key?(key) when is_binary(key) do
    Regex.match?(@does_not_start_with__, key) 
  end
  defp keep_key?(_) do
    true
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
