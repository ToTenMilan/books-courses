pit '' do # assume I want to run pry in test, by calling 'pit' instead of 'it'
  # some test
end

# I need to add configure this:
RSpec.configure ​do​ |rspec|
  rspec.alias_example_group_to ​:pdescribe​, ​pry: ​​true​
  rspec.alias_example_to ​:pit​, ​pry: ​​true​
​ 	
  rspec.after(​:example​, ​pry: ​​true​) ​do​ |ex| # defining new tag
    require ​'pry'​
    binding.pry
  ​end​
​end​