defmodule Transformer.Type.FromDateTest do
  use ExUnit.Case
  alias Transform.Type

  describe "from Date to" do
    test ":date" do
      assert Type.transform(~D[1970-01-01], :date) === {:ok, ~D[1970-01-01]}
    end

    test ":naive_datetime" do
      assert Type.transform(~D[1970-01-01], :naive_datetime) === {:ok, ~N[1970-01-01 00:00:00]}
    end

    test ":utc_datetime" do
      assert Type.transform(~D[1970-01-01], :utc_datetime) === DateTime.from_unix(0)
    end

    test ":time" do
      assert Type.transform(~D[1970-01-01], :time) === {:ok, ~T[00:00:00]}
    end

    test ":string" do
      assert Type.transform(~D[1970-01-01], :string) === {:ok, "1970-01-01"}
    end

    test ":binary" do
      assert Type.transform(~D[1970-01-01], :binary) === {:ok, "1970-01-01"}
    end
  end
end
