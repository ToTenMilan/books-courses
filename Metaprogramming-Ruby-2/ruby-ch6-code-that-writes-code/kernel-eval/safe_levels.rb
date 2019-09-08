# 0 (“hippie commune,” where you can hug trees and format hard disks)
# 2 disallows most file-related operations.
# 3 (“military dictatorship,” where every object you create is tainted by default).

# Any safe level greater than 0 also causes Ruby to flat-out refuse to evaluate tainted strings:

$SAFE = 1
user_input = "User_input: #{gets()}"
eval user_input

# ​=> ​x = 1​
# ​<= SecurityError: Insecure operation - eval