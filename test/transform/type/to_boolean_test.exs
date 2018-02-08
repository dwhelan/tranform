defmodule Transformer.Type.ToBooleanTest do
  use ExUnit.Case
  import Transform.Type

  describe "to :boolean" do
    test "from 'nil'" do
      assert transform(nil, :boolean) === {:ok, nil}
    end

    test "from 'false'" do
      assert transform(false, :boolean) === {:ok, false}
    end

    test "from 'true'" do
      assert transform(true, :boolean) === {:ok, true}
    end

    test "from Integer (zero)" do
      assert transform(0, :boolean) === {:ok, false}
    end

    test "from Integer (non-zero)" do
      assert transform(42, :boolean) === {:ok, true}
    end

    test "from Decimal (zero)" do
      assert transform(Decimal.new(0), :boolean) === {:ok, false}
    end

    test "from Decimal (non-zero)" do
      assert transform(Decimal.new(42), :boolean) === {:ok, true}
    end

    test "from Float (zero)" do
      assert transform(0.0, :boolean) === {:ok, false}
    end

    test "from Float (non-zero)" do
      assert transform(42.0, :boolean) === {:ok, true}
    end

    test "from String ('false')" do
      assert transform("false", :boolean) === {:ok, false}
    end

    test "from String ('anything else')" do
      assert transform("anything else", :boolean) === {:ok, true}
    end
  end
end
