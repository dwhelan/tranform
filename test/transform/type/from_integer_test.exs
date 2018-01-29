defmodule Transformer.Type.FromIntegerTest do
  use ExUnit.Case
  alias Transform.Type

  describe "Integer to" do
    test ":boolean (zero)" do
      assert Type.transform(0, :boolean) === {:ok, false}
    end

    test ":boolean (non-zero)" do
      assert Type.transform(42, :boolean) === {:ok, true}
    end

    test ":integer" do
      assert Type.transform(123, :integer) === {:ok, 123}
    end

    test ":float  " do
      assert Type.transform(123, :float) === {:ok, 123.0}
    end

    test ":decimal" do
      assert Type.transform(123, :decimal) === {:ok, Decimal.new(123)}
    end

    test ":string " do
      assert Type.transform(123, :string) === {:ok, "123"}
    end

    test ":binary " do
      assert Type.transform(123, :binary) === {:ok, "123"}
    end

    test ":naive_datetime" do
      assert Type.transform(0, :naive_datetime) === {:ok, ~N[1970-01-01 00:00:00]}
    end

    test ":utc_datetime" do
      assert Type.transform(0, :utc_datetime) === {:ok, 0}
    end

    test ":time" do
      assert Type.transform(0, :time) === {:ok, ~T[00:00:00]}
    end
  end
end
