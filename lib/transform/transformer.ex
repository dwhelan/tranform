defmodule Transform.Transformer do
  alias Transform.Type

  def transform(nil, _) do
    {:ok, nil}
  end

  def transform(value, transform) when transform in [:string, :date] do
    Type.transform(value, transform)
  end

  def transform(value, mod) when is_atom(mod) do
    transform value, mod.__transform__(:transforms), locale(value, mod)
  end

  def transform(value, transform, locale \\ "en") 

  def transform(nil, _, _) do
    {:ok, nil}
  end

  def transform(value, transforms, locale) when is_list(transforms) and is_binary(locale) do
    Enum.reduce transforms, value, &transform(&2, &1, locale)
  end  

  def transform(map, {key, transforms}, locale) when is_map(map) and is_list(transforms) do
    transform(map, key, transforms, locale)
  end  

  def transform(value, transforms, locale) when is_list(transforms) do
    Enum.reduce transforms, value, &transform(&2, &1, locale)
  end  

  def transform(value, {transform, options}, locale) do
    Type.transform(value, transform, options, locale)
  end

  def transform(value, transform, locale) when is_atom(transform) do
    Type.transform(value, transform, locale)
  end

  def transform(map, key, transforms, locale) when is_map(map) and is_list(transforms) do
    Enum.reduce(transforms, map, fn transform, input ->
      {:ok, value} = transform(Map.get(input, key), transform, locale)
      Map.put(input, key, value)
    end)
  end

  def transform(value, transform, options, locale) do
    Type.transform(value, transform, options, locale)
  end

  defp locale(map, mod) do
    locale = mod.__transform__(:locale)
    extract_out_locale(map, locale)
  end

  defp extract_out_locale(map, atom) when is_atom(atom) do
    Map.get(map, atom)
  end

  defp extract_out_locale(map, locale) when is_tuple(locale) do
    locale_key = Map.get(map, elem(locale, 0))
    elem(locale, 1)
    |> Enum.find(fn {key, _} -> to_string(key) == locale_key end)
    |> elem(1)
  end

  defp extract_out_locale(_map, locale) when is_list(locale) do
    locale[:out]
  end
end
