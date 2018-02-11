defmodule Transform.Transformer.TrimTest do
  use ExUnit.Case
  import Transform.Transformer

  test ":all should trim leading and trailing" do
    assert {:ok, "abc"} = transform " abc ", trim: :all
  end

  test ":leading should trim leading" do
    assert {:ok, "abc "} = transform " abc ", trim: :leading
  end

  test ":trailing should trim trailing" do
    assert {:ok, " abc"} = transform " abc ", trim: :trailing
  end

  test ":none should not trim" do
    assert {:ok, " abc "} = transform " abc ", trim: :none
  end
end
