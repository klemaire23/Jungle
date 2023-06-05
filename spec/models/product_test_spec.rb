require 'rails_helper'
require 'product'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it "should save successfully when all fields are set" do
      category = Category.create(name: "Sample Category")
      product = Product.new(
        name: 'Sample Product',
        price: 10.99,
        quantity: 5,
        category: category
      )
      expect(product.save).to be true
    end

    it "should require name to be present" do
      category = Category.new(name: "Sample Category")
      product = Product.new(
        price: 10.99,
        quantity: 5,
        category: category
      )
      product.save
      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    it "should require price to be present" do
      category = Category.new(name: "Sample Category")
      product = Product.new(
        name: 'Sample Product',
        quantity: 5,
        category: category
      )
      product.save
      expect(product.errors.full_messages).to include("Price can't be blank")
    end

    it "should require quantity to be present" do
      category = Category.new(name: "Sample Category")
      product = Product.new(
        name: 'Sample Product',
        price: 10.99,
        category: category
      )
      product.save
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end

    it "should require category to be present" do
      category = Category.new(name: "Sample Category")
      product = Product.new(
        name: 'Sample Product',
        price: 10.99,
        quantity: 5
      )
      product.save
      expect(product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
