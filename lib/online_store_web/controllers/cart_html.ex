defmodule OnlineStoreWeb.CartHTML do
  use OnlineStoreWeb, :html

  alias OnlineStore.ShoppingCart

  embed_templates "cart_html/*"

  def currency_to_str(%Decimal{} = val), do: "$#{Decimal.round(val, 2)}"
end
