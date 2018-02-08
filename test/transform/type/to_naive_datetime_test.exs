defmodule Transformer.Type.ToNaiveDateTimeTest do
  use ExUnit.Case
  import Transform.Type

  describe "to :naive_datetime" do
    test "from 'nil'" do
      assert transform(nil, :naive_datetime) === {:ok, nil}
    end

    test "from String" do
      assert transform("1970-01-01 00:00:00", :naive_datetime) === {:ok, ~N[1970-01-01 00:00:00]}
    end

    test "from String with format" do
      assert transform("19700101 00:00:00", :naive_datetime, format: "{YYYY}{0M}{0D} {h24}:{m}:{s}") === {:ok, ~N[1970-01-01 00:00:00]} 
    end

    test "from Integer" do
      assert transform(0, :naive_datetime) === {:ok, ~N[1970-01-01 00:00:00]}
    end

    test "from Date" do
      assert transform(~D[1970-01-01], :naive_datetime) === {:ok, ~N[1970-01-01 00:00:00]}
    end

    test "from Time should be an error" do
      assert transform(~T[00:00:00], :naive_datetime) === :error
    end

    test "from DateTime" do
      {:ok, datetime} = DateTime.from_unix(0)
      assert transform(datetime, :naive_datetime) === {:ok, ~N[1970-01-01 00:00:00]}
    end

    test "from NaiveDateTime" do
      assert transform(~N[1970-01-01 00:00:00], :naive_datetime) === {:ok, ~N[1970-01-01 00:00:00]}
    end
  end
end
