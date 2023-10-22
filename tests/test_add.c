#include <rustrpm.h>
#include <stdio.h>

int test_add() {
    int32_t result = add(10, 20);
    if (result == 30) {
        printf("test_add passed\n");
        return 0;
    } else {
        printf("test_add failed\n");
        return 1;
    }
}

int main() {
    int res_code = test_add();
    return res_code;
}