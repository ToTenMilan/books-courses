ObjectSpace.each_object.inject(Hash.new 0) { |h,o| 
	h[o.class] += 1; h 
}.sort_by { |k,v| -v }.take(1000).each { |klass, count| 
	puts "#{count.to_s.ljust(7)} #{klass}" 
}
