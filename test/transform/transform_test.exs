defmodule Transform.TransformTest do
  use ExUnit.Case
  import Transform.Transformer

  defmodule Source do
    defstruct [:dob]
  end

  defmodule Example do
    use Transform.Transform

    transform do
      field :dob, date: "{YYYY}-{0M}-{0D}"
    end
  end

  describe "transform" do
    test "date parsing" do
      result = transform %Source{dob: "2001-01-01"}, Example
      assert result.dob == ~N[2001-01-01 00:00:00]
    end
  end
end
