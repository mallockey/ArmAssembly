#include <stdio.h>

int main()
{
    char *str = "123";
    int result = 0;
    while (*str != 0)
    {
        // 0   =  0   * 10 + (1) === 1
        // 1   =  1   * 10 + (2) === 12
        // 12  =  12  * 10 + (3) === 123
        result = result * 10 + (*str - '0');
        str++;
    }

    printf("Result %d\n", result);
}