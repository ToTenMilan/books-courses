class Fibonacci
  def self.of(n)
    # recursive fibo
    return 0 if n == 0
    return 1 if n <= 2

    return of(n - 1) + of(n - 2)

    # Exercise: loop fibo
    # current_fibo = 0
    # previous_fibo = 0
    # fibo_sequence = []

    # (0..n).to_a.each do |x|
    #   if x == 1 || x == 2
    #     current_fibo = 1
    #     previous_fibo = 0
    #   elsif x > 2
    #     previous_fibo = current_fibo
    #     current_fibo = fibo_sequence[-1] + fibo_sequence[-2]
    #   end
    #   fibo_sequence << current_fibo
    # end

    # fibo_sequence.last
  end
end
