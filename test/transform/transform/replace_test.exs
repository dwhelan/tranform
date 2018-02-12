defmodule Transform.ReplaceTest do
  use ExUnit.Case
  import Transform.Transformer

  defmodule Source do
    defstruct [:text]
  end

  defmodule Default do
    use Transform.Transform

    transform do
      field :text, replace: [pattern: "x", with: "X"]
    end
  end
  
  test "should replace string pattern globally by default" do
    assert %Source{text: "XabcX"} = transform %Source{text: "xabcx"}, Default
  end

  defmodule NonGlobal do
    use Transform.Transform

    transform do
      field :text, replace: [pattern: "x", with: "X", global: false]
    end
  end
  
  test "should only replace first occurence if global is 'false'" do
    assert %Source{text: "Xabcx"} = transform %Source{text: "xabcx"}, NonGlobal
  end
  
  defmodule RegEx do
    use Transform.Transform

    transform do
      field :text, replace: [pattern: ~r/x/, with: "X"]
    end
  end
  
  test "should support a regular expression match" do
    assert %Source{text: "XabcX"} = transform %Source{text: "xabcx"}, RegEx
  end
  
  defmodule Order do
    use Transform.Transform

    transform do
      field :text, replace: [pattern: "x", with: "y"]
      field :text, replace: [pattern: "y", with: "z"]
    end
  end
  
  test "should do replacements in order" do
    assert %Source{text: "zabcz"} = transform %Source{text: "xabcx"}, Order
  end
end