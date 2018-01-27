defmodule Transform.Transform do
  defmacro __using__(_opts) do
    quote do
      import unquote __MODULE__

      Module.register_attribute __MODULE__, :transforms, accumulate: true
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
      Module.eval_quoted __ENV__, Transform.Transform.__transforms__(@transforms)
    end
  end

  def __transforms__(transforms) do
    quote do
      def __transforms__(), do: unquote(transforms)
    end
  end

  defmacro field(name, transforms \\ []) do
    quote bind_quoted: [name: name, transforms: remove_greater_than(transforms)] do
      Module.put_attribute __MODULE__, :transforms, {name, transforms}
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
