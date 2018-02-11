defmodule Transform.TrimTest do
  use ExUnit.Case
  import Transform.Transformer

  defmodule Source do
    defstruct [:text]
  end

  defmodule Default do
    use Transform.Transform

    transform do
    end
  end
  
  test "text should not be trimmed by default" do
    assert %Source{text: " abc "} = transform %Source{text: " abc "}, Default
  end

  defmodule All do
    use Transform.Transform

    transform do
      field :text, trim: :all
    end
  end

  test "with no args should trim leading and trailing" do
    assert %Source{text: "abc"} = transform %Source{text: " abc "}, All
  end
end