defmodule Transform.Transform do
  alias Timex.Translator

  defmacro __using__(_opts) do
    quote do
      import unquote __MODULE__

      Module.register_attribute __MODULE__, :transforms, accumulate: true
      Module.put_attribute __MODULE__, :locale, [in: Translator.current_locale, out: Translator.current_locale]
   end
  end

  defmacro transform(do: block) do
    quote do
      unquote(block)
      transform()
    end
  end

  defmacro transform do
    quote do
      Module.eval_quoted __ENV__, Transform.Transform.__transform__(@transforms, @locale)
    end
  end

  defmacro locale(locale) do
    quote bind_quoted: [locale: locale] do
      locale = cond do
        is_binary(locale) -> [in: locale, out: locale]
        true              -> locale
      end
      Module.put_attribute __MODULE__, :locale, locale
    end
  end

  defmacro locale(locale, map) do
    quote bind_quoted: [locale: locale, map: map] do
      Module.put_attribute __MODULE__, :locale, {locale, map}
    end
  end

  defmacro field(name, transforms \\ []) do
    quote bind_quoted: [name: name, transforms: transforms] do
      Module.put_attribute __MODULE__, :transforms, {name, transforms}
    end
  end

  def __transform__(transforms, locale) do
    quote do
      def __transform__(:transforms), do: unquote(transforms)
      def __transform__(:locale),     do: unquote(locale)
    end
  end
end
