defmodule HelmTest do
  use ExUnit.Case
  doctest Helm

  test "greets the world" do
    assert Helm.hello() == :world
  end
end
