require 'find'

class Expression
  def |(other)
    Or.new(self, other)
  end

  def &(other)
    And.new(self, other)
  end

  def all
    All.new
  end

  def bigger(size)
    Bigger.new
  end

  def name(pattern)
    FileName.new(pattern)
  end

  def except(expression)
    Not.new(expression)
  end

  def writeable
    Writeable.new
  end
end

class All < Expression # Terminal (leaf node)
  def evaluate(dir)
    results = []
    Find.find(dir) do |f|
      next unless File.file?(f)
      results << f
    end
    results
  end
end

class FileName < Expression # Terminal (leaf node)
  def initialize(pattern)
    @pattern = pattern
  end

  def evaluate(dir)
    results = []
    Find.find(dir) do |f|
      next unless File.file?(f)
      name = File.basename(f)
      results << f if File.fnmatch(@pattern, name)
    end
    results
  end
end

# expr_all = All.new
# files = expr_all.evaluate('testdir')
# # p files

# expr_mp3 = FileName.new('*.mp3')
# mp3s = expr_mp3.evaluate('testdir')
# # p mp3s

class Bigger < Expression # Terminal (leaf node)
  def initialize(size)
    @size = size
  end

  def evaluate(dir)
    results = []
    Find.find(dir) do |f|
      next unless File.file?(f)
      results << f if File.size(f) > @size
    end
    results
  end
end

class Writeable < Expression # Terminal (leaf node)
  def evaluate(dir)
    results = []
    Find.find(dir) do |f|
      next unless File.file?(f)
        results << f if( File.writable?(f) )
      end
    results
  end
end

class Not < Expression # Nonterminal
  def initialize(expression)
    @expression = expression
  end

  def evaluate(dir)
    All.new.evaluate(dir) - @expression.evaluate(dir)
  end
end

class Or < Expression
  def initialize(expression1, expression2)
    @expression1, @expression2 = expression1, expression2
  end

  def evaluate(dir)
    result1 = @expression1.evaluate(dir)
    result2 = @expression2.evaluate(dir)
    (result1 + result2).sort.uniq
  end
end

class And < Expression
  def initialize(expression1, expression2)
    @expression1, @expression2 = expression1, expression2
  end

  def evaluate(dir)
    result1 = @expression1.evaluate(dir)
    result2 = @expression2.evaluate(dir)
    (result1 & result2)
  end
end

# expr_not_writeable = Not.new( Writeable.new )
# readonly_files = expr_not_writeable.evaluate('testdir')
# # p readonly_files

# small_expr = Not.new( Bigger.new(1024) )
# small_files = small_expr.evaluate('testdir')
# # p small_files

# not_mp3_expr = Not.new( FileName.new('*.mp3') )
# not_mp3s = not_mp3_expr.evaluate('testdir')
# # p not_mp3s

# big_or_mp3_expr = Or.new( Bigger.new(1024), FileName.new('*.mp3') )
# big_or_mp3s = big_or_mp3_expr.evaluate('testdir')
# # p big_or_mp3s

# cmplx_expr = And.new(
#                 And.new( Bigger.new(1024), FileName.new('*.mp3') ),
#                 Not.new( Writeable.new )
#              )
# complex_search = cmplx_expr.evaluate('testdir')
# # p complex_search

# synt_sugar = (Bigger.new(2000) & Not.new(Writeable.new)) | FileName.new("*.mp3")
# p synt_sugar.evaluate('testdir')
