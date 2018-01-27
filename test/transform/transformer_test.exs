defmodule Transform.TransformerTest do
  use ExUnit.Case
  import Transform.Transformer

  describe "transform" do
    test "string => :date" do
      {:ok, result} = transform "2001-01-01", :date
      assert result == ~D[2001-01-01]
    end

    test ":data => string" do
      {:ok, result} = transform ~D[2001-01-01], :string
      assert result ==  "2001-01-01"
    end

    test ":date with parse options" do
      {:ok, result} = transform "2001-01-01", date: "{YYYY}-{0M}-{0D}"
      assert result == ~N[2001-01-01 00:00:00]
    end

    test ":date with parse and format options" do
      {:ok, result} = transform "2001-01-01", date: %{"{YYYY}-{0M}-{0D}" => "{Mfull} {D}, {YYYY}"}
      assert result == "January 1, 2001"
    end
  end
end
