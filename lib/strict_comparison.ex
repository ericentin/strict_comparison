defmodule StrictComparison do
  @moduledoc """
  Strict numeric comparison.

  In Elixir (and Erlang), all terms are comparable. While this is useful in many
  situations, sometimes you want comparing anything but 2 numbers to be an error
  (or, in the case of function clauses, not a match). Simply use this module and
  Elixir's comparator functions (`<`, `>`, `<=`, and `>=`) will only allow
  numeric arguments within the current scope.
  """

  import StrictComparison.Helpers

  @doc """
  Imports the `StrictComparison` macros into the current scope, and excludes
  their respective versions from `Kernel`.

  Supports the option `:only` which functions in the same manner as
  `Kernel.SpecialForms.import/2`, where only the specified macros will be
  excluded/imported.
  """
  @spec __using__(Keyword.t) :: Macro.t
  defmacro __using__(opts) do
    opts = Macro.expand(opts, __CALLER__)

    kernel_args = [except: Keyword.get(opts, :only, [>: 2, <: 2, >=: 2, <=: 2])]

    strict_comparison_args = if opts[:only], do: [only: opts.only], else: []

    quote do
      import Kernel, unquote(kernel_args)
      import StrictComparison, unquote(strict_comparison_args)
    end
  end

  @doc """
  Returns `true` if left is less than right.

  Only numbers can be compared with each other.

  Allowed in guard tests. Inlined by the compiler.

  ## Examples

      iex> 1 < 2
      true

  """
  defcomparator :<, :<

  @doc """
  Returns `true` if left is more than right.

  Only numbers can be compared with each other.

  Allowed in guard tests. Inlined by the compiler.

  ## Examples

      iex> 1 > 2
      false

  """
  defcomparator :>, :>

  @doc """
  Returns `true` if left is less than or equal to right.

  All terms in Elixir can be compared with each other.

  Allowed in guard tests. Inlined by the compiler.

  ## Examples

      iex> 1 <= 2
      true

  """
  defcomparator :<=, :"=<"

  @doc """
  Returns `true` if left is more than or equal to right.

  Only numbers can be compared with each other.

  Allowed in guard tests. Inlined by the compiler.

  ## Examples

      iex> 1 >= 2
      false

  """
  defcomparator :>=, :>=
end
