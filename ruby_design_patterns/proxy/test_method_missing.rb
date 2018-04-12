class TestMethodMissing
  def hello
    puts("Hello from a real method")
  end

  def method_missing(name, *args)
    puts("Warning, warning, unknown method called: #{name}")
    puts("Arguments: #{args.join(' ')}")
  end
end

tmm = TestMethodMissing.new
# tmm.hello

tmm.send(:hello)
tmm.send(:goodbye, 'crual', 'world')
# tmm.wazzup('man', true, 1, 1, 'one')