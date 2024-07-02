#include "types.h"
#include "user.h"
#include "fcntl.h"

#define N 16

// Utility function to convert an integer to a string
void int_to_str(int n, char *str) {
    int len = 0;
    int temp_n = n;

    // Handle the case where n is 0
    if (n == 0) {
        str[0] = '0';
        str[1] = '\0';
        return;
    }

    // Count digits
    while (temp_n > 0) {
        len++;
        temp_n /= 10;
    }

    // Null-terminate the string
    str[len] = '\0';

    // Fill string with digits in reverse order
    while (n > 0) {
        str[--len] = (n % 10) + '0';
        n /= 10;
    }
}

// Utility function to create filenames like "file1.txt", "file2.txt", ..., "file100.txt"
void create_filename(char *base, int num, char *filename) {
    char num_str[10]; // Buffer to hold the number as string
    int i = 0;
    int j = 0;

    // Copy base to filename
    while (base[i] != '\0') {
        filename[i] = base[i];
        i++;
    }

    // Convert number to string
    int_to_str(num, num_str);

    // Append the number string to filename
    while (num_str[j] != '\0') {
        filename[i++] = num_str[j++];
    }

    // Append ".txt" to filename
    filename[i++] = '.';
    filename[i++] = 't';
    filename[i++] = 'x';
    filename[i++] = 't';
    filename[i] = '\0'; // Null-terminate the string
}

// Function to write text to a file
void write_to_file(char *filename, char *text) {
    int fd;
    int n = strlen(text);

    // Open the file for writing (O_WRONLY) and create if it doesn't exist (O_CREATE)
    fd = open(filename, O_WRONLY | O_CREATE);
    if (fd < 0) {
        // Print error message to stderr (fd 2)
        printf(2, "Error: cannot open %s\n", filename);
        return;
    }

    // Write the text to the file
    if (write(fd, text, n) != n) {
        // Print error message to stderr (fd 2)
        printf(2, "Error: write error for %s\n", filename);
        close(fd);
        return;
    }

    // Close the file
    close(fd);
    printf(1, "Successfully wrote to %s\n", filename); // Debugging print
}

// Matrix multiplication function
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

// Print matrix function
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
    if (argc < 2) {
        // Print usage message to stderr (fd 2)
        printf(2, "Usage: mdfork <text> [start_index]\n");
        exit();
    }

    char *text = argv[1];
    int start_index = 1;

    if (argc == 3) {
        start_index = atoi(argv[2]);
    }

    int pid1, pid2;

    // Create first child process for matrix multiplication
    if ((pid1 = fork()) == 0) {
        // Child process 1: Matrix multiplication
        int A[N][N], B[N][N], C[N][N];
        int i, j;

        // Initialize matrices A and B with some values
        for (i = 0; i < N; i++) {
            for (j = 0; j < N; j++) {
                A[i][j] = i + j;
                B[i][j] = i - j;
            }
        }

        // Perform matrix multiplication
        matrix_multiply(A, B, C);

        // Print the result
        printf(1, "Matrix C:\n");
        print_matrix(C);

        exit();
    } else if (pid1 < 0) {
        // Fork failed
        printf(2, "Error: fork failed\n");
        exit();
    }

    // Create second child process for writing to files
    if ((pid2 = fork()) == 0) {
        // Child process 2: Write text to files
        for (int i = start_index; i <= 100; i++) {
            char filename[20]; // Sufficient buffer size for "fileX.txt" where X is up to 100
            create_filename("file", i, filename);

            // Write to the file directly
            write_to_file(filename, text);
        }

        exit();
    } else if (pid2 < 0) {
        // Fork failed
        printf(2, "Error: fork failed\n");
        exit();
    }

    // Parent process: Wait for both children to finish
    wait();
    wait();

    printf(1, "Both child processes completed\n");
    exit();
}
