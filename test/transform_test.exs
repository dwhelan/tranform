defmodule TransformTest do
  use ExUnit.Case

  describe "primitives" do
    test ":integer" do
      assert Transform.transform("123", :integer) === {:ok, 123}
    end

    test ":string" do
      assert Transform.transform(123, :string) === {:ok, "123"}
    end

    test ":binary" do
      assert Transform.transform(123, :binary) === {:ok, "123"}
    end
  end
end
