# InsertOrderedSet

An `InsertOrderedSet` is a data structure with the following properties:

1. Contains unique values.
2. O(1) manipulation operations (e.g. insert, delete)
3. Preserves insertion order when converting to a list.

This data structure loosely conforms to the `Set` protocol, I'll be adding full support soon.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `insert_ordered_set` to your list of dependencies in `mix.exs`:

        def deps do
          [{:insert_ordered_set, "~> 0.0.1"}]
        end

  2. Ensure `insert_ordered_set` is started before your application:

        def application do
          [applications: [:insert_ordered_set]]
        end

## Usage

Currently supported `Set` methods:

+ `delete/2`
+ `member?/2`
+ `new/0`
+ `new/1`
+ `put/2`
+ `size/1`
+ `to_list/1`

I've added an additional method wherein you can tell the `to_list` function to produce the list
in `:asc` (insertion order) or `:desc` (reverse insertion order) order.

+ `to_list/2`


#### Unique values

```elixir
[1, 1, 2]
|> InsertOrderedSet.new
|> InsertOrderedSet.to_list  # [ 1, 2 ]
```

#### Insertion order preservation

Try the following with `MapSet`:

```elixir
["b", "c", "a"]
|> InsertOrderedSet.new
|> InsertOrderedSet.to_list  # ["b", "c", "a"]
```

#### Retrieve list in reverse insertion order

```elixir
["b", "c", "a"]
|> InsertOrderedSet.new
|> InsertOrderedSet.to_list(:desc)  # ["a", "c", "b"]
```

## TODO

+ [ ] Implement the rest of the `Set` protocol.
+ [ ] Adopt the Enumerable protocol.
+ [ ] Add `@doc` annotations.
+ [ ] Add typespecs.

