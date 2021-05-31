require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here

    # validates :name, presence: true
    # validates :price, presence: true
    # validates :quantity, presence: true
    # validates :category, presence: true 

    category1 = Category.create name: 'cars'
    product1 = category1.products.create ({name: 'Toyota', price: 30000, quantity: 10})

    it 'all fields are valide' do
      expect(product1).to be_valid
    end

    it 'validates if name is present' do
      product1.name = nil
      expect(product1).to_not be_valid
    end

    it 'validates if price is present' do
      product1.price = nil
      expect(product1).to_not be_valid
    end

    it 'validates if quantity is present' do
      product1.quantity = nil
      expect(product1).to_not be_valid
    end

    it 'validates if category is present' do
      category1.name = nil
      expect(product1).to_not be_valid
    end

  end
end
