module Kernel
  def my_using(resource)
    begin
      yield # evaluate the block
    ensure
      resource.dispose # always execute (also in exception)
    end
  end
end