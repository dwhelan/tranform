defmodule Transformer.TypeTest do
  use ExUnit.Case
  import Transform.Type

  test "error is raised when primitive is invalid" do
    assert_raise UndefinedFunctionError, fn -> transform(123, :foo) end
  end

  describe "primitive?" do
    test ":string" do
      assert primitive?(:string)
    end
  end
end
