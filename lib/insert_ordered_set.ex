defmodule InsertOrderedSet do
  @moduledoc """
  TODO
  """

  # TODO @behaviour Set

  defstruct(
    next_index: 0,
    map: %{},
    size: 0,
  )

  def delete(%InsertOrderedSet{ map: map, size: size } = set, item) do
    if Map.has_key?(map, item) do
      new_size = case size do
        0 -> 0
        s -> s - 1
      end

      %{ set |
        map: Map.delete(map, item),
        size: new_size,
      }
    else
      set
    end
  end

  def member?(%InsertOrderedSet{ map: map }, item), do: Map.has_key?(map, item)

  def new, do: %InsertOrderedSet{}
  def new(items) when is_list(items) do
    Enum.into(items, %InsertOrderedSet{})
  end

  def put(%InsertOrderedSet{ next_index: next_index, map: map, size: size } = set, item) do
    if Map.has_key?(map, item) do
      set
    else
      %{ set |
        next_index: next_index + 1,
        map: Map.put(map, item, next_index),
        size: size + 1,
      }
    end
  end

  def size(%InsertOrderedSet{ size: size } = _set), do: size

  def to_list(set, order \\ :asc)

  def to_list(%InsertOrderedSet{ map: map }, :desc) do
    map
    |> Enum.sort(&sort_descending_by_index(&1, &2))
    |> Enum.map(&extract_item(&1))
  end

  def to_list(%InsertOrderedSet{ map: map }, :asc) do
    map
    |> Enum.sort_by(&sort_ascending_by_index(&1))
    |> Enum.map(&extract_item(&1))
  end

  defp extract_item({ item, _index }), do: item
  defp sort_ascending_by_index({ _item, index }), do: index
  defp sort_descending_by_index({ _item1, index1 }, { _item2, index2 }), do: index1 > index2

  defimpl Collectable do
    def into(original) do
      {original, fn
          set, {:cont, x} -> InsertOrderedSet.put(set, x)
          set, :done -> set
          _, :halt -> :ok
      end}
    end
  end

end
