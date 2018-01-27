defmodule Transform.ErrorTest do
  use ExUnit.Case
  import Transform.Transformer

  defmodule Source do
    defstruct [:dob1]
  end

  defmodule Example do
    use Transform.Transform

    transform do
      field :dob1, date: "{YYYY}-{0M}-{0D}"
    end
  end

  describe "transform" do
    test "a transform of a nil should return nil" do
      result = transform %Source{}, Example
      assert result.dob1 == nil
    end
  end
end
