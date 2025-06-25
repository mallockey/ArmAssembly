# ARM Math Operations

If a number is unsigned, I dont care what the number is it cannot be negative because it does not have a signing bit

A signed Value has the potential to carry a negative value
The MSB indicates if the value is negative or positive (the one farthest to the left)

Unsigned
11111111 = 255
Signed
11111111

What we do here is something called the twos compliment we flip every bit and add 1

So 11111111 == 00000001 == -1

### Add

add[s] dst, src, num

add[s] dst, src #N

### Subtract

sub[s] dst, src, num

sub[s] dst, src, #n

### Multiply

mul[s] dst, src, num

mul[s] dst, src, #n

smull[s] dst_low, dst_high, src, num

Basically if you're result is greater than 32bits you'd want to use a long command like `smull` to split the result across two registers
