defmodule Werm do
  def crawl do
    url = "https://sg.carousell.com/categories/electronics-7/?sort_by=time_created"

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{body: html}} ->
        html
        |> get_items()
        |> to_struct()

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
    end
  end

  def get_items(html) do
    Floki.find(html, "div.ep-U")
  end

  def get_seller_id(item) do
    Floki.find(item, "div.ep-A")
    |> Floki.text()
  end

  def get_item_context(item) do
    {_, _, context} = Floki.find(item, "div.ep-k") |> List.first()
    Enum.map(context, &(&1 |> Floki.text()))
  end

  def get_item_link(item) do
    Floki.find(item, "a.ep-ab")
    |> Floki.attribute("href")
    |> List.first()
  end

  def to_struct(items) do
    Enum.map(items, fn item ->
      seller_id = get_seller_id(item)
      [price, desc, state] = get_item_context(item)
      link = get_item_link(item)

      %{
        seller_id: seller_id,
        price: price,
        description: desc,
        state: state,
        link: link
      }
    end)
  end
end
