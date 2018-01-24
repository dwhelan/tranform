defmodule Transform.StructTest do
  use ExUnit.Case
  alias Transform.Struct

  defmodule Source do
    defstruct [:a, :b, :c]
  end

  defmodule Target do
    defstruct [:a, :b, :c]
  end

  describe "transform" do
    @tag :focus
    test "struct -> struct" do
      assert Struct.transform(%Source{a: "a", b: 42, c: false}, %Target{}) == %Target{a: "a", b: 42, c: false}
    end

    test "struct -> struct module" do
      assert Struct.transform(%Source{a: "a", b: 42, c: false}, Target) == %Target{a: "a", b: 42, c: false}
    end

    test "map -> struct" do
      assert Struct.transform(%{a: "a", b: 42, c: false}, %Target{}) == %Target{a: "a", b: 42, c: false}
    end

    test "map -> struct module" do
      assert Struct.transform(%{a: "a", b: 42, c: false}, Target) == %Target{a: "a", b: 42, c: false}
    end

    test "map with string keys -> struct" do
      assert Struct.transform(%{"a" => "a", "b" => 42, "c" => false}, %Target{}) == %Target{a: "a", b: 42, c: false}
    end
  end
end
