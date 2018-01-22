defmodule TransformTest do
  use ExUnit.Case

  describe "primitives" do
    test ":integer" do
      assert Transform.transform(:integer, "123") === {:ok, 123}
    end

    test ":string" do
      assert Transform.transform(:string, 123) === {:ok, "123"}
    end

    test ":binary" do
      assert Transform.transform(:binary, 123) === {:ok, "123"}
    end
  end
end
