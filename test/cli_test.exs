defmodule CliTest do
  use ExUnit.Case
  doctest Issues

  import Issues.CLI, only: [parse_args: 1]

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
end
