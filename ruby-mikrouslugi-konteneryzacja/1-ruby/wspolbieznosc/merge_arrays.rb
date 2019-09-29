def merge_arrays(a, b)
  # Zbiorcza tablica
  # przestrzeni O(n)
  result = []
  # Mniejsza wartość
  if a[0] < b[0]
    result << a.shift
  else
    result << b.shift
  end # if
  # Sprawdzenie rozmiaru
  if a.length == 0
    return result + b
  elsif b.length ==0
    return result + b
  else
    return result + merge_arrays(a, b)
  end # if
end # merge_arrays