module M
  def self.method_added(method)
    puts "New method: M##{method}"
  end

  def my_method; end
end