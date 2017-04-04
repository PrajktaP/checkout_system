class Checkout
  attr_accessor :basket
  attr_reader :pricing_service
  
  def initialize(pricing_rules = [])
    @pricing_service = PricingService.new(pricing_rules)
    @basket = []
  end

  def scan(item)
    basket << item
  end
  
  def total
    process(basket)
  end
  
  def process items    
    items_hash, actual_total, price_for_product = get_each_items_count(items)
    
    puts "Skus scanned: #{scanned_skus}"
    
    pricing_service.rules.each do |rule|
      if (rule.discount_type == DiscountType::TYPE[:free_offer_same_products]) and (items_hash.has_key? rule.product_code) and (items_hash[rule.product_code] >= rule.items_count)
        actual_total = rule.apply_bulk_discount(actual_total, price_for_product)
      end  
      
      if rule.discount_type == DiscountType::TYPE[:bulk_discount] and (items_hash.has_key? rule.product_code) and (items_hash[rule.product_code] >= rule.items_count)
        actual_total = rule.apply_free_offer_same_products(items_hash, actual_total, price_for_product)
      end
      
      if rule.discount_type == DiscountType::TYPE[:free_offer_different_products] and (items_hash.has_key? rule.product_code)
        actual_total = rule.apply_free_offer_different_products(items_hash, actual_total, price_for_product)
      end
    end
    
    return actual_total
  end
  
  def get_each_items_count(total_items)
    items_hash = {}
    actual_total = 0
    price_for_product = {}
    total_items.map{|i| 
      actual_total = actual_total + i.price
      items_hash[i.code] = 0 if items_hash[i.code].nil?
      items_hash[i.code] = items_hash[i.code] + 1
      price_for_product[i.code] = i.price
    }
    return items_hash, actual_total, price_for_product
  end
  
  def scanned_skus
    basket.collect{|item| item.code}.join(', ')
  end

end
