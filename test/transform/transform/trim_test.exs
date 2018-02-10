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

  defmodule Trailing do
    use Transform.Transform

    transform do
      trim :all
    end
  end

  @tag :wip
  test "with no args should trim leading and trailing" do
    assert %Source{text: " abc"} = transform %Source{text: " abc "}, Trailing
  end
end