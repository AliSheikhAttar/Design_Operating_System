#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"



#define N 4

void matrix_multiply(int A[N][N], int B[N][N], int C[N][N]) {
    int i, j, k;
    for(i = 0; i < N; i++) {
        for(j = 0; j < N; j++) {
            C[i][j] = 0;
            for(k = 0; k < N; k++) {
                C[i][j] += A[i][k] * B[k][j];
            }
        }
    }
}

void print_matrix(int matrix[N][N]) {
    int i, j;
    for(i = 0; i < N; i++) {
        for(j = 0; j < N; j++) {
           // printf( "%d ", matrix[i][j]);
        }
        //printf(2, "\n");
    }
}

int main(int argc, char *argv[]) {
    int A[N][N], B[N][N], C[N][N];
    int i, j;

    // Initialize matrices A and B with some values
    for(i = 0; i < N; i++) {
        for(j = 0; j < N; j++) {
            A[i][j] = i + j;
            B[i][j] = i - j;
        }
    }

    // Perform matrix multiplication
    matrix_multiply(A, B, C);

    // Print the result
    //print_matrix(C);

    exit();
}