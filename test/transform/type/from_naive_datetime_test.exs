defmodule Transformer.Type.FromNaiveDateTimeTest do
  use ExUnit.Case
  alias Transform.Type

  describe "from NaiveDateTime to" do
    test ":date" do
      assert Type.transform(~N[1970-01-01 00:00:00], :date) === {:ok, ~D[1970-01-01]}
    end

    test ":naive_datetime" do
      assert Type.transform(~N[1970-01-01 00:00:00], :naive_datetime) === {:ok, ~N[1970-01-01 00:00:00]}
    end

    test ":utc_datetime" do
      assert Type.transform(~N[1970-01-01 00:00:00], :utc_datetime) === DateTime.from_unix(0)
    end

    test ":time" do
      assert Type.transform(~N[1970-01-01 00:00:00], :time) === {:ok, ~T[00:00:00]}
    end

    test ":string" do
      assert Type.transform(~N[1970-01-01 00:00:00], :string) === {:ok, "1970-01-01 00:00:00"}
    end

    test ":binary" do
      assert Type.transform(~N[1970-01-01 00:00:00], :string) === {:ok, "1970-01-01 00:00:00"}
    end
  end
end