defmodule Transformer.Type.FromTimeTest do
  use ExUnit.Case
  alias Transform.Type

  describe "from Time to" do
    test ":date" do
      assert Type.transform(~T[00:00:00], :date) === :error
    end

    test ":naive_datetime" do
      assert Type.transform(~T[00:00:00], :naive_datetime) === :error
    end

    test ":time" do
      assert Type.transform(~T[00:00:00], :time) === {:ok, ~T[00:00:00]}
    end

    test ":string" do
      assert Type.transform(~T[00:00:00], :string) === {:ok, "00:00:00"}
    end

    test ":binary" do
      assert Type.transform(~T[00:00:00], :binary) === {:ok, "00:00:00"}
    end
  end
end
