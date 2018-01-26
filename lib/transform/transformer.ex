defmodule Transform.Transformer do
  
  def transform(map, mod) when is_map(map) and is_atom(mod) do
    transform map, mod.__transforms__
  end
  def transform(map, transforms) when is_map(map) and is_list(transforms) do
    Enum.reduce transforms, map, &transform(&2, &1)
  end
  def transform(map, {key, transforms}) when is_map(map) and is_list(transforms) do
    transform(map, key, transforms)
  end
  def transform(value, {transformation, options}) do
    Transform.Type.transform(value, transformation, options)
  end
  def transform(value, transformation) do
    Transform.Type.transform(value, transformation)
  end

  def transform(map, key, transforms) when is_map(map) and is_list(transforms) do
    Enum.reduce(transforms, map, fn transform, input ->
      {:ok, value} = transform(Map.get(input, key), transform)
      Map.put(input, key, value)
    end)
  end
end
