defmodule Transform.Transformer do
  require Timex

  def transform(map, mod) when is_map(map) and is_atom(mod) do
    transform(map, mod.__transforms__)
  end

  def transform(map, transforms) when is_map(map) and is_list(transforms) do
    Enum.reduce transforms, map, &transform(&2, &1)
  end

  def transform(map, {key, transforms}) when is_map(map) do
    Enum.reduce(transforms, map, fn transform, input ->
      {:ok, value} = transform( Map.get(input, key), transform)
      Map.put(input, key, value)
    end)
  end

  def transform(string, {:date, options}) when is_binary(string) do
    Timex.Parse.DateTime.Parser.parse(string, options)
  end
end

defmodule Transform.TransformerTest do
  use ExUnit.Case
  import Transform.Transformer

  defmodule Example do
    defstruct [:dob]
  end

  defmodule DateConverter do
    use Transform.Transform

    transform do
      field :dob, date: "{YYYY}-{0M}-{0D}"
    end
  end

  describe "transform" do
    test "date parsing" do
      result = transform %Example{dob: "2001-01-01"}, DateConverter
      assert result.dob == ~N[2001-01-01 00:00:00]
    end
  end
end
