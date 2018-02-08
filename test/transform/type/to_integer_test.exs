defmodule Transformer.Type.ToIntegerTest do
  use ExUnit.Case
  import Transform.Type

  describe "to :integer" do
    test "from 'nil'" do
      assert transform(nil, :integer) === {:ok, nil}
    end

    test "from Boolean 'false'" do
      assert transform(false, :integer) === {:ok, 0}
    end

    test "from Boolean 'true'" do
      assert transform(true, :integer) === {:ok, 1}
    end

    test "from Integer" do
      assert transform(123, :integer) === {:ok, 123}
    end

    test "from Float" do
      assert transform(123.9, :integer) === {:ok, 123}
    end

    test "from Decimal" do
      assert transform(Decimal.new(123), :integer) === {:ok, 123}
    end

    test "from String" do
      assert transform("123", :integer) === {:ok, 123}
    end
  end
end
