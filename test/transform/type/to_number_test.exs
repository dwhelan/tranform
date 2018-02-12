defmodule Transformer.Type.ToCurrencyTest do
  use ExUnit.Case
  import Transform.Type

  describe "to :number" do
    test "from 'nil'" do
      assert transform(nil, :number) === {:ok, nil}
    end

    test "from String" do
      assert transform("1234.56", :number) === {:ok, "$1,234.56"}
    end

    test "from String with format" do
      assert transform("1234.56", :number, format: "$USD #,###.##") === {:ok, "$USD 1,234.56"}
    end

    test "from String with format and locale" do
      assert transform("1234.56", :number, format: "#,###.##", locale: "fr") === {:ok, "1 234,56"}
    end

    test "from Integer" do
      assert transform(1234, :number) === {:ok, "$1,234"}
    end

    test "from Integer with format" do
      assert transform(1234, :number, format: "$USD #,###.##") === {:ok, "$USD 1,234"}
    end

    test "from Integer with format and locale" do
      assert transform(1234, :number, format: "#,###.##", locale: "fr") === {:ok, "1 234"}
    end

    test "from Float" do
      assert transform(1234.56, :number) === {:ok, "$1,234.56"}
    end

    test "from Float with format" do
      assert transform(1234.56, :number, format: "$USD #,###.##") === {:ok, "$USD 1,234.56"}
    end

    test "from Float with format and locale" do
      assert transform(1234.56, :number, format: "#,###.##", locale: "fr") === {:ok, "1 234,56"}
    end

    test "from Decimal" do
      assert transform(Decimal.new(1234.56), :number) === {:ok, "$1,234.56"}
    end

    test "from Decimal with format" do
      assert transform(Decimal.new(1234.56), :number, format: "$USD #,###.##") === {:ok, "$USD 1,234.56"}
    end

    test "from Decimal with format and locale" do
      assert transform(Decimal.new(1234.56), :number, format: "#,###.##", locale: "fr") === {:ok, "1 234,56"}
    end
  end
end
