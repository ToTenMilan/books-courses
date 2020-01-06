

RSpec.describe BerlinTransitTicket ​do​
​ 	  ​let​(​:ticket​) { BerlinTransitTicket.new } 
​ 	
​ 	  ​before​ ​do​ 
​	    ​# These values depend on `let` definitions​
​ 	    ​# defined in the nested contexts below!​
​ 	    ​#​
​ 	    ticket.starting_station = starting_station 
​ 	    ticket.ending_station   = ending_station   
​ 	  ​end​
​ 	
​ 	  ​let​(​:fare​) { ticket.fare } 
​ 	
​ 	  ​context​ ​'when starting in zone A'​ ​do​
​ 	    ​let​(​:starting_station​) { ​'Bundestag'​ }    
​ 	
​ 	    ​context​ ​'and ending in zone B'​ ​do​
​ 	      ​let​(​:ending_station​) { ​'Leopoldplatz'​ } 
​ 	
​ 	      ​it​ ​'costs €2.70'​ ​do​ 
	        ​expect​(fare).to eq 2.7
​ 	      ​end​
​ 	    ​end​
​ 	
​ 	    ​context​ ​'and ending in zone C'​ ​do​
​ 	      ​let​(​:ending_station​) { ​'Birkenwerder'​ }
​ 	
​ 	      ​it​ ​'costs €3.30'​ ​do​
        ​expect​(fare).to eq 3.3
​ 	      ​end​
​ 	    ​end​
​ 	  ​end​
​ 	​end​

######### Whats wrong
# The before hook on line 4 begins to run.
# We refer to ticket on line 8, which jumps us to the let definition on line 2 to create that object.
# We reference starting_station on line 8, which jumps to the let definition on line 15 and back.
# On line 9, we reference ending_station, which jumps to the inner let definition on line 18 and back.
# The before hook completes, so now we start running the example on line 20.
# The example references fare, which jumps to the let definition on line 12 and back.
# The expectation runs, and the example completes.

# Above is called mystery guest https://thoughtbot.com/blog/mystery-guest


# Improving it by helper method:

RSpec.describe BerlinTransitTicket ​do​
  def fare_for(starting_station, ending_station)
    ticket = BerlinTransitTicket.new
    ticket.starting_station = starting_station
    ticket.ending_station   = ending_station
    ticket.fare
  ​end​
​ 	
  ​context​ ​'when starting in zone A and ending in zone B'​ ​do​
    ​it​ ​'costs €2.70'​ ​do​
      ​expect​(fare_for(​'Bundestag'​, ​'Leopoldplatz'​)).to eq 2.7
    ​end​
  ​end​
​ 	
  ​context​ ​'when starting in zone A and ending in zone C'​ ​do​
    ​it​ ​'costs €3.30'​ ​do​
      ​expect​(fare_for(​'Bundestag'​, ​'Birkenwerder'​)).to eq 3.3
    ​end​
  ​end​
​end​
