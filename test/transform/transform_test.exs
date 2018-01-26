defmodule Transform.Transformer do
  require Timex

  def transform(value, transforms) when is_list(transforms) do
    Enum.reduce transforms, value, &transform2(&2, &1)
  end

  defp transform2(map, {key, transforms}) when is_map(map) do
    Enum.reduce(transforms, map, fn transform, input ->
      original = Map.get(input, key)
      {:ok, value} = transform3(original, transform)
      Map.put(input, key, value)
    end)
  end

  def transform3(value, {:date, options}) do
    Timex.Parse.DateTime.Parser.parse(value, options)
  end
end

defmodule Transform.TransformerTest do
  use ExUnit.Case
  alias Transform.Transformer

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
    @tag :focus
    test "date parsing" do
      source = %Example{dob: "2001-01-01"}
      result = Transformer.transform source, DateConverter.__transforms__()
      assert result.dob == ~N[2001-01-01 00:00:00]
    end
  end
end
