require 'rubygems'
require 'mailfactory'

### Builder example
mail_builder = MailFactory.new
mail_builder.to ='barrack@obama.com'
mail_builder.from = 'donald@trump.com'
mail_builder.subject = 'ustawka'
mail_builder.text = 'cho na piaski'
# mail_builder.attach('book.doc')

puts mail_builder.to_s