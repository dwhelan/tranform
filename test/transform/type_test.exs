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

    test ":float" do
      assert Transform.Type.transform("123", :float) === {:ok, 123.0}
    end

    test ":decimal" do
      assert Transform.Type.transform("123", :decimal) === {:ok, Decimal.new(123)}
    end

    test ":boolean" do
      assert Transform.Type.transform("true", :boolean) === {:ok, true}
    end

    test ":date" do
      assert Transform.Type.transform("2001-01-01", :date) === {:ok, ~D[2001-01-01]}
    end

    test ":utc_datetime" do
      assert Transform.Type.transform("1970-01-01 00:00:00", :utc_datetime) === DateTime.from_unix(0)
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
