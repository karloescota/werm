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
      seller_id = {"div", [{"class", "ep-A"}], ["DummySeller"]}
      item = {"div", [], [seller_id]}

      assert Werm.get_seller_id(item) == "DummySeller"
    end
  end

  describe ".get_item_context/1" do
    test "returns the price, description, and state of the item as a list" do
      price = {"div", [], ["$10"]}
      desc = {"div", [], ["Description"]}
      state = {"div", [], ["Used"]}

      context = {"div", [{"class", "ep-k"}], [price, desc, state]}
      item = {"div", [], [context]}

      assert Werm.get_item_context(item) == ["$10", "Description", "Used"]
    end
  end

  describe ".get_item_link/1" do
    test "returns the item link" do
      link = {"a", [{"class", "ep-ab"}, {"href", "https://item-link"}], []}
      item = {"div", [], [link]}

      assert Werm.get_item_link(item) == "https://item-link"
    end
  end
end
