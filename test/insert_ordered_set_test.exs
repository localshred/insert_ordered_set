defmodule InsertOrderedSetTest do
  use ExUnit.Case
  doctest InsertOrderedSet

  alias InsertOrderedSet, as: S

  test "#new" do
    expected_map = %{
      "post-item-415" => 0,
      "post-item-954" => 1,
      "post-item-599" => 2,
      "post-item-219" => 3,
      "post-item-779" => 4,
      "post-item-201" => 5,
      "post-item-999" => 6,
    }

    actual = S.new([
      "post-item-415",
      "post-item-954",
      "post-item-599",
      "post-item-219",
      "post-item-779",
      "post-item-201",
      "post-item-999",
    ])

    assert(expected_map == actual.map)
    assert(7 == actual.next_index)
  end

  test "#to_list" do
    expected = [
      "post-item-415",
      "post-item-954",
      "post-item-599",
      "post-item-219",
      "post-item-779",
      "post-item-201",
      "post-item-999",
    ]

    actual = S.new
              |> S.put("post-item-415")
              |> S.put("post-item-954")
              |> S.put("post-item-599")
              |> S.put("post-item-219")
              |> S.put("post-item-779")
              |> S.put("post-item-201")
              |> S.put("post-item-999")
              |> S.to_list

    assert(expected == actual)
  end

  test "hashset order does not obey insertion order" do
    expected = [
      "post-item-415",
      "post-item-954",
      "post-item-599",
      "post-item-219",
      "post-item-779",
      "post-item-201",
      "post-item-999",
    ]

    actual = HashSet.new
              |> HashSet.put("post-item-415")
              |> HashSet.put("post-item-954")
              |> HashSet.put("post-item-599")
              |> HashSet.put("post-item-219")
              |> HashSet.put("post-item-779")
              |> HashSet.put("post-item-201")
              |> HashSet.put("post-item-999")
              |> HashSet.to_list

    refute(expected == actual)
  end

  test "#delete" do
    expected_map = %{
      "post-item-415" => 0,
      "post-item-599" => 2,
      "post-item-779" => 4,
      "post-item-201" => 5,
      "post-item-999" => 6,
    }

    actual = [
      "post-item-415",
      "post-item-954",
      "post-item-599",
      "post-item-219",
      "post-item-779",
      "post-item-201",
      "post-item-999",
    ]
    |> S.new
    |> S.delete("post-item-219")
    |> S.delete("post-item-954")

    assert(expected_map == actual.map)
    assert(7 == actual.next_index)
  end

  test "#delete with re-insertion" do
    expected_map = %{
      "post-item-415" => 0,
      "post-item-954" => 8,
      "post-item-599" => 2,
      "post-item-219" => 7,
      "post-item-779" => 4,
      "post-item-201" => 5,
      "post-item-999" => 6,
    }

    actual = [
      "post-item-415",
      "post-item-954",
      "post-item-599",
      "post-item-219",
      "post-item-779",
      "post-item-201",
      "post-item-999",
    ]
    |> S.new
    |> S.delete("post-item-219")
    |> S.delete("post-item-954")
    |> S.put("post-item-219")
    |> S.put("post-item-954")

    assert(expected_map == actual.map)
    assert(9 == actual.next_index)
  end

  test "#member?" do
    actual = [ "post-item-415" ]
              |> S.new
              |> S.member?("post-item-415")

    assert(actual)
  end

  test "#put with same item shouldn't change index" do
    expected_map = %{
      "post-item-415" => 0,
    }

    actual = S.new
              |> S.put("post-item-415")
              |> S.put("post-item-415")
              |> S.put("post-item-415")

    assert(expected_map == actual.map)
    assert(1 == actual.next_index)
  end

  test "#size" do
    actual = S.new([
      "post-item-415",
      "post-item-954",
      "post-item-599",
      "post-item-219",
      "post-item-779",
      "post-item-201",
      "post-item-999",
    ])

    assert(7 == S.size(actual))
  end

  test "#size after multiple puts and deletes" do
    assert(0 == S.size(S.new))
    assert(1 == S.size(S.new([ "post-item-415" ])))

    set = [
      "post-item-415",
      "post-item-954",
      "post-item-599",
      "post-item-219",
      "post-item-779",
      "post-item-201",
      "post-item-999",
    ]
    |> S.new
    |> S.delete("post-item-999")
    |> S.delete("post-item-599")
    |> S.put("foo")
    assert(6 == S.size(set))
  end

  test "#size after deleting non-member item" do
    set = [
      "post-item-415",
      "post-item-954",
      "post-item-599",
      "post-item-219",
      "post-item-779",
      "post-item-201",
      "post-item-999",
    ]
    |> S.new
    |> S.delete("foo")
    |> S.delete("bar")
    |> S.delete("baz")
    assert(7 == S.size(set))
  end

  test "#size after deleting from empty set" do
    set = S.new
    |> S.delete("foo")
    |> S.delete("bar")
    |> S.delete("baz")
    assert(0 == S.size(set))
  end

end
