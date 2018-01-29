defmodule Transformer.Type.FromFloatTest do
  use ExUnit.Case
  alias Transform.Type

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
end
