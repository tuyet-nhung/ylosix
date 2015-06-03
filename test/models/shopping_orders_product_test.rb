# == Schema Information
#
# Table name: shopping_orders_products
#
#  created_at           :datetime         not null
#  id                   :integer          not null, primary key
#  product_id           :integer
#  quantity             :integer          default(1), not null
#  retail_price         :decimal(10, 2)   default(0.0), not null
#  retail_price_pre_tax :decimal(10, 5)   default(0.0), not null
#  shopping_order_id    :integer
#  tax_percent          :decimal(5, 2)    default(0.0), not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_shopping_orders_products_on_product_id         (product_id)
#  index_shopping_orders_products_on_shopping_order_id  (shopping_order_id)
#

require 'test_helper'

class ShoppingOrdersProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
