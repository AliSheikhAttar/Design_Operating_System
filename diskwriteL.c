#include "types.h"
#include "user.h"
#include "fcntl.h"

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

int main(int argc, char *argv[]) {
        int start_time, end_time;
         start_time = uptime();
    if (argc < 2) {
        // Print usage message to stderr (fd 2)
        printf(2, "Usage: create_files <text> [start_index]\n");
        exit();
    }

    char *text = argv[1];
    int start_index = 1;

    if (argc == 3) {
        start_index = atoi(argv[2]);
    }

    for (int i = start_index; i <= 100; i++) {
        char filename[20]; // Sufficient buffer size for "fileX.txt" where X is up to 100
        create_filename("file", i, filename);

        // Write to the file directly
        write_to_file(filename, text);
    }
    end_time = uptime();
    printf(1, "Time taken: %d ticks\n", end_time - start_time);
    exit();
}
