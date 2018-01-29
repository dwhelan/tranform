defmodule Transformer.Type.FromNilTest do
  use ExUnit.Case
  import Transform.Type

  test "transforming 'nil' should always return 'nil'" do
    Enum.each([:integer, :float, :decimal, :string, :binary, :date, :naive_datetime, :time], fn target -> 
      assert transform(nil, target) === {:ok, nil}
    end)
  end
end
