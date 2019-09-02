class Amazon; end

def deserves_a_look?(book)
  amazon = Amazon.new
  p amazon.reviews_of(book).size > 20
end 

module AmazonWrapper
  def reviews_of(book)
    start = Time.now
    result = super
    time_taken = Time.now - start
    puts "reviews took more than #{time_taken} seconds" if time_taken > 2
    result
  rescue
    puts 'reviews_of() failed'
    []
  end
end

Amazon.class_eval do
  prepend AmazonWrapper
end