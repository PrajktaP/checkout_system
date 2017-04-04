class Discount
  attr_reader :product_code, :discount_type, :items_count, :free_items_count, :price, :free_product_code
  
  def initialize(product_code = "", discount_type = 0, items_count = 0, free_items_count = 0, price = 0, free_product_code = nil)
    @product_code   = product_code
    @discount_type  = discount_type
    @items_count = items_count
    @free_items_count = free_items_count
    @price = price
    @free_product_code = free_product_code
  end
  
  def apply_bulk_discount(actual_total, price_for_product)
    # final_price will be total price - rule.product.price * free items count
    return actual_total - (self.free_items_count * price_for_product[self.product_code])
  end
  
  def apply_free_offer_same_products(items_hash, actual_total, price_for_product)
    #discounted product_price * products count will be added & products actual price * products count will be minus
    return actual_total - (price_for_product[self.product_code] * items_hash[self.product_code]) + (self.price * items_hash[self.product_code])
  end
  
  def apply_free_offer_different_products(items_hash, actual_total, price_for_product)
    # if free item was scanned, its price will be minus from the total
    if items_hash.include?(self.free_product_code)
      return actual_total - price_for_product[self.free_product_code]
    else
      return actual_total
    end
  end
  
end
