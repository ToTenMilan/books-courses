class ArrayIterator
  def initialize(array)
    @array = array
    @index = 0
  end

  def has_next?
    @index < @array.length
  end

  def item
    @array[@index]
  end

  def next_item
    value = @array[@index]
    @index += 1
    value
  end
end

arr = ['red', 'blue', 'green']

i = ArrayIterator.new(arr)
while i.has_next?
  puts("item: #{i.next_item}")
end

s = ArrayIterator.new('hello')
while s.has_next?
  puts("item: #{s.next_item}")
end

# merging two arrays
def merge(a1, a2)
  merged = []

  iter1 = ArrayIterator.new(a1)
  iter2 = ArrayIterator.new(a2)

  while( iter1.has_next? and iter2.has_next? )
    if iter1.item < iter2.item
      merged << iter1.next_item
    else
      merged << iter2.next_item
    end
  end

  while( iter1.has_next? )
    merged << iter1.next_item
  end

  while( iter2.has_next? )
    merged << iter2.next_item
  end

  merged
end