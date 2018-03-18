# simplify the fow of data, but couple strategy and context more than before
class Formatter
	def output_report( title, text )
		raise 'Abstract method called'
	end
end

class HTMLFormatter < Formatter
	def output_report( context ) # <-------
		puts('<html>')
		puts(' <head>')
		puts("  <title>#{context.title}</title>") # <-------
		puts(' </head>')
		puts(' <body>')
		context.text.each do |line| # <-------
			puts("    <p>#{line}</p>" )
		end
		puts(' </body>')
		puts('</html>')
	end
end

class PlainTextFormatter < Formatter
	def output_report(title, text)
		puts("***** #{title} *****")
		text.each do |line|
			puts(line)
		end
	end
end

######## 1 #############
# class Formatter
# 	def output_report( title, text )
# 		raise 'Abstract method called'
# 	end
# end

# class HTMLFormatter < Formatter
# 	def output_report( title, text )
# 		puts('<html>')
# 		puts(' <head>')
# 		puts("  <title>#{title}</title>")
# 		puts(' </head>')
# 		puts(' <body>')
# 		text.each do |line|
# 			puts("    <p>#{line}</p>" )
# 		end
# 		puts(' </body>')
# 		puts('</html>')
# 	end
# end

# class PlainTextFormatter < Formatter
# 	def output_report(title, text)
# 		puts("***** #{title} *****")
# 		text.each do |line|
# 			puts(line)
# 		end
# 	end
# end