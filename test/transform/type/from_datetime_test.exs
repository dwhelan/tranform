defmodule Transformer.Type.FromDateTimeTest do
  use ExUnit.Case
  import Transform.Type

  describe "from DateTime to" do
    test ":date" do
      assert transform(datetime(), :date) === {:ok, ~D[1970-01-01]}
    end

    test ":naive_datetime" do
      assert transform(datetime(), :naive_datetime) === {:ok, ~N[1970-01-01 00:00:00]}
    end

    test ":datetime" do
      assert transform(datetime(), :datetime) === DateTime.from_unix(0)
    end

    test ":time" do
      assert transform(datetime(), :time) === {:ok, ~T[00:00:00]}
    end

    test ":string" do
      assert transform(datetime(), :string) === {:ok, "1970-01-01 00:00:00Z"}
    end

    test ":string with options" do
      assert transform(datetime(), :string, "{Mfull} 1, {YYYY}") === {:ok, "January 1, 1970"}
    end
    
    test ":string with options and locale" do
      assert transform(datetime(), :string, "{Mfull} 1, {YYYY}", "fr") === {:ok, "janvier 1, 1970"}
    end

    test ":binary" do
      assert transform(datetime(), :string) === {:ok, "1970-01-01 00:00:00Z"}
    end
  end

  defp datetime do
    {:ok, datetime} = DateTime.from_unix(0)
    datetime
  end
end
