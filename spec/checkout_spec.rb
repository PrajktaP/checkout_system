require 'spec_helper'

describe Checkout do
  ProductStub = Struct.new(:code, :name, :price)
  subject { Checkout.new }

  describe 'initializing' do
    it 'should start with empty total i.e. when basket is empty' do
      expect(subject.total).to eq(0.0)
    end
  end

  context 'with no rules' do
    describe 'scanning products' do
      let(:product) { ProductStub.new('1', 'name', 10) }
      let(:product1) { ProductStub.new('2', 'name2', 15) }

      it 'should calculate total as the product price' do
        subject.scan(product)
        expect(subject.total).to eq(10)
      end

      it 'should calculate total as the cumulative product prices' do
        subject.scan(product)
        subject.scan(product1)
        expect(subject.total).to eq(25)
      end

    end
  end

  context 'with pricing rules' do
    let(:product1) { ProductStub.new('1', 'name1', 50) }
    let(:product2) { ProductStub.new('2', 'name2', 55) }
    let(:product3) { ProductStub.new('3', 'name3', 60) }
    
    d1 = Discount.new('1', DiscountType::TYPE[:bulk_discount], 3, 0, 40.00)
    d2 = Discount.new('2', DiscountType::TYPE[:free_offer_same_products], 3, 1, 0)
    d3 = Discount.new('3', DiscountType::TYPE[:free_offer_different_products], 0, 0, 0, '2')

    promotional_rules = []
    promotional_rules << d1
    promotional_rules << d2
    promotional_rules << d3
    subject {Checkout.new promotional_rules}

    describe 'calculating total after discounts' do
      
      it 'should not apply any discount' do
        subject.scan(product1)
        subject.scan(product1)
        subject.scan(product3)
        expect(subject.total).to eq(160)
      end

      it 'should apply bulk discount correctly' do
        subject.scan(product1)
        subject.scan(product1)
        subject.scan(product2)
        subject.scan(product1)
        expect(subject.total).to eq(175)
      end
      
      it 'should apply free_offer_different_products correctly' do
        subject.scan(product1)
        subject.scan(product2)
        subject.scan(product3)
        expect(subject.total).to eq(110)
      end
      
      it 'should apply free_offer_same_products correctly' do
        subject.scan(product1)
        subject.scan(product2)
        subject.scan(product2)
        subject.scan(product2)
        expect(subject.total).to eq(160)
      end
    end  
  end
  
end
