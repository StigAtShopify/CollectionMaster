require 'dotenv'
require 'shopify_api'
require 'json'
Dotenv.load

ShopifyAPI::Base.site = "https://#{ENV['SHOPIFY_API_KEY']}:#{ENV['SHOPIFY_PASSWORD']}@#{ENV['SHOP_NAME']}.myshopify.com/admin"
JSON.parse(File.read("#{ENV['SHOP_NAME']}-collections.json"))['collections'].each do |coll|
  sc = ShopifyAPI::SmartCollection.new(
    :handle => "DAVE"+coll['handle'],
    :title => "DAVE"+coll['title'],
    :body_html => coll['body_html'],
    :sort_order => coll['sort_order'],
    :template_suffix => coll['template_suffix'],
    :published_scope => coll['published_scope'],
    :disjunctive => coll['disjunctive'],
    :image => coll['image'],
    :rules => []
  )
  coll['rules'].each do |r|
    rule = ShopifyAPI::Rule.new(
      :column => r['column'],
      :relation => r['relation'],
      :condition => r['condition']
    )
    sc.rules << rule
  end
  puts "#{sc.inspect}\nERROR: #{sc.errors.inspect}" if !sc.save
end