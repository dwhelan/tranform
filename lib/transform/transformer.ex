defmodule Transform.Transformer do
  alias Transform.Type

  def transform(nil, _) do
    {:ok, nil}
  end

  def transform(value, transform) when transform in [:string, :date] do
    Type.transform(value, transform)
  end

  def transform(value, mod) when is_atom(mod) do
    transform value, mod.__transform__(:transforms), locale: locale(value, mod)
  end

  def transform(value, transform, opts \\ []) 

  def transform(nil, _, _) do
    {:ok, nil}
  end

  # applies a single transform to value

  def transform(value, transform, opts) when is_atom(transform) and is_list(opts) do
    Type.transform(value, transform, opts)
  end

  # applies a list of transforms to value

  def transform(value, transforms, opts) when is_list(transforms) and is_list(opts) do
    Enum.reduce transforms, value, &transform(&2, &1, opts)
  end  

  # handles "transform map, string: [en: ..., fr: ...]" where the locale is used to determine format

  def transform(map, {:string, formats}, opts) when is_map(map) and is_list(formats) and is_list(opts) do
    opts = Keyword.put(opts, :format, formats[String.to_atom(opts[:locale])])
    transform(map, :string, opts)
  end  

  def transform(map, {key, transforms}, opts) when is_map(map) and is_list(transforms) and is_list(opts) do
    Enum.reduce(transforms, map, fn transform, input ->
      {:ok, value} = transform(Map.get(input, key), transform, opts)
      Map.put(input, key, value)
    end)
  end  

  def transform(value, {transform, format}, opts) when is_list(opts) do
    opts = Keyword.put(opts, :format, format)
    Type.transform(value, transform, opts)
  end

  defp locale(map, mod) do
    mod.__transform__(:locale) |> extract_locale(map)
  end

  defp extract_locale(atom, map) when is_atom(atom) do
    Map.get(map, atom)
  end

  defp extract_locale(opts, map) when is_tuple(opts) do
    {field_name, opts_map} = opts
    field_value = Map.get(map, field_name)
    
    opts_map
    |> Enum.find(fn {value, _opts} -> to_string(value) == field_value end) 
    |> elem(1)
  end

  defp extract_locale(opts, _map) when is_list(opts) do
    opts[:out]
  end
end
