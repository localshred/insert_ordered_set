defmodule InsertOrderedSet.Mixfile do
  use Mix.Project

  def project do
    [app: :insert_ordered_set,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [
      { :dogma, "~> 0.0" },
    ]
  end

  defp description do
    """
    Provides  a data structure with the following properties:

    1. Contains unique values.
    2. O(1) manipulation operations (e.g. insert, delete) by using an underlying Map.
    3. Preserves insertion order when converting to a list. Allows reverse insertion ordering.
    """
  end

  defp package do
    [
     files: ["lib", "mix.exs", "README.md", "LICENSE"],
     contributors: ["BJ Neilsen"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/localshred/insert_ordered_set"}
    ]
  end
end
