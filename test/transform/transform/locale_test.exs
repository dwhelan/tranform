defmodule Transform.Transform.LocaleTest do
  use ExUnit.Case

  defmodule Default do
    use Transform.Transform

    transform do end
  end

  test "should default input and output locales to 'en'" do
    locale = Default.__transform__(:locale)
    assert locale == [in: "en", out: "en"] 
  end

  
  defmodule In do
    use Transform.Transform

    transform do locale in: "fr" end
  end

  test "should be able to set input locale" do
    locale = In.__transform__(:locale)
    assert locale[:in] == "fr"
  end


  defmodule Out do
    use Transform.Transform

    transform do locale out: "fr" end
  end

  test "should be able to set output locale" do
    locale = Out.__transform__(:locale)
    assert locale[:out] == "fr"
  end


  defmodule Both do
    use Transform.Transform

    transform do locale in: "fr", out: "fr" end
  end

  test "should be able to set both locales" do
    locale = Both.__transform__(:locale)
    assert locale == [in: "fr", out: "fr"] 
  end


  defmodule FromField do
    use Transform.Transform

    transform do locale in: :loc_in, out: :loc_out end
  end

  test "should be able to set to a field reference (atom)" do
    locale = FromField.__transform__(:locale)
    assert locale == [in: :loc_in, out: :loc_out] 
  end
end
