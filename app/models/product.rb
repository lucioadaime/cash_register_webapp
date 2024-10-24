require "json"

class Product < ApplicationRecord
  # Class variable to store preset products
  @@preset_products = []

  attr_reader :code, :name, :price

  def initialize(attributes = {})
    puts "Initializing product with attributes: #{attributes.inspect}" # Debugging line
    @code = attributes[:code] # Ensure we're using symbols for hash keys
    @name = attributes[:name]
    @price = attributes[:price].to_f


    # Raise an error if any attribute is nil
    raise "Product attributes cannot be nil: #{attributes}" if @code.nil? || @name.nil? || @price.nil?
  end

  # Class method to retrieve preset products
  def self.preset_products
    load_preset_products if @@preset_products.empty? # Load products if not already loaded
    @@preset_products
  end

  # Find a product by its code
  def self.find_by_code(code)
    code = code.to_s.upcase
    puts "Searching for product with code: #{code}" # Debugging line
    product = preset_products.find { |product| product.code == code }

    unless product
      raise ArgumentError, "Product with code '#{code}' not found"
    end
    product
  end

  # Load preset products from a JSON file
  def self.load_preset_products
    file_path = Rails.root.join("data", "products.json")

    # Ensure the file exists before trying to read
    if File.exist?(file_path)
      products_data = JSON.parse(File.read(file_path))
      @@preset_products = products_data.map do |data|
        puts "Loading product: #{data.inspect}" # Debugging line
        Product.new(code: data["code"], name: data["name"], price: data["price"].to_f)
      end
      puts "Loaded products: #{@@preset_products.inspect}" # Debugging line
    else
      puts "Products file not found at #{file_path}" # Debugging line
    end
  end

  def inspect
    "#<Product code: #{@code}, name: #{@name}, price: #{@price}>"
    # Use the instance variables directly
  end
  # Ensure code is unique
  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
