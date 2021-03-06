defmodule Issues.GithubIssues do
  require Logger

  @user_agent [{"User-agent", "Elixir bruno@bpaulino.com"}]

  def fetch(user, project) do
    Logger.info("Fetching #{user}'s project #{project}")

    issues_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  def issues_url(user, project) do
    "#{github_url()}/repos/#{user}/#{project}/issues"
  end

  def handle_response({_, %{status_code: status_code, body: body}}) do
    Logger.info("Response status: #{status_code}")
    Logger.debug(fn -> inspect(body) end)
    {
      status_code |> check_for_error(),
      body |> Poison.Parser.parse!()
    }
  end

  def check_for_error(200), do: :ok
  def check_for_error(_), do: :error

  defp github_url() do
    Application.get_env(:issues, :github_url)
  end
end
