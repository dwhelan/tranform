defmodule Transform.Transformer.ReplaceTest do
  use ExUnit.Case
  import Transform.Transformer

  test "should replace string" do
    assert {:ok, "abX"} = transform "abc", replace: [pattern: "c", with: "X"]
  end

  test "should replace all occurences by default" do
    assert {:ok, "XabX"} = transform "cabc", replace: [pattern: "c", with: "X"]
  end

  test "should remove first occurence only if :global is 'false'" do
    assert {:ok, "Xabc"} = transform "cabc", replace: [pattern: "c", with: "X", global: false]
  end

  test "should replace via a regular expression pattern" do
    assert {:ok, "abXX"} = transform "abcd", replace: [pattern: ~r/c|d/, with: "X"]
  end
end
