#include "types.h"
#include "stat.h"
#include "user.h"

#define N 64

void matrix_multiply(int A[N][N], int B[N][N], int C[N][N]) {
    int i, j, k;
    for (i = 0; i < N; i++) {
        for (j = 0; j < N; j++) {
            C[i][j] = 0;
            for (k = 0; k < N; k++) {
                C[i][j] += A[i][k] * B[k][j];
            }
        }
    }
}

void print_matrix(int matrix[N][N]) {
    int i, j;
    for (i = 0; i < N; i++) {
        for (j = 0; j < N; j++) {
            printf(1, "%d ", matrix[i][j]);
        }
        printf(1, "\n");
    }
}

int main(int argc, char *argv[]) {
    int A[N][N], B[N][N], C[N][N];
    int i, j;
    printf(1, "1\n");

    // Initialize matrices A and B with some values
    for (i = 0; i < N; i++) {
        for (j = 0; j < N; j++) {
            A[i][j] = i + j;
            B[i][j] = i - j;
        }
    }
    printf(1, "2\n");
    // Perform matrix multiplication
    matrix_multiply(A, B, C);
    printf(1, "2\n");

    // Print the result
    print_matrix(C);
    printf(1, "3\n");

    exit();
}
