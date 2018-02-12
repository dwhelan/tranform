defmodule Transform.NumberTest do
  use ExUnit.Case
  import Transform.Transformer

  defmodule Source do
    defstruct [:value1, :locale]
  end

  defmodule Default do
    use Transform.Transform

    transform do
      field :value1, :number
    end
  end

  @tag :skip
  test "default format" do
    result = transform %Source{value1: "1234.56"}, Default
    assert result.value1 == "1,234.56"
  end

  defmodule WithFormat do
    use Transform.Transform

    transform do
      field :value1, number: "#,###.##"
    end
  end

  test "number with format" do
    result = transform %Source{value1: "1234.56"}, WithFormat
    assert result.value1 == "1,234.56"
  end

  defmodule WithExplicitLocale do
    use Transform.Transform

    transform do
      locale "fr"
      field :value1, number: "#,###.##"
    end
  end

  test "parse number with locale defined in transform" do
    result = transform %Source{value1: 1234.56}, WithExplicitLocale
    assert result.value1 == "1 234,56"
  end

  defmodule WithLocaleFromStruct do
    use Transform.Transform

    transform do
      locale :locale
      field :value1, number:  "#,###.##"
    end
  end

  test "parse number with locale from struct" do
    result = transform %Source{value1: 1234.56, locale: "fr"}, WithLocaleFromStruct
    assert result.value1 == "1 234,56"
  end

  defmodule WithLocaleFromStructViaMap do
    use Transform.Transform

    transform do
      locale :locale, "F": "fr", "E": "en"
      field :value1, number: "#,###.##"
    end
  end

  test "parse number with locale from struct with map" do
    result = transform %Source{value1: 1234.56, locale: "F"}, WithLocaleFromStructViaMap
    assert result.value1 == "1 234,56"
  end
end
