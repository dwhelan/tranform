defmodule Transformer.Type.ToTimeTest do
  use ExUnit.Case
  import Transform.Type

  describe "to :time" do
    test "from 'nil'" do
      assert transform(nil, :time) === {:ok, nil}
    end

    test "from String" do
      assert transform("00:00:00", :time) === {:ok, ~T[00:00:00]}
    end

    test "from Integer" do
      assert transform(0, :time) === {:ok, ~T[00:00:00]}
    end

    test "from Time" do
      assert transform(~T[00:00:00], :time) === {:ok, ~T[00:00:00]}
    end

    test "from DateTime" do
      {:ok, datetime} = DateTime.from_unix(0)
      assert transform(datetime, :time) === {:ok, ~T[00:00:00]}
    end

    test "from NaiveDateTime" do
      assert transform(~N[1970-01-01 00:00:00], :time) === {:ok, ~T[00:00:00]}
    end
  end
end
