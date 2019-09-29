operation = File.read('operations.txt')
$SAFE # => 0
eval(operation) # => "Dangerous operation."
$SAFE = 1
eval(operation) # => SecurityError: Insecure operation - eval