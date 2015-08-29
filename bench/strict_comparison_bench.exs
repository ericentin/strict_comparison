defmodule StrictComparisonBench do
  use Benchfella

  @nums Stream.repeatedly(fn -> round(:random.uniform * 1000) end) |> Enum.take(100) |> Enum.chunk(2)
  @float_nums Stream.repeatedly(fn -> :random.uniform * 1000 end) |> Enum.take(100) |> Enum.chunk(2)

  bench "regular comparison" do
    for [num, num2] <- @nums do
      num < num2
    end
  end

  bench "regular comparison float" do
    for [num, num2] <- @float_nums do
      num < num2
    end
  end

  defmodule LooseComparisonGuardBench do
    def lt(a, b) when a < b, do: true
    def lt(_, _), do: false
  end

  bench "regular guard" do
    for [num, num2] <- @nums do
      LooseComparisonGuardBench.lt(num, num2)
    end
  end

  bench "regular guard float" do
    for [num, num2] <- @float_nums do
      LooseComparisonGuardBench.lt(num, num2)
    end
  end

  use StrictComparison

  bench "strict comparison" do
    for [num, num2] <- @nums do
      num < num2
    end
  end

  bench "strict comparison float" do
    for [num, num2] <- @float_nums do
      num < num2
    end
  end

  defmodule StrictComparisonGuardBench do
    use StrictComparison

    def lt(a, b) when a < b, do: true
    def lt(_, _), do: false
  end

  bench "strict guard" do
    for [num, num2] <- @nums do
      StrictComparisonGuardBench.lt(num, num2)
    end
  end

  bench "strict guard float" do
    for [num, num2] <- @float_nums do
      StrictComparisonGuardBench.lt(num, num2)
    end
  end
end
