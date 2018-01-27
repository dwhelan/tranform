defmodule Transform.DateTest do
  use ExUnit.Case
  import Transform.Transformer

  defmodule Source do
    defstruct [:dob1, :dob2, :dob3]
  end

  defmodule Example do
    use Transform.Transform

    transform do
      field :dob1, date:  "{YYYY}-{0M}-{0D}"
      field :dob2, date: ["{YYYY}-{0M}-{0D}",  "{Mfull} {D}, {YYYY}"]
      field :dob3, date:  "{YYYY}-{0M}-{0D}" > "{Mshort} {D}, {YYYY}"
    end
  end

  describe "transform" do
    test "date with options" do
      result = transform %Source{dob1: "2001-01-01", dob2: "2001-01-01", dob3: "2001-01-01"}, Example
      assert result.dob1 == ~N[2001-01-01 00:00:00]
    end

    test "date with parse and options list" do
      result = transform %Source{dob1: "2001-01-01", dob2: "2001-01-01", dob3: "2001-01-01"}, Example
      assert result.dob2 == "January 1, 2001"
    end

    test "date with parse and options > sign" do
      result = transform %Source{dob1: "2001-01-01", dob2: "2001-01-01", dob3: "2001-01-01"}, Example
      assert result.dob2 == "January 1, 2001"
    end
  end
end
