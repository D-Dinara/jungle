require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # Helper method to create a category and a product with that category
    def create_product(category, name: "Test Product", price: 100, quantity: 5)
      category = Category.create(name: category) if category
      Product.new(
        name: name,
        price_cents: price,
        quantity: quantity,
        category: category
      )
    end

    it "saves successfully when all fields are set" do
      product = create_product("Test Category")
      expect(product.save).to be_truthy
    end

    it "validates presence of name" do
      product = create_product("Test Category", name: nil)
      expect(product.save).to be_falsey
      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    it "validates presence of price" do
      product = create_product("Test Category", price: nil)
      expect(product.save).to be_falsey
      expect(product.errors.full_messages).to include("Price can't be blank")
    end

    it "validates presence of quantity" do
      product = create_product("Test Category", quantity: nil)
      expect(product.save).to be_falsey
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end

    it "validates presence of category" do
      product = create_product(nil)
      expect(product.save).to be_falsey
      expect(product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
