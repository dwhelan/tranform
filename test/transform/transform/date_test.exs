defmodule Transform.DateTest do
  use ExUnit.Case
  import Transform.Transformer

  defmodule Source do
    defstruct [:dob1, :dob2, :dob3, :dob4]
  end

  defmodule Example do
    use Transform.Transform

    transform do
      field :dob1, date:  "{YYYY}-{0M}-{0D}"
      field :dob2, date: ["{YYYY}-{0M}-{0D}",  "{Mfull} {D}, {YYYY}"]
      field :dob3, date:  "{YYYY}-{0M}-{0D}" > "{Mfull} {D}, {YYYY}"
      field :dob4, date:  "{YYYY}-{0M}-{0D}", string: "{Mfull} {D}, {YYYY}"
    end
  end

  test "date with options" do
    result = transform %Source{dob1: "2001-01-01"}, Example
    assert result.dob1 == ~D[2001-01-01]
  end

  test "date with parse and options list" do
    result = transform %Source{dob2: "2001-01-01"}, Example
    assert result.dob2 == "January 1, 2001"
  end

  test "date with parse and options > sign" do
    result = transform %Source{dob3: "2001-01-01"}, Example
    assert result.dob3 == "January 1, 2001"
  end

  test "separate parse and format transformations" do
    result = transform %Source{dob4: "2001-01-01"}, Example
    assert result.dob4 == "January 1, 2001"
  end

  defmodule WithExplicitLocale do
    use Transform.Transform

    transform do
      locale "fr"
      field :dob1, date: "{Mfull} {D}, {YYYY}"
    end
  end

  @tag :skip
  test "parse date with locale" do
    result = transform %Source{dob1: "janvier 1, 2001"}, WithExplicitLocale
    assert result.dob1 == ~N[2001-01-01 00:00:00]
  end
end
