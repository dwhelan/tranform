defmodule TransformTest do
  use ExUnit.Case

  defmodule Source do
    defstruct [:a, :b, :c]
  end

  defmodule Target do
    defstruct [:a, :b, :c]
  end

  test "type transformations" do
    assert Transform.transform("123", :integer) === {:ok, 123}
  end

  test "struct transformations" do
    source = %Source{a: "a", b: 42, c: false}
    target = Transform.transform(source, %Target{})
    assert target == %Target{a: "a", b: 42, c: false}
  end

  test "struct module transformations" do
    source = %Source{a: "a", b: 42, c: false}
    target = Transform.transform(source, Target)
    assert target == %Target{a: "a", b: 42, c: false}
  end

  test "map transformations" do
    source = %Source{a: "a", b: 42, c: false}
    target = Transform.transform(source, %{})
    assert target == %{a: "a", b: 42, c: false}
  end
end
