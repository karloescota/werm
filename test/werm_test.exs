defmodule WermTest do
  use ExUnit.Case

  describe ".get_items/1" do
    test "returns the item list" do
      html = "<html><div class=\"ep-U\"></div><div class=\"ep-U\"></div></html>"
      assert Werm.get_items(html) == [
               {"div", [{"class", "ep-U"}], []},
               {"div", [{"class", "ep-U"}], []}
             ]
    end
  end

  describe ".get_seller_id/1" do
    test "returns the seller id" do
      item = {"div", [], [seller_id("DummySeller")]}
      assert Werm.get_seller_id(item) == "DummySeller"
    end
  end

  describe ".get_item_context/1" do
    test "returns the price, description, and state of the item as a list" do
      item = {"div", [], [context("$10", "Description", "Used")]}
      assert Werm.get_item_context(item) == ["$10", "Description", "Used"]
    end
  end

  describe ".get_item_link/1" do
    test "returns the item link" do
      item = {"div", [], [link("https://item-link")]}
      assert Werm.get_item_link(item) == "https://item-link"
    end
  end

  def seller_id(id) do
    {"div", [{"class", "ep-A"}], [id]}
  end

  def link(ref) do
    {"a", [{"class", "ep-ab"}, {"href", ref}], []}
  end

  def div(text) do
    {"div", [], [text]}
  end

  def context(price, desc, state) do
    {"div", [{"class", "ep-k"}], [div(price), div(desc), div(state)]}
  end
end
