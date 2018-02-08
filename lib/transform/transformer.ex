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
    transform value, mod.__transform__(:transforms), locale: locale(value, mod)
  end

  def transform(value, transform, opts \\ []) 

  def transform(nil, _, _) do
    IO.inspect :transformer2a
    {:ok, nil}
  end

  def transform(value, transforms, opts) when is_list(transforms) and is_list(opts) do
    IO.inspect :transformer3
    Enum.reduce transforms, value, &transform(&2, &1, opts)
  end  

  def transform(map, {:string, transforms}, opts) when is_map(map) and is_list(transforms) and is_list(opts) do
    IO.inspect :transformer4
    opts = Keyword.put(opts, :format, transforms[String.to_atom(opts[:locale])])
    transform(map, :string, opts)
  end  

  def transform(map, {key, transforms}, opts) when is_map(map) and is_list(transforms) and is_list(opts) do
    IO.inspect :transformer5
    transform(map, key, transforms, opts)
  end  

  def transform(value, transforms, opts) when is_list(transforms) and is_list(opts) do
    IO.inspect :transformer6
    Enum.reduce transforms, value, &transform(&2, &1, opts)
  end  

  def transform(value, {transform, format}, opts) when is_list(opts) do
    IO.inspect {:transformer7, value, format, opts}
    opts = Keyword.put(opts, :format, format)
    Type.transform(value, transform, opts)
  end

  def transform(value, transform, opts) when is_atom(transform) and is_list(opts) do
    IO.inspect :transformer8
    Type.transform(value, transform, opts)
  end

  def transform(map, key, transforms, opts) when is_map(map) and is_list(transforms) and is_list(opts) do
    IO.inspect :transformer9
    Enum.reduce(transforms, map, fn transform, input ->
      {:ok, value} = transform(Map.get(input, key), transform, opts)
      Map.put(input, key, value)
    end)
  end

  def transform(value, transform, format, opts) when is_list(opts) do
    IO.inspect :transformer10
    Type.transform(value, transform, format, opts)
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
