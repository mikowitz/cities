defmodule CitiesTest do
  use ExUnit.Case
  doctest Cities

  test "greets the world" do
    assert Cities.hello() == :world
  end
end
