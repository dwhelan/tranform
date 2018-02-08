defmodule Transformer.Type.ToDateTest do
  use ExUnit.Case
  import Transform.Type

  describe "to :date" do
    test "from 'nil'" do
      assert transform(nil, :date) === {:ok, nil}
    end

    test "from String" do
      assert transform("1970-01-01", :date) === {:ok, ~D[1970-01-01]}
    end

    test "from String with format" do
      assert transform("19700101", :date, format: "{YYYY}{0M}{0D}") === {:ok, ~D[1970-01-01]}
    end

    test "from Date" do
      assert transform(~D[1970-01-01], :date) === {:ok, ~D[1970-01-01]}
    end

    test "from Time" do
      assert transform(~T[00:00:00], :date) === :error
    end

    test "from DateTime" do
      {:ok, datetime} = DateTime.from_unix(0)
      assert transform(datetime, :date) === {:ok, ~D[1970-01-01]}
    end

    test "from NaiveDateTime" do
      assert transform(~N[1970-01-01 00:00:00], :date) === {:ok, ~D[1970-01-01]}
    end
  end
end
