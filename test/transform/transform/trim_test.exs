defmodule Transform.TrimTest do
  use ExUnit.Case
  import Transform.Transformer

  defmodule Source do
    defstruct [:text]
  end

  defmodule Default do
    use Transform.Transform

    transform do
      field :text
    end
  end
  
  test "text should not be trimmed by default" do
    assert %Source{text: " abc "} = transform %Source{text: " abc "}, Default
  end

  defmodule Trailing do
    use Transform.Transform

    transform do
      trim :trailing
      field :text
    end
  end

  @tag :wip
  test "should trim trailing" do
    assert %Source{text: " abc"} = transform %Source{text: " abc "}, Trailing
  end
end