require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    it 'when the name field is nil' do
      @category = Category.new(name: 'test')
      @product = Product.new(name: nil, price_cents: 1000, quantity: 1, category: @category)
      expect(@product).to_not be_valid
    end
    it 'when the price is nil in the field' do
      @category = Category.new(name: 'test')
      @product = Product.new(name: 'john', price_cents: nil, quantity: 1, category: @category)
      expect(@product).to_not be_valid
    end
    it 'when the quantity field contains nil' do
      @category = Category.new(name: 'test')
      @product = Product.new(name: 'john', price_cents: 1000, quantity: nil, category: @category)
      expect(@product).to_not be_valid
    end
    it 'when the category field contains nil' do
      @category = Category.new(name: 'test')
      @product = Product.new(name: 'john', price_cents: 1000, quantity: 1, category: nil)
      expect(@product).to_not be_valid
    end
  end
end