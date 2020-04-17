import Config
config :iex, default_prompt: ">>>"
config :issues, github_url: "https://api.github.com"
config :logger, 
  compile_time_purge_matching: [
    [level_lower_than: :info]
  ]

# To read configuration from environment file
# import_config "#{Mix.env}.exs"
