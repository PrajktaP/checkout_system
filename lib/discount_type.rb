class DiscountType
  attr_reader :name
  
  TYPE = { bulk_discount: 1, free_offer_same_products: 2, free_offer_different_products: 3 }
  
  def initialize(type)
    @type  = type
  end
end
