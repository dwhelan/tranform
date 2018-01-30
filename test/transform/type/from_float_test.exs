defmodule Transformer.Type.FromFloatTest do
  use ExUnit.Case
  import Transform.Type

  describe "from Float to" do
    test ":boolean (zero)" do
      assert transform(0.0, :boolean) === {:ok, false}
    end

    test ":boolean (non-zero)" do
      assert transform(42.0, :boolean) === {:ok, true}
    end

    test ":integer" do
      assert transform(123.9, :integer) === {:ok, 123}
    end

    test ":float" do
      assert transform(123.0, :float) === {:ok, 123.0}
    end

    test ":decimal" do
      assert transform(123.0, :decimal) === {:ok, Decimal.new(123.0)}
    end

    test ":string" do
      assert transform(123.0, :string) === {:ok, "123.0"}
    end

    test ":binary" do
      assert transform(123.0, :string) === {:ok, "123.0"}
    end

    test ":currency" do
      assert transform(1234.56, :currency) === {:ok, "1,234.56"}
    end
  end
end
