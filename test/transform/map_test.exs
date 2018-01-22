defmodule Transform.MapTest do
  use ExUnit.Case
  alias Transform.Map

  defmodule Source do
    defstruct [:a, :b, :c]
  end

  defmodule Target do
    defstruct [:a, :b, :c]
  end

  describe "transform" do
    test "struct -> struct" do
      assert Map.transform(%Source{a: "a", b: 42, c: false}, %Target{}) == %Target{a: "a", b: 42, c: false}
    end

    test "struct -> struct module" do
      assert Map.transform(%Source{a: "a", b: 42, c: false}, Target) == %Target{a: "a", b: 42, c: false}
    end

    test "struct -> map" do
      assert Map.transform(%Source{a: "a", b: 42, c: false}, %{}) == %{a: "a", b: 42, c: false}
    end

    test "map -> struct" do
      assert Map.transform(%{a: "a", b: 42, c: false}, %Target{}) == %Target{a: "a", b: 42, c: false}
    end

    test "map -> struct module" do
      assert Map.transform(%{a: "a", b: 42, c: false}, Target) == %Target{a: "a", b: 42, c: false}
    end

    test "map -> map" do
      assert Map.transform(%{a: "a", b: 42, c: false}, %{}) == %{a: "a", b: 42, c: false}
    end
  end

  test "should default to creating a target map" do
    assert Map.transform(%Source{a: "a", b: 42, c: false}) == %{a: "a", b: 42, c: false}
  end
end
