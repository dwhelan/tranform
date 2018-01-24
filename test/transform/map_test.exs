defmodule Transform.MapTest do
  use ExUnit.Case
  alias Transform.Map

  defmodule Source do
    defstruct [:a, :b, :c]
  end

  describe "transform" do
    test "struct -> map" do
      assert Map.transform(%Source{a: "a", b: 42, c: false}, %{}) == %{a: "a", b: 42, c: false}
    end

    test "map -> map" do
      assert Map.transform(%{a: "a", b: 42, c: false}, %{}) == %{a: "a", b: 42, c: false}
    end
  end
end
