defmodule Transformer.Type.ToDecimalTest do
  use ExUnit.Case
  import Transform.Type

  describe "to :decimal" do
    test "from 'nil'" do
      assert transform(nil, :decimal) === {:ok, nil}
    end

    test "from Boolean 'false'" do
      assert transform(false, :decimal) === {:ok, Decimal.new(0)}
    end

    test "from Boolean 'true'" do
      assert transform(true, :decimal) === {:ok, Decimal.new(1)}
    end

    test "from Integer" do
      assert transform(123.0, :decimal) === {:ok, Decimal.new(123.0)}
    end

    test "from Float" do
      assert transform(123.0, :decimal) === {:ok, Decimal.new(123.0)}
    end

    test "from Decimal" do
      assert transform(Decimal.new(123), :decimal) === {:ok, Decimal.new(123)}
    end

    test "from String" do
      assert transform("123.0", :decimal) === {:ok, Decimal.new(123.0)}
    end
  end
end
