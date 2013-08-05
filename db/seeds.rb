# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'SETTING UP ADMIN USER LOGIN'
admin = User.create! :name => 'Default Admin', :email => 'admin@bookcontrol.com', :password => 'secretpassword', :password_confirmation => 'secretpassword', :role => 'admin'
puts 'New admin created: ' << admin.name
user = User.create! :name => 'Default User', :email => 'user@bookcontrol.com', :password => 'secretpassword', :password_confirmation => 'secretpassword', :role => 'editor'
puts 'New user created: ' << user.name

puts 'SETTING UP DEFAULT BOOK'
book = Book.create! :isbn => '978-3446238978',
  :title => 'Das tollste ABC der Welt',
  :author => 'Tom Schamp',
  :publisher => 'Harry Rowohlt',
  :category => 'Lehrbuch',
  :img_url => 'http://ecx.images-amazon.com/images/I/41udljuMgYL._BO2,204,203,200_PIsitb-sticker-arrow-click,TopRight,35,-76_SX385_SY500_CR,0,0,385,500_SH20_OU03_.jpg',
  :amazon_link => 'http://www.amazon.de/Das-tollste-ABC-Welt-Schamp/dp/3446238972',
  :proposal => false

puts 'New book created: ' << book.title