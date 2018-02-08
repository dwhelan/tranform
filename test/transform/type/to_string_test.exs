defmodule Transformer.Type.ToStringTest do
  use ExUnit.Case
  import Transform.Type

  describe "to :string" do
    test "from 'nil'" do
      assert transform(nil, :string) === {:ok, nil}
    end

    test "from Boolean 'false'" do
      assert transform(false, :string) === {:ok, "false"}
    end

    test "from Boolean 'true'" do
      assert transform(true, :string) === {:ok, "true"}
    end

    test "from String" do
      assert transform("abc", :string) === {:ok, "abc"}
    end

    test "from Integer" do
      assert transform(123, :string) === {:ok, "123"}
    end

    test "from Float" do
      assert transform(123.0, :string) === {:ok, "123.0"}
    end

    test "from Decimal" do
      assert transform(Decimal.new(123), :string) === {:ok, "123"}
    end

    test "from Date" do
      assert transform(~D[1970-01-01], :string) === {:ok, "1970-01-01"}
    end

    test "from Date with format" do
      assert transform(~D[1970-01-01], :string, "{Mfull} {D}, {YYYY}") === {:ok, "January 1, 1970"}
    end
    
    test "from Date with format and locale" do
      assert transform(~D[1970-01-01], :string, "{Mfull} {D}, {YYYY}", "fr") === {:ok, "janvier 1, 1970"}
    end

    test "from Date with multiple localized formats" do
      locale_format = ["fr": "{D} {Mfull}, {YYYY}", "en": "{Mfull} {D}, {YYYY}"]
      assert transform(~D[1970-01-01], :string, locale_format, "en") === {:ok, "January 1, 1970"}
      assert transform(~D[1970-01-01], :string, locale_format, "fr") === {:ok, "1 janvier, 1970"}
    end

    test "from Time" do
      assert transform(~T[00:00:00], :string) === {:ok, "00:00:00"}
    end

    test "from DateTime" do
      {:ok, datetime} = DateTime.from_unix(0)
      assert transform(datetime, :string) === {:ok, "1970-01-01 00:00:00Z"}
    end

    test "from DateTime with format" do
      {:ok, datetime} = DateTime.from_unix(0)
      assert transform(datetime, :string, "{Mfull} 1, {YYYY}") === {:ok, "January 1, 1970"}
    end
    
    test "from DateTime with multiple localized formats" do
      {:ok, datetime} = DateTime.from_unix(0)
      assert transform(datetime, :string, "{Mfull} 1, {YYYY}", "fr") === {:ok, "janvier 1, 1970"}
    end

    test "from NaiveDateTime" do
      assert transform(~N[1970-01-01 00:00:00], :string) === {:ok, "1970-01-01 00:00:00"}
    end

    test "from NaiveDateTime with format" do
      assert transform(~N[1970-01-01 00:00:00], :string, "{Mfull} 1, {YYYY}") === {:ok, "January 1, 1970"}
    end
    
    test "from NaiveDateTime with format and locale" do
      assert transform(~N[1970-01-01 00:00:00], :string, "{Mfull} 1, {YYYY}", "fr") === {:ok, "janvier 1, 1970"}
    end
  end
end
