defmodule Transform.Transformer do
  
  def transform(nil, _) do
    {:ok, nil}
  end

  def transform(value, transform) when transform in [:string, :date] do
    Transform.Type.transform(value, transform)
  end

  def transform(value, mod) when is_atom(mod) do
    transform value, mod.__transforms__
  end

  def transform(value, transforms) when is_list(transforms) do
    Enum.reduce transforms, value, &transform(&2, &1)
  end

  def transform(map, {key, transforms}) when is_map(map) and is_list(transforms) do
    transform(map, key, transforms)
  end

  def transform(value, transforms) when is_list(transforms) do
    Enum.reduce transforms, value, &transform(&2, &1)
  end

  def transform(value, {transform, options}) do
    Transform.Type.transform(value, transform, options)
  end

  def transform(value, transform) when is_atom(transform) do
    Transform.Type.transform(value, transform)
  end

  def transform(map, key, transforms) when is_map(map) and is_list(transforms) do
    Enum.reduce(transforms, map, fn transform, input ->
      {:ok, value} = transform(Map.get(input, key), transform)
      Map.put(input, key, value)
    end)
  end

  def transform(value, transform, options) do
    Transform.Type.transform(value, transform, options)
  end
end
