require 'dotenv'
require 'shopify_api'
Dotenv.load

ShopifyAPI::Base.site = "https://#{ENV['SHOPIFY_API_KEY']}:#{ENV['SHOPIFY_PASSWORD']}@#{ENV['SHOP_NAME']}.myshopify.com/admin"

File.open("#{ENV['SHOP_NAME']}-collections.json", "w") do |f|
  f.write("{\"collections\":#{ShopifyAPI::SmartCollection.all.to_json}}")
end
