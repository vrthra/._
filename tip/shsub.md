### Shell Pattern Substitution

    ${parameter:-defaultValue}   Get default shell variables value
    ${parameter:=defaultValue}   Set default shell variables value
    ${parameter:?"Error Message"}  Display an error message if parameter is not set
    ${#var}  Find the length of the string
    ${var%pattern}   Remove from shortest rear (end) pattern
    ${var%%pattern}  Remove from longest rear (end) pattern
    ${var:num1:num2}  Substring
    ${var#pattern}   Remove from shortest front pattern
    ${var##pattern}  Remove from longest front pattern
    ${var/pattern/string}  Find and replace (only replace first occurrence)
    ${var//pattern/string}   Find and replace all occurrences


