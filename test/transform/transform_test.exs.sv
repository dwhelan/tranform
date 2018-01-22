defmodule TransformTest do
  use ExUnit.Case

  describe "module" do
    test "as a Module" do
      assert Transform.transform("123", {EctoCSV.TransformTest, :integer}) === {:ok, 123}
    end

    test "as a String" do
      assert Transform.transform("123", {"EctoCSV.TransformTest", :integer}) === {:ok, 123}
    end

    test "as an Atom" do
      assert Transform.transform("123", {:"EctoCSV.TransformTest", :integer}) === {:ok, 123}
    end

    test "as the first module in options[:module]" do
      assert Transform.transform("123", :integer, module: [EctoCSV.TransformTest, String]) === {:ok, 123}
    end

    test "as the last module in options[:module]" do
      assert Transform.transform("123", :integer, module: [String, EctoCSV.TransformTest]) === {:ok, 123}
    end

    test "as the only module in options[:module]" do
      assert Transform.transform("123", :integer, module: [EctoCSV.TransformTest]) === {:ok, 123}
    end

    test "as the options[:module]" do
      assert Transform.transform("123", :integer, module: EctoCSV.TransformTest) === {:ok, 123}
    end
  end

  describe "error handing" do
  end
end
