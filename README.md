# Issues

Fetch the most recent issues from a github project.

![fetching issues from Github](https://i.imgur.com/HxlRiyu.png)

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `issues` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:issues, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/issues](https://hexdocs.pm/issues).

## To start iex with our app code

```shell
iex -S mix
```

## To compile the mix project

```shell
mix escript.build
```

## To execute the binary

```shell
#        github user | project | number of issues to fetch 
./issues elixir-lang elixir 10
```
