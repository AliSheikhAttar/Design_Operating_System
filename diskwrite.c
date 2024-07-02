#include "types.h"
#include "user.h"
#include "fcntl.h"

void write_to_file(char *filename, char *text) {
    int fd;
    int n;

    //printf(1, "Attempting to open the file %s\n", filename); // Debugging print

    // Open the file for writing (O_WRONLY) and create if it doesn't exist (O_CREATE)
    fd = open(filename, O_WRONLY | O_CREATE);
    if (fd < 0) {
        // Print error message to stderr (fd 2)
        printf(2, "Error: cannot open %s\n", filename);
        exit();
    }

    //printf(1, "Successfully opened the file %s\n", filename); // Debugging print

    // Write the text to the file
    n = strlen(text);
    //printf(1,"test provided is %s\n",text);

    if (write(fd, text, n) != n) {
        // Print error message to stderr (fd 2)
        printf(2, "Error: write error\n");
        close(fd);
        exit();
    }

    printf(1, "Successfully wrote to the file %s\n", filename); // Debugging print

    close(fd);
    //printf(1, "Successfully closed the file %s\n", filename); // Debugging print
}

int main(int argc, char *argv[]) {
    if (argc < 3) {
        // Print usage message to stderr (fd 2)
        printf(2, "Usage: diskwrite <filename> <text>\n");
        exit();
    }

    //printf(1, "Calling write_to_file with %s and %s\n", argv[1], argv[2]); // Debugging print
    write_to_file(argv[1], argv[2]);
    exit();
}
