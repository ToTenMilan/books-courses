class Report
	def initialize
		@title = 'Monthly Report'
		@text = ['Things are going', 'really, really well.']
	end

	def output_report
		output_start
		output_line(@title)
		output_body_start
		@text.each do |line|
			output_line(line)
		end
		output_body_end
		output_end
	end

	def output_start
	end

	def output_body_start
	end
	def output_line(line)
		raise 'Called abstract method: output_line'
	end
	def output_body_end
	end
	def output_end
	end
end

class HTMLReport < Report
	def output_start
		puts('<html>')
	end
	def output_head
		puts(' <head>')
		puts("	<title>#{@title}</title>")
		puts(' </head>')
	end
	def output_body_start
		puts('<body>')
	end
	def output_line(line)
		puts(" <p>#{line}</p>")
	end
	def output_body_end
		puts('</body>')
	end
	def output_end
		puts('</html>')
	end
end

class PlainTextReport < Report
	def output_start
	end
	def output_head
		puts("**** #{@title} ****")
		puts
	end
	def output_body_start
	end
	def output_line(line)
		puts(line)
	end
	def output_body_end
	end
	def output_end
	end
end


report = HTMLReport.new
report.output_report

report = PlainTextReport.new
report.output_report

#### 2 #################################
# class Report
# 	def initialize
# 		@title = 'Monthly Report'
# 		@text = [ 'Things are going', 'really, really well.' ]
# 	end
# 	def output_report(format)
# 		if format == :plain
# 			puts("*** #{@title} ***")
# 		elsif format == :html
# 			puts('<html>')
# 			puts(' <head>')
# 			puts("	<title>#{@title}</title>")
# 			puts(' </head>')
# 			puts(' <body>')
# 			@text.each do |line|
# 				puts("	<p>#{line}</p>" )
# 			end
# 			puts(' </body>')
# 		else
# 			raise "Unknown format: #{format}"
# 		end

# 		@text.each do |line|
# 			if format == :plain
# 				puts(line)
# 			else
# 				puts("    <p>#{line}</p>")
# 			end
# 		end

# 		if format == :html
# 			puts(' </body>')
# 			puts('</html>')
# 		end
# 	end
# end


# rep = Report.new
# rep.output_report(:plain)


### 1 ####################
# class Report
# 	def initialize
# 		@title = 'Monthly Report'
# 		@text = [ 'Things are going', 'really, really well.' ]
# 	end
# 	def output_report
# 		puts('<html>')
# 		puts(' <head>')
# 		puts("	<title>#{@title}</title>")
# 		puts(' </head>')
# 		puts(' <body>')
# 		@text.each do |line|
# 			puts("	<p>#{line}</p>" )
# 		end
# 		puts(' </body>')
# 		puts('</html>')
# 	end
# end

# rep = Report.new
# rep.output_report