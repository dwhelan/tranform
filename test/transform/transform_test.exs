defmodule Transform.TransformTest do
  use ExUnit.Case
  import Transform.Transformer

  defmodule Source do
    defstruct [:dob1]
  end

  defmodule Example do
    use Transform.Transform

    transform do
      field :dob1, date: "{YYYY}-{0M}-{0D}"
    end
  end

  describe "transform" do
    test "date with options" do
      result = transform %Source{dob1: "2001-01-01"}, Example
      assert result.dob1 == ~N[2001-01-01 00:00:00]
    end
  end
end
