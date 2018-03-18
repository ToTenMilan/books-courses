require_relative 'formatter'

# simplify the fow of data, but couple strategy and context more than before
class Report
	attr_reader :title, :text
	attr_accessor :formatter

	def initialize(formatter)
		@title = 'Monthly Report'
		@text = [ 'Things are going', 'really, really well.' ]
		@formatter = formatter
	end

	def output_report
		@formatter.output_report( self) # <--------
	end
end

report = Report.new(HTMLFormatter.new)
report.output_report

report.formatter = PlainTextFormatter.new
report.output_report

######## 1 #############
# class Report
# 	attr_reader :title, :text
# 	attr_accessor :formatter

# 	def initialize(formatter)
# 		@title = 'Monthly Report'
# 		@text = [ 'Things are going', 'really, really well.' ]
# 		@formatter = formatter
# 	end

# 	def output_report
# 		@formatter.output_report( @title, @text )
# 	end
# end

# report = Report.new(HTMLFormatter.new)
# report.output_report

# report.formatter = PlainTextFormatter.new
# report.output_report