defmodule Transform.DateTest do
  use ExUnit.Case
  import Transform.Transformer

  defmodule Source do
    defstruct [:dob1, :dob2, :locale]
  end

  defmodule Example do
    use Transform.Transform

    transform do
      field :dob1, date:  "{YYYY}-{0M}-{0D}"
      field :dob2, date:  "{YYYY}-{0M}-{0D}", string: "{Mfull} {D}, {YYYY}"
    end
  end

  test "date with options" do
    result = transform %Source{dob1: "2001-01-01"}, Example
    assert result.dob1 == ~D[2001-01-01]
  end

  test "separate parse and format transformations" do
    result = transform %Source{dob2: "2001-01-01"}, Example
    assert result.dob2 == "January 1, 2001"
  end

  defmodule WithExplicitLocale do
    use Transform.Transform

    transform do
      locale "fr"
      field :dob1, string: "{Mfull} {D}, {YYYY}"
    end
  end

  test "parse date with locale defined in transform" do
    result = transform %Source{dob1: ~D[2001-01-01]}, WithExplicitLocale
    assert result.dob1 == "janvier 1, 2001"
  end

  defmodule WithLocaleFromStruct do
    use Transform.Transform

    transform do
      locale :locale
      field :dob1, string: "{Mfull} {D}, {YYYY}"
    end
  end

  test "parse date with locale from struct" do
    result = transform %Source{dob1: ~D[2001-01-01], locale: "fr"}, WithLocaleFromStruct
    assert result.dob1 == "janvier 1, 2001"
  end

  defmodule WithLocaleFromStructViaMap do
    use Transform.Transform

    transform do
      locale :locale, "F": "fr", "E": "en"
      field :dob1, string: "{Mfull} {D}, {YYYY}"
    end
  end

  test "parse date with locale from struct with map" do
    result = transform %Source{dob1: ~D[2001-01-01], locale: "F"}, WithLocaleFromStructViaMap
    assert result.dob1 == "janvier 1, 2001"
  end

  defmodule WithLocaleSpecificTransform do
    use Transform.Transform

    transform do
      locale :locale
      field :dob1, string: ["fr": "{D} {Mfull}, {YYYY}", "en": "{Mfull} {D}, {YYYY}"]
    end
  end

  test "format 'fr' date with explicit locale" do
    result = transform %Source{dob1: ~D[2001-01-01], locale: "fr"}, WithLocaleSpecificTransform
    assert result.dob1 == "1 janvier, 2001"
  end

  test "format 'en' date with explicit locale" do
    result = transform %Source{dob1: ~D[2001-01-01], locale: "en"}, WithLocaleSpecificTransform
    assert result.dob1 == "January 1, 2001"
  end

  defmodule WithAllLocaleOptions do
    use Transform.Transform

    transform do
      locale :locale, "F": "fr", "E": "en"
      field :dob1, string: ["fr": "{D} {Mfull}, {YYYY}", "en": "{Mfull} {D}, {YYYY}"]
    end
  end

  test "format 'fr' date with locale via map" do
    result = transform %Source{dob1: ~D[2001-01-01], locale: "F"}, WithAllLocaleOptions
    assert result.dob1 == "1 janvier, 2001"
  end

  test "format 'en' date with locale via map" do
    result = transform %Source{dob1: ~D[2001-01-01], locale: "E"}, WithAllLocaleOptions
    assert result.dob1 == "January 1, 2001"
  end
end
