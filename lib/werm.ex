defmodule Werm do
  def crawl do
    url = "https://sg.carousell.com/categories/electronics-7/?sort_by=time_created"

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{body: html}} ->
        html
        |> get_items()

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
end
