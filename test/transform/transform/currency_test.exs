defmodule Transform.CurrencyTest do
  use ExUnit.Case
  import Transform.Transformer

  defmodule Source do
    defstruct [:value1, :value2, :locale]
  end

  defmodule Example do
    use Transform.Transform

    transform do
      field :value1, currency:  "$ #,###.## USD"
      field :value2, date:  "{YYYY}-{0M}-{0D}", string: "{Mfull} {D}, {YYYY}"
    end
  end

  test "currency with options" do
    result = transform %Source{value1: "1234.56"}, Example
    assert result.value1 == "$ 1,234.56 USD"
  end

  defmodule WithExplicitLocale do
    use Transform.Transform

    transform do
      locale "fr"
      field :value1, currency:  "$ #,###.## USD"
    end
  end

  test "parse date with locale defined in transform" do
    result = transform %Source{value1: 1234.56}, WithExplicitLocale
    assert result.value1 == "$ 1 234,56 USD"
  end

  defmodule WithLocaleFromStruct do
    use Transform.Transform

    transform do
      locale :locale
      field :value1, currency:  "$ #,###.## USD"
    end
  end

  test "parse date with locale from struct" do
    result = transform %Source{value1: 1234.56, locale: "fr"}, WithLocaleFromStruct
    assert result.value1 == "$ 1 234,56 USD"
  end

  defmodule WithLocaleFromStructViaMap do
    use Transform.Transform

    transform do
      locale :locale, "F": "fr", "E": "en"
      field :value1, currency:  "$ #,###.## USD"
    end
  end

  test "parse date with locale from struct with map" do
    result = transform %Source{value1: 1234.56, locale: "F"}, WithLocaleFromStructViaMap
    assert result.value1 == "$ 1 234,56 USD"
  end
end
