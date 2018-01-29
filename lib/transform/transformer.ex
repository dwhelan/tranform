defmodule Transform.Transformer do
  alias Transform.Type

  def transform(nil, _) do
    {:ok, nil}
  end

  def transform(value, transform) when transform in [:string, :date] do
    Type.transform(value, transform)
  end

  def transform(value, mod) when is_atom(mod) do
    locale = mod.__transform__(:locale)[:out]
    transform value, mod.__transform__(:transforms), locale
  end

  def transform(value, transform, locale \\ "en") 

  def transform(nil, _, _) do
    {:ok, nil}
  end

  def transform(value, transforms, locale) when is_list(transforms) and is_binary(locale) do
    # IO.inspect {"Transform.Transformer/3 list", locale}
    Enum.reduce transforms, value, &transform(&2, &1, locale)
  end  

  def transform(map, {key, transforms}, locale) when is_map(map) and is_list(transforms) do
    # IO.inspect {"Transform.Transformer/3", map, {key, transforms}, locale}
    transform(map, key, transforms, locale)
  end  

  def transform(value, transforms, locale) when is_list(transforms) do
    Enum.reduce transforms, value, &transform(&2, &1, locale)
  end  

  def transform(value, {transform, options}, locale) do
    # IO.inspect {"Transform.Transformer/3 value}", value, {transform, options}, locale}
    Type.transform(value, transform, options, locale)
  end

  def transform(value, transform, locale) when is_atom(transform) do
    # IO.inspect {"Transform.Transformer/3 value}", value, transform, locale}
    Type.transform(value, transform)
  end

  def transform(map, key, transforms, locale) when is_map(map) and is_list(transforms) do
    # IO.inspect {"Transform.Transformer/4 map}", map, key, transforms, locale}
    Enum.reduce(transforms, map, fn transform, input ->
      # IO.inspect {"in loop", map, input, key}
      {:ok, value} = transform(Map.get(input, key), transform, locale)
      Map.put(input, key, value)
    end)
  end

  def transform(value, transform, options, locale) do
    # IO.inspect {"Transform.Transformer/4 value}", locale}
    Type.transform(value, transform, options)
  end
end
