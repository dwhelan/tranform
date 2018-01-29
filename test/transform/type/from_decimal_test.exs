defmodule Transformer.Type.FromDecimalTest do
  use ExUnit.Case
  import Transform.Type

  describe "from Decimal to" do
    test ":boolean (zero)" do
      assert transform(Decimal.new(0), :boolean) === {:ok, false}
    end

    test ":boolean (non-zero)" do
      assert transform(Decimal.new(42), :boolean) === {:ok, true}
    end

    test ":integer" do
      assert transform(Decimal.new(123), :integer) === {:ok, 123}
    end

    test ":float" do
      assert transform(Decimal.new(123), :float) === {:ok, 123.0}
    end

    test ":decimal" do
      assert transform(Decimal.new(123), :decimal) === {:ok, Decimal.new(123)}
    end

    test ":string" do
      assert transform(Decimal.new(123), :string) === {:ok, "123"}
    end

    test ":binary" do
      assert transform(Decimal.new(123), :binary) === {:ok, "123"}
    end
  end
end
