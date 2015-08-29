defmodule StrictComparison.Helpers do
  @moduledoc false

  @compile {:inline, <: 2, >: 2, <=: 2, >=: 2}

  @doc false
  def left < right when is_number(left) and is_number(right) do
    :erlang.<(left, right)
  end

  @doc false
  def left > right when is_number(left) and is_number(right) do
    :erlang.>(left, right)
  end

  @doc false
  def left <= right when is_number(left) and is_number(right) do
    :erlang."=<"(left, right)
  end

  @doc false
  def left >= right when is_number(left) and is_number(right) do
    :erlang.>=(left, right)
  end

  defmacro defcomparator(name, erlang_func) do
    quote do
      defmacro unquote(name)(left, right) do
        erlang_func = unquote(erlang_func)
        name = unquote(name)

        if __CALLER__.context do
          quote do
            is_number(unquote(left))
            and is_number(unquote(right))
            and :erlang.unquote(erlang_func)(unquote(left), unquote(right))
          end
        else
          quote do
            StrictComparison.Helpers.unquote(name)(unquote(left), unquote(right))
          end
        end
      end
    end
  end
end
