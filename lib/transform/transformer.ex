defmodule Transform.Transformer do
  alias Transform.Type

  def transform(nil, _) do
    {:ok, nil}
  end

  def transform(value, transform) when transform in [:string, :date] do
    IO.inspect :transformer1
    Type.transform(value, transform)
  end

  def transform(value, mod) when is_atom(mod) do
    IO.inspect :transformer2
    transform value, mod.__transform__(:transforms), locale(value, mod)
  end

  def transform(value, transform, locale \\ "en") 

  def transform(nil, _, _) do
    {:ok, nil}
  end

  def transform(value, transforms, locale) when is_list(transforms) and is_binary(locale) do
    IO.inspect :transformer3
    Enum.reduce transforms, value, &transform(&2, &1, locale)
  end  

  def transform(map, {:string, transforms}, locale) when is_map(map) and is_list(transforms) do
    IO.inspect :transformer4
    transform(map, :string, transforms[String.to_atom(locale)], locale)
  end  

  def transform(map, {key, transforms}, locale) when is_map(map) and is_list(transforms) do
    IO.inspect :transformer5
    transform(map, key, transforms, locale)
  end  

  def transform(value, transforms, locale) when is_list(transforms) do
    IO.inspect :transformer6
    Enum.reduce transforms, value, &transform(&2, &1, locale)
  end  

  def transform(value, {transform, format}, locale) do
    IO.inspect :transformer7
    Type.transform(value, transform, format: format, locale: locale)
  end

  def transform(value, transform, locale) when is_atom(transform) do
    IO.inspect :transformer8
    Type.transform(value, transform, locale)
  end

  def transform(map, key, transforms, locale) when is_map(map) and is_list(transforms) do
    IO.inspect :transformer9
    Enum.reduce(transforms, map, fn transform, input ->
      {:ok, value} = transform(Map.get(input, key), transform, locale)
      Map.put(input, key, value)
    end)
  end

  def transform(value, transform, format, locale) do
    IO.inspect :transformer10
    Type.transform(value, transform, format, locale)
  end

  defp locale(map, mod) do
    mod.__transform__(:locale) |> extract_locale(map)
  end

  defp extract_locale(atom, map) when is_atom(atom) do
    Map.get(map, atom)
  end

  defp extract_locale(locale, map) when is_tuple(locale) do
    {field_name, locale_map} = locale
    field_value = Map.get(map, field_name)
    
    locale_map
    |> Enum.find(fn {value, _locale} -> to_string(value) == field_value end) 
    |> elem(1)
  end

  defp extract_locale(locale, _map) when is_list(locale) do
    locale[:out]
  end
end
