defmodule Transformer.TypeTest do
  use ExUnit.Case
  alias Transform.Type

  describe "xx" do
    test ":date" do
      assert Type.transform("1970-01-01", :date) === {:ok, ~D[1970-01-01]}
    end

    test ":date with format" do
      assert Type.transform("1970-01-01", :date, "{YYYY}-{0M}-{0D}") === {:ok, ~N[1970-01-01 00:00:00]}
    end

    test ":naive_datetime" do
      assert Type.transform("1970-01-01 00:00:00", :naive_datetime) === {:ok, ~N[1970-01-01 00:00:00]}
    end

    test ":naive_datetime with format option" do
      assert Type.transform("1970-01-01 00:00:00", :naive_datetime, "{YYYY}-{0M}-{0D} {h24}:{m}:{s}") === {:ok, ~N[1970-01-01 00:00:00]}
    end

    test ":utc_datetime" do
      assert Type.transform("1970-01-01 00:00:00", :utc_datetime) === DateTime.from_unix(0)
    end

    test ":time" do
      assert Type.transform("00:00:00", :time) === {:ok, ~T[00:00:00]}
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
