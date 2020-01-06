# definition
RSpec.shared_context ​'API helpers'​ ​do​
​ 	  ​include​ Rack::Test::Methods
​ 	
​ 	  ​def​ app
​ 	    ExpenseTracker::API.new
​ 	  ​end​
​ 	
​ 	  ​before​ ​do​
​ 	    basic_authorize ​'test_user'​, ​'test_password'​
​ 	  ​end​
​ 	​end​



# example usage
RSpec.describe ​'Expense Tracker API'​, ​:db​ ​do​
​ 	  include_context ​'API helpers'​
​ 	
​ 	  ​# ...​
​ 	​end​