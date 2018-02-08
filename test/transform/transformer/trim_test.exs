defmodule Transform.Transformer.TrimTest do
  use ExUnit.Case
  import Transform.Transformer

  @tag :wip
  test "by default no trimming should occur" do
    assert {:ok, " abc "} = transform " abc ", :string
  end

  @tag :wip
  test "should trim trailing" do
    assert {:ok, " abc"} = transform " abc ", :string, trim: :trailing
  end
end