defmodule TypeTest do
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

  describe "Float   to" do
    test ":boolean (zero)" do
      assert Type.transform(0.0, :boolean) === {:ok, false}
    end

    test ":boolean (non-zero)" do
      assert Type.transform(42.0, :boolean) === {:ok, true}
    end

    test ":integer" do
      assert Type.transform(123.9, :integer) === {:ok, 123}
    end

    test ":float  " do
      assert Type.transform(123.0, :float) === {:ok, 123.0}
    end

    test ":decimal" do
      assert Type.transform(123.0, :decimal) === {:ok, Decimal.new(123.0)}
    end

    test ":string " do
      assert Type.transform(123.0, :string) === {:ok, "123.0"}
    end

    test ":binary " do
      assert Type.transform(123.0, :string) === {:ok, "123.0"}
    end
  end

  describe "Decimal to" do
    test ":boolean (zero)" do
      assert Type.transform(Decimal.new(0), :boolean) === {:ok, false}
    end

    test ":boolean (non-zero)" do
      assert Type.transform(Decimal.new(42), :boolean) === {:ok, true}
    end

    test ":integer" do
      assert Type.transform(Decimal.new(123), :integer) === {:ok, 123}
    end

    test ":float  " do
      assert Type.transform(Decimal.new(123), :float) === {:ok, 123.0}
    end

    test ":decimal" do
      assert Type.transform(Decimal.new(123), :decimal) === {:ok, Decimal.new(123)}
    end

    test ":string " do
      assert Type.transform(Decimal.new(123), :string) === {:ok, "123"}
    end

    test ":binary " do
      assert Type.transform(Decimal.new(123), :binary) === {:ok, "123"}
    end
  end

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
  end

  describe "Boolean false to" do
    test ":boolean" do
      assert Type.transform(false, :boolean) === {:ok, false}
    end

    test ":integer" do
      assert Type.transform(false, :integer) === {:ok, 0}
    end

    test ":decimal" do
      assert Type.transform(false, :decimal) === {:ok, Decimal.new(0)}
    end

    test ":string" do
      assert Type.transform(false, :string) === {:ok, "false"}
    end

    test ":binary" do
      assert Type.transform(false, :binary) === {:ok, "false"}
    end
  end

  describe "Boolean true to" do
    test ":boolean" do
      assert Type.transform(true, :boolean) === {:ok, true}
    end
    test ":integer" do
      assert Type.transform(true, :integer) === {:ok, 1}
    end

    test ":decimal" do
      assert Type.transform(true, :decimal) === {:ok, Decimal.new(1)}
    end

    test ":string" do
      assert Type.transform(true, :string) === {:ok, "true"}
    end

    test ":binary" do
      assert Type.transform(true, :binary) === {:ok, "true"}
    end
  end

  describe "from Date to" do
    test ":date" do
      assert Type.transform(~D[1970-01-01], :date) === {:ok, ~D[1970-01-01]}
    end

    test ":naive_datetime" do
      assert Type.transform(~D[1970-01-01], :naive_datetime) === {:ok, ~N[1970-01-01 00:00:00]}
    end

    test ":utc_datetime" do
      assert Type.transform(~D[1970-01-01], :utc_datetime) === DateTime.from_unix(0)
    end

    test ":time" do
      assert Type.transform(~D[1970-01-01], :time) === {:ok, ~T[00:00:00]}
    end

    test ":string" do
      assert Type.transform(~D[1970-01-01], :string) === {:ok, "1970-01-01"}
    end

    test ":binary" do
      assert Type.transform(~D[1970-01-01], :binary) === {:ok, "1970-01-01"}
    end
  end


  describe "from NaiveDateTime to" do
    test ":date" do
      assert Type.transform(~N[1970-01-01 00:00:00], :date) === {:ok, ~D[1970-01-01]}
    end

    test ":naive_datetime" do
      assert Type.transform(~N[1970-01-01 00:00:00], :naive_datetime) === {:ok, ~N[1970-01-01 00:00:00]}
    end

    test ":utc_datetime" do
      assert Type.transform(~N[1970-01-01 00:00:00], :utc_datetime) === DateTime.from_unix(0)
    end

    test ":time" do
      assert Type.transform(~N[1970-01-01 00:00:00], :time) === {:ok, ~T[00:00:00]}
    end

    test ":string" do
      assert Type.transform(~N[1970-01-01 00:00:00], :string) === {:ok, "1970-01-01 00:00:00"}
    end

    test ":binary" do
      assert Type.transform(~N[1970-01-01 00:00:00], :string) === {:ok, "1970-01-01 00:00:00"}
    end
  end

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
