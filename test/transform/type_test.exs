defmodule Transform.TypeTest do
  use ExUnit.Case
  alias Transform.Type

  describe "primitives" do
    test ":integer" do
      assert Transform.Type.transform("123", :integer) === {:ok, 123}
    end

    test ":string" do
      assert Transform.Type.transform(123, :string) === {:ok, "123"}
    end

    test ":binary" do
      assert Transform.Type.transform(123, :binary) === {:ok, "123"}
    end

    test "error is raised when primitive is invalid" do
      assert_raise UndefinedFunctionError, fn -> Transform.Type.transform(123, :foo) end
    end
  end

  describe "primitive?" do
    test ":binary" do
      assert Type.primitive?(:binary)
    end
  end
end
