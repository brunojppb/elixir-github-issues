defmodule CliTest do
  use ExUnit.Case
  doctest Issues

  import Issues.CLI, only: [parse_args: 1, sort_issues: 1]

  test ":help returned by option parsing with -h and --help options" do
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test "three values returned if three is given" do
    assert parse_args(["brunojppb", "pandemic-apps", "99"]) == {"brunojppb", "pandemic-apps", 99}
  end

  test "count is defaulted if two values given" do
    assert parse_args(["brunojppb", "pandemic-apps"]) == {"brunojppb", "pandemic-apps", 4}
  end

  test "sort issues in descending order" do
    result = sort_issues(generate_fake_issues(["c", "a", "b"]))
    issues = for issue <- result, do: Map.get(issue, "created_at")
    assert issues == ~w{c b a}
  end

  defp generate_fake_issues(values) do
    for v <- values, do: %{"created_at" => v, "other_data" => "xxx"}
  end
end
