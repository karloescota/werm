defmodule Werm do
  @moduledoc """
  Documentation for Werm.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Werm.hello()
      :world

  """
  def hello do
    :world
  end

  def crawl do
    url = "https://sg.carousell.com/categories/electronics-7/?sort_by=time_created"

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{body: body}} ->
        IO.inspect body
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
    end
  end
end
