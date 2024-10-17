require "json"


class Product < ApplicationRecord
  # Class variable to store preset products
  @preset_products = []

  def self.preset_products
    @preset_products.empty? ? load_preset_products : @preset_products
  end

  # Find a product by its code
  def self.find_by_code(code)
    code = code.to_s.upcase
    @preset_products.find { |product| product.code == code }
  end
  # Load preset products from a JSON file
  def self.load_preset_products
    file_path = Rails.root.join("data", "products.json") # Construct the path to the JSON file
    products_data = JSON.parse(File.read(file_path))
    @preset_products = products_data.map do |data|
      new(data["code"], data["name"], data["price"].to_f) # Create product instances
    end
  end

  # Ensure code is unique
  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
