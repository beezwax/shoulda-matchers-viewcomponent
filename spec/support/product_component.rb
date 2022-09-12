# frozen_string_literal: true

class ProductComponent < ViewComponent::Base
  with_collection_parameter :product

  def initialize(product:, product_counter:, product_iteration:)
  end
end
