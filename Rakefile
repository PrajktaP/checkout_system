require 'rspec/core'
require 'rspec/core/rake_task'

task default: :spec

desc 'Run all specs in spec directory (excluding plugin specs)'
RSpec::Core::RakeTask.new(:spec)

desc 'Run CheckOut'
task :run_checkout do

  project_root = File.dirname(File.absolute_path(__FILE__))
  Dir.glob(project_root + '/lib/*') { |file| require file }
  
  ipd = Product.new('ipd', 'Super iPad', 549.99)
  mbp = Product.new( 'mbp',  'MacBook Pro',  1399.99)
  atv = Product.new( 'atv',  'Apple TV',  109.50)
  vga = Product.new( 'vga',  'VGA adapter',  30.00)
  
  #product code, discount type, items_count, free_items_count, price, free_product_code
  d1 = Discount.new('ipd', DiscountType::TYPE[:bulk_discount], 4, 0, 499.99)
  #For example, if you buy 3 Apple TVs, you will pay the price of 2 only. So one is free
  
  d2 = Discount.new('atv', DiscountType::TYPE[:free_offer_same_products], 3, 1, 0)
  #example: the price will drop to $499.99 each, if someone buys more than 4
  
  d3 = Discount.new('mbp', DiscountType::TYPE[:free_offer_different_products], 0, 0, 0, 'vga')
  #example: VGA adapter free of charge with every MacBook Pro sold

    # # set up rules
  promotional_rules = []
  promotional_rules << d1
  promotional_rules << d2
  promotional_rules << d3
  

  puts 'Scenario 0:'

  checkout = Checkout.new(promotional_rules)
  checkout.scan(atv)
  checkout.scan(vga)  
  
  puts "Total: $#{checkout.total}"
  
  
  puts 'Scenario 1:'

  checkout = Checkout.new(promotional_rules)
  checkout.scan(atv)
  checkout.scan(atv)
  checkout.scan(atv)
  checkout.scan(vga)  
  
  puts "Total: $#{checkout.total}"
  
  
  puts 'Scenario 2:'

  checkout = Checkout.new(promotional_rules)
  checkout.scan(atv)
  checkout.scan(ipd)
  checkout.scan(ipd)
  checkout.scan(atv)
  checkout.scan(ipd)
  checkout.scan(ipd)
  checkout.scan(ipd)
  
  puts "Total: $#{checkout.total}"
  
  
  puts 'Scenario 3a: where free product is already added to the basket'

  checkout = Checkout.new(promotional_rules)
  checkout.scan(mbp)
  checkout.scan(vga)
  checkout.scan(ipd)
  
  puts "Total: $#{checkout.total}"
  
  puts 'Scenario 3b: where free product is not added to basket'

  checkout = Checkout.new(promotional_rules)
  checkout.scan(mbp)
  checkout.scan(ipd)
  
  puts "Total: $#{checkout.total}"
  
  
  puts 'Scenario 4:'

  checkout = Checkout.new(promotional_rules)
  checkout.scan(atv)
  checkout.scan(ipd)
  checkout.scan(ipd)
  checkout.scan(atv)
  checkout.scan(ipd)
  checkout.scan(ipd)
  checkout.scan(ipd)
  checkout.scan(atv)
  
  puts "Total: $#{checkout.total}"
  
  
  puts 'Scenario 5:'

  checkout = Checkout.new(promotional_rules)
  checkout.scan(atv)
  checkout.scan(ipd)
  checkout.scan(ipd)
  checkout.scan(atv)
  checkout.scan(ipd)
  checkout.scan(ipd)
  checkout.scan(ipd)
  checkout.scan(atv)
  checkout.scan(atv)
  
  puts "Total: $#{checkout.total}"
  

end
