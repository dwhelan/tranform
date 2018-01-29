defmodule Transformer.Type.FromDateTimeTest do
  use ExUnit.Case
  import Transform.Type

  describe "from DateTime to" do
    test ":date" do
      assert transform(~D[1970-01-01], :date) === {:ok, ~D[1970-01-01]}
    end

    test ":naive_datetime" do
      assert transform(~D[1970-01-01], :naive_datetime) === {:ok, ~N[1970-01-01 00:00:00]}
    end

    test ":datetime" do
      assert transform(~D[1970-01-01], :datetime) === DateTime.from_unix(0)
    end

    test ":time" do
      assert transform(~D[1970-01-01], :time) === {:ok, ~T[00:00:00]}
    end

    test ":string" do
      assert transform(~D[1970-01-01], :string) === {:ok, "1970-01-01"}
    end

    test ":string with options" do
      assert transform(~D[1970-01-01], :string, "{Mfull} 1, {YYYY}") === {:ok, "January 1, 1970"}
    end
    
    test ":string with options and locale" do
      assert transform(~D[1970-01-01], :string, "{Mfull} 1, {YYYY}", "fr") === {:ok, "janvier 1, 1970"}
    end

    test ":binary" do
      assert transform(~D[1970-01-01], :string) === {:ok, "1970-01-01"}
    end
  end
end
