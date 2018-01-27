defmodule Transform.Transformer do
  
  def transform(value, transform) when transform in [:string] do
    Transform.Type.transform(value, transform)
  end

  def transform(map, mod) when is_map(map) and is_atom(mod) do
    transform map, mod.__transforms__
  end
  
  def transform(map, transforms) when is_map(map) and is_list(transforms) do
    Enum.reduce transforms, map, &transform(&2, &1)
  end
  
  def transform(map, {key, transforms}) when is_map(map) and is_list(transforms) do
    transform(map, key, transforms)
  end
  
  def transform(value, {transform, options}) do
    Transform.Type.transform(value, transform, options)
  end
  
  def transform(value, transforms) when is_list(transforms) do
    Enum.reduce transforms, value, &transform(&2, &1)
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
end
