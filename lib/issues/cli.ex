defmodule Issues.CLI do
  import Issues.TableFormatter, only: [print_table_for_columns: 2]

  @default_count 4

  def main(argv) do
    argv
    |> parse_args
    |> process
  end

  @moduledoc """
  Handle the command line parsing and the dispatch to
  the various functions that end up generating a table
  of the last __n__ issues in a github project
  """

  def run(argv) do
    argv
    |> parse_args
    |> process
  end

  @doc """
  `argv` can be -h or --help, which returns :help.
  Otherwise it is a github user name, project name and (optionally)
  the number of entries to format.
  Return a tuple of `{user, project, count}`, or `:help` if help was given
  """
  def parse_args(argv) do
    OptionParser.parse(argv,
      switches: [:help, :boolean],
      aliases: [h: :help]
    )
    |> elem(1)
    |> args_to_internal_representation()
  end

  defp args_to_internal_representation([user, project, count]) do
    {user, project, String.to_integer(count)}
  end

  defp args_to_internal_representation([user, project]) do
    {user, project, @default_count}
  end

  defp args_to_internal_representation(_), do: :help

  defp process(:help) do
    IO.puts("""
    usage: issues <user> <project> [ count | #{@default_count} ]
    """)

    System.halt(0)
  end

  defp process({user, project, count}) do
    Issues.GithubIssues.fetch(user, project)
    |> decode_response()
    |> sort_issues()
    |> take_last(count)
    |> print_table_for_columns(["number", "created_at", "title"])
  end

  defp take_last(list, count) do
    list
    |> Enum.take(count)
    |> Enum.reverse()
  end

  defp decode_response({:ok, body}), do: body

  defp decode_response({:error, error}) do
    IO.puts("Error fetching from Github #{error[:message]}")
    System.halt(0)
  end

  def sort_issues(issues) do
    issues
    |> Enum.sort(fn lhs, rhs ->
      lhs["created_at"] >= rhs["created_at"]
    end)
  end
end
