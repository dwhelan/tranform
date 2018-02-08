defmodule Transformer.Type.ToFloatTest do
  use ExUnit.Case
  import Transform.Type

  describe "to :float" do
    test "from 'nil'" do
      assert transform(nil, :float) === {:ok, nil}
    end

    test "from Boolean 'false'" do
      assert transform(false, :float) === {:ok, 0.0}
    end

    test "from Boolean 'true'" do
      assert transform(true, :float) === {:ok, 1.0}
    end

    test "from Integer" do
      assert transform(123, :float) === {:ok, 123.0}
    end

    test "from Float" do
      assert transform(123.0, :float) === {:ok, 123.0}
    end

    test "from Decimal" do
      assert transform(Decimal.new(123.0), :float) === {:ok, 123.0}
    end

    test "from String" do
      assert transform("123.0", :float) === {:ok, 123.0}
    end
  end
end
