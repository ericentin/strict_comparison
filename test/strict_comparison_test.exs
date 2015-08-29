defmodule StrictComparisonTest.GuardTester do
  use StrictComparison

  def gt(a, b) when a > b, do: true
  def gt(_, _), do: false

  def lt(a, b) when a < b, do: true
  def lt(_, _), do: false

  def gte(a, b) when a >= b, do: true
  def gte(_, _), do: false

  def lte(a, b) when a <= b, do: true
  def lte(_, _), do: false
end

defmodule StrictComparisonTest do
  use ExUnit.Case, async: true

  import StrictComparisonTest.GuardTester

  doctest StrictComparison

  test "less than" do
    assert 1 < nil

    use StrictComparison

    assert catch_error(1 < nil) == :function_clause
    assert catch_error(nil < 1) == :function_clause

    refute 3 < 2
    refute 2 < 2
    assert 1 < 2

    refute lt(1, nil)
    refute lt(nil, 1)

    refute lt(3, 2)
    refute lt(2, 2)
    assert lt(1, 2)
  end

  test "greater than" do
    assert nil > 1

    use StrictComparison

    assert catch_error(nil > 1) == :function_clause
    assert catch_error(1 > nil) == :function_clause

    assert 3 > 2
    refute 2 > 2
    refute 1 > 2

    refute gt(nil, 1)
    refute gt(1, nil)

    assert gt(3, 2)
    refute gt(2, 2)
    refute gt(1, 2)
  end

  test "less than or equal" do
    assert 1 <= nil

    use StrictComparison

    assert catch_error(1 <= nil) == :function_clause
    assert catch_error(nil <= 1) == :function_clause

    refute 3 <= 2
    assert 2 <= 2
    assert 1 <= 2

    refute lte(1, nil)
    refute lte(nil, 1)

    refute lte(3, 2)
    assert lte(2, 2)
    assert lte(1, 2)
  end

  test "greater than or equal" do
    assert nil >= 1

    use StrictComparison

    assert catch_error(nil >= 1) == :function_clause
    assert catch_error(1 >= nil) == :function_clause

    assert 3 >= 2
    assert 2 >= 2
    refute 1 >= 2

    refute gte(nil, 1)
    refute gte(1, nil)

    assert gte(3, 2)
    assert gte(2, 2)
    refute gte(1, 2)
  end
end
