defmodule Transform.Transform.LocaleTest do
  use ExUnit.Case

  defmodule Default do
    use Transform.Transform

    transform do
    end
  end

  test "should default input and output locales to 'en'" do
    locale = Default.__transform__(:locale)
    assert locale == [in: "en", out: "en"] 
  end

  defmodule In do
    use Transform.Transform

    transform do
      locale in: "fr"
    end
  end

  test "should be able to set input locale" do
    locale = In.__transform__(:locale)
    assert locale[:in] == "fr"
  end

  defmodule Out do
    use Transform.Transform

    transform do
      locale out: "fr"
    end
  end

  test "should be able to set output locale" do
    locale = Out.__transform__(:locale)
    assert locale[:out] == "fr"
  end
end
