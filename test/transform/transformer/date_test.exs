defmodule Transform.Transformer.DateTest do
  use ExUnit.Case
  import Transform.Transformer

  test "string => :date" do
    {:ok, result} = transform "2001-01-01", :date
    assert result == ~D[2001-01-01]
  end

  test "string => :date with options" do
    {:ok, result} = transform "2001-01-01", :date, "{YYYY}-{0M}-{0D}"
    assert result == ~D[2001-01-01]
  end

  test ":date => string" do
    {:ok, result} = transform ~D[2001-01-01], :string
    assert result ==  "2001-01-01"
  end

  test ":date => string with options" do
    {:ok, result} = transform "2001-01-01", date: "{YYYY}-{0M}-{0D}"
    assert result == ~D[2001-01-01]
  end
end
