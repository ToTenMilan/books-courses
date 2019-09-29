$insertion_index=0
def insertion_sort(an_array)
  size = an_array.length
  i = 0
  while i < size
    current = an_array[i]
    j = i
    while j > 0 && an_array[j - 1] > current
      an_array[j] = an_array[j - 1]
      j -= 1 
      $insertion_index = $insertion_index + 1
      if $insertion_index % 1_000_000 == 0 then puts $insertion_index.to_s end
    end # while j > 0 && an_array[j - 1] > current
    an_array[j] = current
    i += 1
  end # while i < size
  return an_array
end # insertion_sort