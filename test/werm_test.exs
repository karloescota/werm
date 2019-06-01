defmodule WermTest do
  use ExUnit.Case
  doctest Werm

  test "greets the world" do
    assert Werm.hello() == :world
  end
end
