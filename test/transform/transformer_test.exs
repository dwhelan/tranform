defmodule Transform.TransformerTest do
  use ExUnit.Case
  import Transform.Transformer

  describe "transform" do
    test ":date" do
      {:ok, result} = transform "2001-01-01", :date
      assert result == ~D[2001-01-01]
    end

    test ":date with options" do
      {:ok, result} = transform "2001-01-01", date: "{YYYY}-{0M}-{0D}"
      assert result == ~N[2001-01-01 00:00:00]
    end
  end
end
