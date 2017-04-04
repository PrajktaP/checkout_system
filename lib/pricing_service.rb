
class PricingService
  def initialize(rules = [])
    @rules = rules
  end

  attr_reader :rules
end
