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
    quote do
      Module.put_attribute __MODULE__, :locale, unquote(locale)
    end
  end

  defmacro field(name, transforms \\ []) do
    quote bind_quoted: [name: name, transforms: remove_greater_than(transforms)] do
      Module.put_attribute __MODULE__, :transforms, {name, transforms}
    end
  end

  def __transform__(transforms, locale) do
    quote do
      def __transform__(), do: unquote(transforms)
      def __transform__(:locale), do: unquote(locale)
    end
  end

  defp remove_greater_than(transforms) do
    Enum.map(transforms, fn {name, transform} ->
      {name, case transform do
               {:>, _, list} -> list
               list          -> list
             end
      }
    end)
  end
end
