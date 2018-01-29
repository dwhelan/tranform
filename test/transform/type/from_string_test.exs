defmodule Transformer.Type.FromStringTest do
  use ExUnit.Case
  alias Transform.Type

  describe "String  to" do
    test ":boolean ('false')" do
      assert Type.transform("false", :boolean) === {:ok, false}
    end

    test ":boolean ('anything else')" do
      assert Type.transform("anything else", :boolean) === {:ok, true}
    end

    test ":integer" do
      assert Type.transform("123", :integer) === {:ok, 123}
    end

    test ":float  " do
      assert Type.transform("123.0", :float) === {:ok, 123.0}
    end

    test ":decimal" do
      assert Type.transform("123.0", :decimal) === {:ok, Decimal.new("123.0")}
    end

    test ":string " do
      assert Type.transform("abc", :string) === {:ok, "abc"}
    end

    test ":binary " do
      assert Type.transform("abc", :binary) === {:ok, "abc"}
    end

    test ":date" do
      assert Type.transform("1970-01-01", :date) === {:ok, ~D[1970-01-01]}
    end

    test ":naive_datetime" do
      assert Type.transform("1970-01-01 00:00:00", :naive_datetime) === {:ok, ~N[1970-01-01 00:00:00]}
    end

    test ":utc_datetime" do
      assert Type.transform("1970-01-01 00:00:00", :utc_datetime) === DateTime.from_unix(0)
    end

    test ":time" do
      assert Type.transform("00:00:00", :time) === {:ok, ~T[00:00:00]}
    end
  end
end
