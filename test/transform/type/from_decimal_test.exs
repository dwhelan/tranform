defmodule Transformer.Type.FromDecimalTest do
  use ExUnit.Case
  alias Transform.Type

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
end
