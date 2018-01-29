defmodule Transformer.Type.FromBooleanTest do
  use ExUnit.Case
  alias Transform.Type

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
end
