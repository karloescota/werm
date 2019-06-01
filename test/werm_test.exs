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
      item = [{"div", [{"class", "ep-A"}], ["DummySeller"]}]
      item_html = {"div", [], item}

      assert Werm.get_seller_id(item_html) == "DummySeller"
    end
  end

  describe ".get_item_context/1" do
    test "returns the price, description, and state of the item as a list" do
      price = {"div", [], ["$10"]}
      desc = {"div", [], ["Description"]}
      state = {"div", [], ["Used"]}

      item = [{"div", [{"class", "ep-k"}], [price, desc, state]}]
      item_html = {"div", [], item}

      assert Werm.get_item_context(item_html) == ["$10", "Description", "Used"]
    end
  end
end
