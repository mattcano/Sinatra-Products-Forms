# gem install --version 1.3.0 sinatra
require 'pry'
gem 'sinatra', '1.3.0'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'
 
before do
  @db = SQLite3::Database.new "store.sqlite3"
  # db.results_as_hash = true
end 

get '/' do
  erb :home
end

get "/new_product" do
  erb :new_product
end

post "/new_product" do
  name = params[:product_name]
  price = params[:product_price]
  sale = params[:sale]
  sql = "INSERT INTO products('name', 'price', 'on_sale') VALUES ('#{name}', '#{price}', '#{sale}')"
  @rs = @db.execute(sql)  
  # db2 = SQLite3::Database.new "store.sqlite3"
  # db.results_as_hash = true
  @rs2 = @db.execute("SELECT * FROM products;")
  #make the product in to a db
  erb :product_created
end

get '/users' do
  @rs = @db.execute('SELECT * FROM users;')
  erb :show_users
end
 
get '/products' do
  @rs = @db.execute("SELECT * FROM products;")
  erb :show_products
end 

get "/products/:id" do
  id = params[:id]
  @row = @db.get_first_row("SELECT * FROM products WHERE id = #{id};")
  erb :update_products
end

post "/update_products" do
  id = params[:id]
  name = params[:product_name]
  price = params[:product_price]
  sale = params[:sale]
  sql = "UPDATE products SET name = '#{name}', price = #{price}, on_sale = '#{sale}' WHERE id = #{id}"
  @rs = @db.execute(sql)
  # db2 = SQLite3::Database.new "store.sqlite3"
  # db.results_as_hash = true
  @rs2 = @db.execute("SELECT * FROM products;")
  #make the product in to a db
  erb :product_updated
end

get "/products/:id/destroy" do
  id = params[:id]
  @id = id
  erb :product_deleted
end

post "/products/:id/destroy" do
  id = params[:id]
  @id = id
  sql = "DELETE FROM products WHERE id = #{id}"
  @rs = @db.execute(sql)
end

=begin
 
  <form method='post' action='/create'>
    <input type='text' name='name' autofocus>
    <input type='text' name='photo'>
    <input type='text' name='breed'>
    <button>dog me!</button>
  </form>
 
 
  post '/create' do
  end
 
 
  redirect '/'
 
=end