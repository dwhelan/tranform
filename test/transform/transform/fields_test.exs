defmodule Transform.FieldsTest do
  use ExUnit.Case
  import Transform.Transformer

  defmodule Source do
    defstruct [:f1, :f2]
  end

  defmodule Example do
    use Transform.Transform

    transform do
      field :f1
    end
  end

  describe "transform" do
    test "a field listed with no transform should be retained as is" do
      assert %Source{f1: "f1"} = transform %Source{f1: "f1"}, Example
    end

    test "a field in the struct but not listed in the transform should be retained as is" do
      assert %Source{f2: "f2"} = transform %Source{f2: "f2"}, Example
    end

    test "a field not defined in the struct and not listed in the transform should be retained as is" do
      source = Map.put(%Source{f2: "f2"}, :f3, "f3")
      assert %{f3: "f3"} = transform source, Example
    end
  end
end
