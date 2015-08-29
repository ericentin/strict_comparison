[![Build Status](https://travis-ci.org/antipax/strict_comparison.svg?branch=master)](https://travis-ci.org/antipax/strict_comparison)

StrictComparison
================

Strict numeric comparison.

In Elixir (and Erlang), all terms are comparable. While this is useful in many situations, sometimes you want comparing anything but 2 numbers to be an error (or, in the case of function clauses, not a match).

Simply:

```elixir
use StrictComparison
```

and Elixir’s comparator functions (<, >, <=, and >=) will only allow numeric arguments within the current scope.

Includes a full test suite for both use in regular code and guards.

Also includes a benchmark (example results from my relatively modern laptop):

```
Settings:
  duration:      1.0 s

## StrictComparisonBench
[02:40:05] 1/8: strict guard float
[02:40:08] 2/8: strict guard
[02:40:10] 3/8: strict comparison float
[02:40:13] 4/8: strict comparison
[02:40:15] 5/8: regular guard float
[02:40:18] 6/8: regular guard
[02:40:20] 7/8: regular comparison float
[02:40:23] 8/8: regular comparison

Finished in 19.25 seconds

## StrictComparisonBench
regular comparison           1000000   1.68 µs/op
regular comparison float     1000000   2.06 µs/op
strict comparison            1000000   2.16 µs/op
regular guard                1000000   2.16 µs/op
regular guard float          1000000   2.21 µs/op
strict guard                 1000000   2.22 µs/op
strict guard float           1000000   2.33 µs/op
strict comparison float      1000000   2.50 µs/op
```

so it's a bit slower than the regular (non-strict) version. Note that each "op"
in this case is sorting 50 pairs of random numbers.
