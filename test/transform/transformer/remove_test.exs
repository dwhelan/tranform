defmodule Transform.Transformer.RemoveTest do
  use ExUnit.Case
  import Transform.Transformer

  test "should remove string" do
    assert {:ok, "ab"} = transform "abc", remove: "c"
  end

  test "should remove all occurences by default" do
    assert {:ok, "ab"} = transform "cabc", remove: "c"
  end

  test "should remove first occurence only if :global is 'false'" do
    assert {:ok, "abc"} = transform "cabc", remove: [pattern: "c", global: false]
  end

  test "should remove via a regular expression pattern" do
    assert {:ok, "ab"} = transform "abcd", remove: ~r/c|d/
  end
end
