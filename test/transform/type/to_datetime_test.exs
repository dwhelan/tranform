defmodule Transformer.Type.ToDateTimeTest do
  use ExUnit.Case
  import Transform.Type

  describe "to :datetime" do
    test "from 'nil'" do
      assert transform(nil, :datetime) === {:ok, nil}
    end

    test "from String" do
      assert transform("1970-01-01 00:00:00", :datetime) === DateTime.from_unix(0)
    end

    test "from Integer" do
      assert transform(0, :datetime) === DateTime.from_unix(0)
    end

    test "from Date" do
      assert transform(~D[1970-01-01], :datetime) === DateTime.from_unix(0)
    end

    test "from Time should be an error" do
      assert transform(~T[00:00:00], :datetime) === :error
    end

    test "from DateTime" do
      {:ok, datetime} = DateTime.from_unix(0)
      assert transform(datetime, :datetime) === DateTime.from_unix(0)
    end

    test "from NaiveDateTime" do
      assert transform(~N[1970-01-01 00:00:00], :datetime) === DateTime.from_unix(0)
    end
  end
end
