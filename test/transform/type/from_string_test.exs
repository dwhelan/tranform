defmodule Transformer.Type.FromStringTest do
  use ExUnit.Case
  import Transform.Type

  describe "from string to" do
    test ":boolean ('false')" do
      assert transform("false", :boolean) === {:ok, false}
    end

    test ":boolean ('anything else')" do
      assert transform("anything else", :boolean) === {:ok, true}
    end

    test ":integer" do
      assert transform("123", :integer) === {:ok, 123}
    end

    test ":float" do
      assert transform("123.0", :float) === {:ok, 123.0}
    end

    test ":decimal" do
      assert transform("123.0", :decimal) === {:ok, Decimal.new("123.0")}
    end

    test ":string" do
      assert transform("abc", :string) === {:ok, "abc"}
    end

    test ":binary" do
      assert transform("abc", :binary) === {:ok, "abc"}
    end

    test ":date" do
      assert transform("1970-01-01", :date) === {:ok, ~D[1970-01-01]}
    end

    test ":naive_datetime" do
      assert transform("1970-01-01 00:00:00", :naive_datetime) === {:ok, ~N[1970-01-01 00:00:00]}
    end

    test ":utc_datetime" do
      assert transform("1970-01-01 00:00:00", :utc_datetime) === DateTime.from_unix(0)
    end

    test ":time" do
      assert transform("00:00:00", :time) === {:ok, ~T[00:00:00]}
    end
  end

  describe "from string with options to" do
    test ":date" do
      assert transform("1970-01-01", :date, "{YYYY}-{0M}-{0D}") === {:ok, ~D[1970-01-01]}
    end

    test ":naive_datetime" do 
      assert transform("1970-01-01 00:00:00", :naive_datetime, "{YYYY}-{0M}-{0D} {h24}:{m}:{s}") === {:ok, ~N[1970-01-01 00:00:00]} 
    end 
  end
end
