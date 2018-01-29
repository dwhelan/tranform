defmodule Transformer.TypeTest do
  use ExUnit.Case
  alias Transform.Type

  describe "xx" do
    test ":naive_datetime with format option" do
      assert Type.transform("1970-01-01 00:00:00", :naive_datetime, "{YYYY}-{0M}-{0D} {h24}:{m}:{s}") === {:ok, ~N[1970-01-01 00:00:00]}
    end

    test "transforming nil should always return nil" do
      assert Type.transform(nil, :time) === {:ok, nil}
    end

    test "error is raised when primitive is invalid" do
      assert_raise UndefinedFunctionError, fn -> Type.transform(123, :foo) end
    end
  end

  describe "primitive?" do
    test ":binary" do
      assert Type.primitive?(:binary)
    end
  end
end
