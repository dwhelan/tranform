defmodule Transformer.Type.FromBooleanTest do
  use ExUnit.Case
  import Transform.Type

  describe "from 'false' to" do
    test ":boolean" do
      assert transform(false, :boolean) === {:ok, false}
    end

    test ":integer" do
      assert transform(false, :integer) === {:ok, 0}
    end

    test ":decimal" do
      assert transform(false, :decimal) === {:ok, Decimal.new(0)}
    end

    test ":string" do
      assert transform(false, :string) === {:ok, "false"}
    end

    test ":binary" do
      assert transform(false, :binary) === {:ok, "false"}
    end
  end

  describe "from 'true'  to" do
    test ":boolean" do
      assert transform(true, :boolean) === {:ok, true}
    end
    test ":integer" do
      assert transform(true, :integer) === {:ok, 1}
    end

    test ":decimal" do
      assert transform(true, :decimal) === {:ok, Decimal.new(1)}
    end

    test ":string" do
      assert transform(true, :string) === {:ok, "true"}
    end

    test ":binary" do
      assert transform(true, :binary) === {:ok, "true"}
    end
  end
end
