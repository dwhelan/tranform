defmodule Transform.LocaleTest do
  use ExUnit.Case
  import Transform.Transformer

  defmodule Source do
    defstruct [:dob1]
  end

  defmodule Example do
    use Transform.Transform

    transform do
    end
  end

  describe "transform" do
    test "input locale should default to 'en'" do
      assert %{in: "en"} = Example.__transforms__(:locale)
    end

    test "output locale should default to 'en'" do
      assert %{out: "en"} = Example.__transforms__(:locale)
    end
  end
end
