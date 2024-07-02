
_mdfork:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
        }
        printf(1, "\n");
    }
}

int main(int argc, char *argv[]) {
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	81 ec a8 0d 00 00    	sub    $0xda8,%esp
  17:	8b 31                	mov    (%ecx),%esi
  19:	8b 59 04             	mov    0x4(%ecx),%ebx
     int start_time, end_time;
    start_time = uptime();
  1c:	e8 ea 07 00 00       	call   80b <uptime>
  21:	89 85 54 f2 ff ff    	mov    %eax,-0xdac(%ebp)
    if (argc < 2) {
  27:	83 fe 01             	cmp    $0x1,%esi
  2a:	0f 8e e1 00 00 00    	jle    111 <main+0x111>
        // Print usage message to stderr (fd 2)
        printf(2, "Usage: mdfork <text> [start_index]\n");
        exit();
    }

    char *text = argv[1];
  30:	8b 7b 04             	mov    0x4(%ebx),%edi
    int start_index = 1;

    if (argc == 3) {
  33:	83 fe 03             	cmp    $0x3,%esi
  36:	0f 84 35 01 00 00    	je     171 <main+0x171>
    }

    int pid1, pid2;

    // Create first child process for matrix multiplication
    if ((pid1 = fork()) == 0) {
  3c:	e8 2a 07 00 00       	call   76b <fork>
  41:	85 c0                	test   %eax,%eax
  43:	75 36                	jne    7b <main+0x7b>
    int start_index = 1;
  45:	bb 01 00 00 00       	mov    $0x1,%ebx
  4a:	8d b5 64 fb ff ff    	lea    -0x49c(%ebp),%esi
        // Child process 1: Matrix multiplication
        for (int i = start_index; i <= 200; i++) {
            char filename[20]; // Sufficient buffer size for "fileX.txt" where X is up to 100
            create_filename("file", i, filename);
  50:	83 ec 04             	sub    $0x4,%esp
  53:	56                   	push   %esi
  54:	53                   	push   %ebx
        for (int i = start_index; i <= 200; i++) {
  55:	83 c3 01             	add    $0x1,%ebx
            create_filename("file", i, filename);
  58:	68 58 0c 00 00       	push   $0xc58
  5d:	e8 ce 01 00 00       	call   230 <create_filename>

            // Write to the file directly
            write_to_file(filename, text);
  62:	58                   	pop    %eax
  63:	5a                   	pop    %edx
  64:	57                   	push   %edi
  65:	56                   	push   %esi
  66:	e8 05 03 00 00       	call   370 <write_to_file>
        for (int i = start_index; i <= 200; i++) {
  6b:	83 c4 10             	add    $0x10,%esp
  6e:	81 fb c9 00 00 00    	cmp    $0xc9,%ebx
  74:	75 da                	jne    50 <main+0x50>
        }

        exit();
  76:	e8 f8 06 00 00       	call   773 <exit>
    } else if (pid1 < 0) {
  7b:	85 c0                	test   %eax,%eax
  7d:	0f 88 db 00 00 00    	js     15e <main+0x15e>
        printf(2, "Error: fork failed\n");
        exit();
    }

    // Create second child process for writing to files
    if ((pid2 = fork()) == 0) {
  83:	e8 e3 06 00 00       	call   76b <fork>
  88:	85 c0                	test   %eax,%eax
  8a:	0f 85 94 00 00 00    	jne    124 <main+0x124>

        int A[N][N], B[N][N], C[N][N];
        int i, j;

        // Initialize matrices A and B with some values
        for (i = 0; i < N; i++) {
  90:	31 c9                	xor    %ecx,%ecx
  92:	8d b5 5c f2 ff ff    	lea    -0xda4(%ebp),%esi
  98:	c7 85 54 f2 ff ff 00 	movl   $0x0,-0xdac(%ebp)
  9f:	00 00 00 
  a2:	8d bd e0 f6 ff ff    	lea    -0x920(%ebp),%edi
  a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  af:	90                   	nop
    int start_index = 1;
  b0:	8b 95 54 f2 ff ff    	mov    -0xdac(%ebp),%edx
            for (j = 0; j < N; j++) {
  b6:	31 c0                	xor    %eax,%eax
  b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  bf:	90                   	nop
                A[i][j] = i + j;
  c0:	8d 1c 08             	lea    (%eax,%ecx,1),%ebx
  c3:	89 1c 16             	mov    %ebx,(%esi,%edx,1)
                B[i][j] = i - j;
  c6:	89 cb                	mov    %ecx,%ebx
  c8:	29 c3                	sub    %eax,%ebx
            for (j = 0; j < N; j++) {
  ca:	83 c0 01             	add    $0x1,%eax
                B[i][j] = i - j;
  cd:	89 1c 17             	mov    %ebx,(%edi,%edx,1)
            for (j = 0; j < N; j++) {
  d0:	83 c2 04             	add    $0x4,%edx
  d3:	83 f8 11             	cmp    $0x11,%eax
  d6:	75 e8                	jne    c0 <main+0xc0>
        for (i = 0; i < N; i++) {
  d8:	83 c1 01             	add    $0x1,%ecx
  db:	83 85 54 f2 ff ff 44 	addl   $0x44,-0xdac(%ebp)
  e2:	83 f9 11             	cmp    $0x11,%ecx
  e5:	75 c9                	jne    b0 <main+0xb0>
            }
        }

        // Perform matrix multiplication
        matrix_multiply(A, B, C);
  e7:	8d 9d 64 fb ff ff    	lea    -0x49c(%ebp),%ebx
  ed:	52                   	push   %edx
  ee:	53                   	push   %ebx
  ef:	57                   	push   %edi
  f0:	56                   	push   %esi
  f1:	e8 3a 03 00 00       	call   430 <matrix_multiply>

        // Print the result
        printf(1, "Matrix C:\n");
  f6:	59                   	pop    %ecx
  f7:	5e                   	pop    %esi
  f8:	68 71 0c 00 00       	push   $0xc71
  fd:	6a 01                	push   $0x1
  ff:	e8 dc 07 00 00       	call   8e0 <printf>
        print_matrix(C);
 104:	89 1c 24             	mov    %ebx,(%esp)
 107:	e8 b4 03 00 00       	call   4c0 <print_matrix>

        exit();
 10c:	e8 62 06 00 00       	call   773 <exit>
        printf(2, "Usage: mdfork <text> [start_index]\n");
 111:	51                   	push   %ecx
 112:	51                   	push   %ecx
 113:	68 94 0c 00 00       	push   $0xc94
 118:	6a 02                	push   $0x2
 11a:	e8 c1 07 00 00       	call   8e0 <printf>
        exit();
 11f:	e8 4f 06 00 00       	call   773 <exit>


    } else if (pid2 < 0) {
 124:	78 38                	js     15e <main+0x15e>
        printf(2, "Error: fork failed\n");
        exit();
    }

    // Parent process: Wait for both children to finish
    wait();
 126:	e8 50 06 00 00       	call   77b <wait>
    wait();
 12b:	e8 4b 06 00 00       	call   77b <wait>

    printf(1, "Both child processes completed\n");
 130:	50                   	push   %eax
 131:	50                   	push   %eax
 132:	68 b8 0c 00 00       	push   $0xcb8
 137:	6a 01                	push   $0x1
 139:	e8 a2 07 00 00       	call   8e0 <printf>
    end_time = uptime();
 13e:	e8 c8 06 00 00       	call   80b <uptime>
    printf(1, "Time taken: %d ticks\n", end_time - start_time);
 143:	83 c4 0c             	add    $0xc,%esp
 146:	2b 85 54 f2 ff ff    	sub    -0xdac(%ebp),%eax
 14c:	50                   	push   %eax
 14d:	68 7c 0c 00 00       	push   $0xc7c
 152:	6a 01                	push   $0x1
 154:	e8 87 07 00 00       	call   8e0 <printf>
    exit();
 159:	e8 15 06 00 00       	call   773 <exit>
        printf(2, "Error: fork failed\n");
 15e:	57                   	push   %edi
 15f:	57                   	push   %edi
 160:	68 5d 0c 00 00       	push   $0xc5d
 165:	6a 02                	push   $0x2
 167:	e8 74 07 00 00       	call   8e0 <printf>
        exit();
 16c:	e8 02 06 00 00       	call   773 <exit>
        start_index = atoi(argv[2]);
 171:	83 ec 0c             	sub    $0xc,%esp
 174:	ff 73 08             	push   0x8(%ebx)
 177:	e8 84 05 00 00       	call   700 <atoi>
 17c:	89 c3                	mov    %eax,%ebx
    if ((pid1 = fork()) == 0) {
 17e:	e8 e8 05 00 00       	call   76b <fork>
 183:	83 c4 10             	add    $0x10,%esp
 186:	85 c0                	test   %eax,%eax
 188:	0f 85 ed fe ff ff    	jne    7b <main+0x7b>
        for (int i = start_index; i <= 200; i++) {
 18e:	81 fb c8 00 00 00    	cmp    $0xc8,%ebx
 194:	0f 8e b0 fe ff ff    	jle    4a <main+0x4a>
 19a:	e9 d7 fe ff ff       	jmp    76 <main+0x76>
 19f:	90                   	nop

000001a0 <int_to_str>:
void int_to_str(int n, char *str) {
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	57                   	push   %edi
 1a4:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1a7:	56                   	push   %esi
 1a8:	53                   	push   %ebx
    if (n == 0) {
 1a9:	85 c9                	test   %ecx,%ecx
 1ab:	74 63                	je     210 <int_to_str+0x70>
    while (temp_n > 0) {
 1ad:	89 ca                	mov    %ecx,%edx
    int len = 0;
 1af:	be 00 00 00 00       	mov    $0x0,%esi
    while (temp_n > 0) {
 1b4:	7e 6a                	jle    220 <int_to_str+0x80>
 1b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1bd:	8d 76 00             	lea    0x0(%esi),%esi
        temp_n /= 10;
 1c0:	b8 cd cc cc cc       	mov    $0xcccccccd,%eax
 1c5:	89 d7                	mov    %edx,%edi
 1c7:	89 f3                	mov    %esi,%ebx
        len++;
 1c9:	83 c6 01             	add    $0x1,%esi
        temp_n /= 10;
 1cc:	f7 e2                	mul    %edx
 1ce:	c1 ea 03             	shr    $0x3,%edx
    while (temp_n > 0) {
 1d1:	83 ff 09             	cmp    $0x9,%edi
 1d4:	7f ea                	jg     1c0 <int_to_str+0x20>
    str[len] = '\0';
 1d6:	8b 45 0c             	mov    0xc(%ebp),%eax
 1d9:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
    while (n > 0) {
 1dd:	01 c3                	add    %eax,%ebx
        str[--len] = (n % 10) + '0';
 1df:	be cd cc cc cc       	mov    $0xcccccccd,%esi
 1e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1e8:	89 c8                	mov    %ecx,%eax
    while (n > 0) {
 1ea:	83 eb 01             	sub    $0x1,%ebx
        str[--len] = (n % 10) + '0';
 1ed:	f7 e6                	mul    %esi
 1ef:	89 c8                	mov    %ecx,%eax
 1f1:	c1 ea 03             	shr    $0x3,%edx
 1f4:	8d 3c 92             	lea    (%edx,%edx,4),%edi
 1f7:	01 ff                	add    %edi,%edi
 1f9:	29 f8                	sub    %edi,%eax
 1fb:	83 c0 30             	add    $0x30,%eax
 1fe:	88 43 01             	mov    %al,0x1(%ebx)
        n /= 10;
 201:	89 c8                	mov    %ecx,%eax
 203:	89 d1                	mov    %edx,%ecx
    while (n > 0) {
 205:	83 f8 09             	cmp    $0x9,%eax
 208:	7f de                	jg     1e8 <int_to_str+0x48>
}
 20a:	5b                   	pop    %ebx
 20b:	5e                   	pop    %esi
 20c:	5f                   	pop    %edi
 20d:	5d                   	pop    %ebp
 20e:	c3                   	ret    
 20f:	90                   	nop
        str[0] = '0';
 210:	8b 45 0c             	mov    0xc(%ebp),%eax
 213:	ba 30 00 00 00       	mov    $0x30,%edx
 218:	66 89 10             	mov    %dx,(%eax)
}
 21b:	5b                   	pop    %ebx
 21c:	5e                   	pop    %esi
 21d:	5f                   	pop    %edi
 21e:	5d                   	pop    %ebp
 21f:	c3                   	ret    
    str[len] = '\0';
 220:	8b 45 0c             	mov    0xc(%ebp),%eax
 223:	c6 00 00             	movb   $0x0,(%eax)
    while (n > 0) {
 226:	eb e2                	jmp    20a <int_to_str+0x6a>
 228:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 22f:	90                   	nop

00000230 <create_filename>:
void create_filename(char *base, int num, char *filename) {
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	57                   	push   %edi
 234:	56                   	push   %esi
 235:	53                   	push   %ebx
 236:	83 ec 1c             	sub    $0x1c,%esp
 239:	8b 75 08             	mov    0x8(%ebp),%esi
 23c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    while (base[i] != '\0') {
 23f:	0f b6 06             	movzbl (%esi),%eax
 242:	84 c0                	test   %al,%al
 244:	0f 84 06 01 00 00    	je     350 <create_filename+0x120>
    int i = 0;
 24a:	8b 7d 10             	mov    0x10(%ebp),%edi
 24d:	31 c9                	xor    %ecx,%ecx
 24f:	90                   	nop
        filename[i] = base[i];
 250:	88 04 0f             	mov    %al,(%edi,%ecx,1)
        i++;
 253:	89 ca                	mov    %ecx,%edx
 255:	83 c1 01             	add    $0x1,%ecx
    while (base[i] != '\0') {
 258:	0f b6 04 0e          	movzbl (%esi,%ecx,1),%eax
 25c:	84 c0                	test   %al,%al
 25e:	75 f0                	jne    250 <create_filename+0x20>
    filename[i++] = '.';
 260:	8b 45 10             	mov    0x10(%ebp),%eax
 263:	01 c8                	add    %ecx,%eax
 265:	89 45 e0             	mov    %eax,-0x20(%ebp)
 268:	8d 42 02             	lea    0x2(%edx),%eax
 26b:	89 45 dc             	mov    %eax,-0x24(%ebp)
    if (n == 0) {
 26e:	85 db                	test   %ebx,%ebx
 270:	0f 84 ca 00 00 00    	je     340 <create_filename+0x110>
    while (temp_n > 0) {
 276:	89 da                	mov    %ebx,%edx
    int len = 0;
 278:	be 00 00 00 00       	mov    $0x0,%esi
    while (temp_n > 0) {
 27d:	0f 8e 95 00 00 00    	jle    318 <create_filename+0xe8>
 283:	89 4d d8             	mov    %ecx,-0x28(%ebp)
 286:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 28d:	8d 76 00             	lea    0x0(%esi),%esi
        temp_n /= 10;
 290:	b8 cd cc cc cc       	mov    $0xcccccccd,%eax
 295:	89 d1                	mov    %edx,%ecx
 297:	89 f7                	mov    %esi,%edi
        len++;
 299:	83 c6 01             	add    $0x1,%esi
        temp_n /= 10;
 29c:	f7 e2                	mul    %edx
 29e:	c1 ea 03             	shr    $0x3,%edx
    while (temp_n > 0) {
 2a1:	83 f9 09             	cmp    $0x9,%ecx
 2a4:	7f ea                	jg     290 <create_filename+0x60>
    str[len] = '\0';
 2a6:	c6 44 35 ea 00       	movb   $0x0,-0x16(%ebp,%esi,1)
 2ab:	8b 4d d8             	mov    -0x28(%ebp),%ecx
    while (n > 0) {
 2ae:	8d 75 ea             	lea    -0x16(%ebp),%esi
 2b1:	01 fe                	add    %edi,%esi
 2b3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2b7:	90                   	nop
        str[--len] = (n % 10) + '0';
 2b8:	b8 cd cc cc cc       	mov    $0xcccccccd,%eax
    while (n > 0) {
 2bd:	83 ee 01             	sub    $0x1,%esi
        str[--len] = (n % 10) + '0';
 2c0:	f7 e3                	mul    %ebx
 2c2:	89 d8                	mov    %ebx,%eax
 2c4:	c1 ea 03             	shr    $0x3,%edx
 2c7:	8d 3c 92             	lea    (%edx,%edx,4),%edi
 2ca:	01 ff                	add    %edi,%edi
 2cc:	29 f8                	sub    %edi,%eax
 2ce:	83 c0 30             	add    $0x30,%eax
 2d1:	88 46 01             	mov    %al,0x1(%esi)
        n /= 10;
 2d4:	89 d8                	mov    %ebx,%eax
 2d6:	89 d3                	mov    %edx,%ebx
    while (n > 0) {
 2d8:	83 f8 09             	cmp    $0x9,%eax
 2db:	7f db                	jg     2b8 <create_filename+0x88>
    while (num_str[j] != '\0') {
 2dd:	0f b6 55 ea          	movzbl -0x16(%ebp),%edx
 2e1:	8d 5d ea             	lea    -0x16(%ebp),%ebx
 2e4:	0f b6 45 eb          	movzbl -0x15(%ebp),%eax
 2e8:	8b 75 10             	mov    0x10(%ebp),%esi
 2eb:	29 cb                	sub    %ecx,%ebx
 2ed:	84 d2                	test   %dl,%dl
 2ef:	75 0e                	jne    2ff <create_filename+0xcf>
 2f1:	eb 25                	jmp    318 <create_filename+0xe8>
 2f3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2f7:	90                   	nop
 2f8:	89 c2                	mov    %eax,%edx
 2fa:	0f b6 44 19 01       	movzbl 0x1(%ecx,%ebx,1),%eax
        filename[i++] = num_str[j++];
 2ff:	83 c1 01             	add    $0x1,%ecx
 302:	88 54 0e ff          	mov    %dl,-0x1(%esi,%ecx,1)
    while (num_str[j] != '\0') {
 306:	84 c0                	test   %al,%al
 308:	75 ee                	jne    2f8 <create_filename+0xc8>
    filename[i++] = '.';
 30a:	8b 45 10             	mov    0x10(%ebp),%eax
 30d:	01 c8                	add    %ecx,%eax
 30f:	89 45 e0             	mov    %eax,-0x20(%ebp)
 312:	8d 41 01             	lea    0x1(%ecx),%eax
 315:	89 45 dc             	mov    %eax,-0x24(%ebp)
 318:	8b 45 e0             	mov    -0x20(%ebp),%eax
    filename[i++] = 't';
 31b:	8b 7d dc             	mov    -0x24(%ebp),%edi
    filename[i++] = '.';
 31e:	c6 00 2e             	movb   $0x2e,(%eax)
    filename[i++] = 't';
 321:	8b 45 10             	mov    0x10(%ebp),%eax
 324:	c6 04 38 74          	movb   $0x74,(%eax,%edi,1)
    filename[i++] = 'x';
 328:	c6 44 08 02 78       	movb   $0x78,0x2(%eax,%ecx,1)
    filename[i++] = 't';
 32d:	c6 44 08 03 74       	movb   $0x74,0x3(%eax,%ecx,1)
    filename[i] = '\0'; // Null-terminate the string
 332:	c6 44 08 04 00       	movb   $0x0,0x4(%eax,%ecx,1)
}
 337:	83 c4 1c             	add    $0x1c,%esp
 33a:	5b                   	pop    %ebx
 33b:	5e                   	pop    %esi
 33c:	5f                   	pop    %edi
 33d:	5d                   	pop    %ebp
 33e:	c3                   	ret    
 33f:	90                   	nop
        filename[i++] = num_str[j++];
 340:	8b 45 10             	mov    0x10(%ebp),%eax
 343:	83 c1 01             	add    $0x1,%ecx
 346:	c6 44 08 ff 30       	movb   $0x30,-0x1(%eax,%ecx,1)
    while (num_str[j] != '\0') {
 34b:	eb bd                	jmp    30a <create_filename+0xda>
 34d:	8d 76 00             	lea    0x0(%esi),%esi
    while (base[i] != '\0') {
 350:	8b 45 10             	mov    0x10(%ebp),%eax
 353:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
    int i = 0;
 35a:	31 c9                	xor    %ecx,%ecx
    while (base[i] != '\0') {
 35c:	89 45 e0             	mov    %eax,-0x20(%ebp)
 35f:	e9 0a ff ff ff       	jmp    26e <create_filename+0x3e>
 364:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 36b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 36f:	90                   	nop

00000370 <write_to_file>:
void write_to_file(char *filename, char *text) {
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	57                   	push   %edi
 374:	56                   	push   %esi
 375:	53                   	push   %ebx
 376:	83 ec 28             	sub    $0x28,%esp
 379:	8b 55 0c             	mov    0xc(%ebp),%edx
 37c:	8b 7d 08             	mov    0x8(%ebp),%edi
    int n = strlen(text);
 37f:	52                   	push   %edx
 380:	89 55 e4             	mov    %edx,-0x1c(%ebp)
 383:	e8 28 02 00 00       	call   5b0 <strlen>
 388:	89 c6                	mov    %eax,%esi
    fd = open(filename, O_WRONLY | O_CREATE);
 38a:	58                   	pop    %eax
 38b:	5a                   	pop    %edx
 38c:	68 01 02 00 00       	push   $0x201
 391:	57                   	push   %edi
 392:	e8 1c 04 00 00       	call   7b3 <open>
    if (fd < 0) {
 397:	83 c4 10             	add    $0x10,%esp
 39a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 39d:	85 c0                	test   %eax,%eax
 39f:	78 67                	js     408 <write_to_file+0x98>
    if (write(fd, text, n) != n) {
 3a1:	83 ec 04             	sub    $0x4,%esp
 3a4:	89 c3                	mov    %eax,%ebx
 3a6:	56                   	push   %esi
 3a7:	52                   	push   %edx
 3a8:	50                   	push   %eax
 3a9:	e8 e5 03 00 00       	call   793 <write>
 3ae:	83 c4 10             	add    $0x10,%esp
 3b1:	39 f0                	cmp    %esi,%eax
 3b3:	75 2b                	jne    3e0 <write_to_file+0x70>
    close(fd);
 3b5:	83 ec 0c             	sub    $0xc,%esp
 3b8:	53                   	push   %ebx
 3b9:	e8 dd 03 00 00       	call   79b <close>
    printf(1, "Successfully wrote to %s\n", filename); // Debugging print
 3be:	83 c4 0c             	add    $0xc,%esp
 3c1:	57                   	push   %edi
 3c2:	68 3a 0c 00 00       	push   $0xc3a
 3c7:	6a 01                	push   $0x1
 3c9:	e8 12 05 00 00       	call   8e0 <printf>
 3ce:	83 c4 10             	add    $0x10,%esp
}
 3d1:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3d4:	5b                   	pop    %ebx
 3d5:	5e                   	pop    %esi
 3d6:	5f                   	pop    %edi
 3d7:	5d                   	pop    %ebp
 3d8:	c3                   	ret    
 3d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printf(2, "Error: write error for %s\n", filename);
 3e0:	83 ec 04             	sub    $0x4,%esp
 3e3:	57                   	push   %edi
 3e4:	68 1f 0c 00 00       	push   $0xc1f
 3e9:	6a 02                	push   $0x2
 3eb:	e8 f0 04 00 00       	call   8e0 <printf>
        close(fd);
 3f0:	89 5d 08             	mov    %ebx,0x8(%ebp)
 3f3:	83 c4 10             	add    $0x10,%esp
}
 3f6:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3f9:	5b                   	pop    %ebx
 3fa:	5e                   	pop    %esi
 3fb:	5f                   	pop    %edi
 3fc:	5d                   	pop    %ebp
        close(fd);
 3fd:	e9 99 03 00 00       	jmp    79b <close>
 402:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printf(2, "Error: cannot open %s\n", filename);
 408:	83 ec 04             	sub    $0x4,%esp
 40b:	57                   	push   %edi
 40c:	68 08 0c 00 00       	push   $0xc08
 411:	6a 02                	push   $0x2
 413:	e8 c8 04 00 00       	call   8e0 <printf>
        return;
 418:	83 c4 10             	add    $0x10,%esp
}
 41b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 41e:	5b                   	pop    %ebx
 41f:	5e                   	pop    %esi
 420:	5f                   	pop    %edi
 421:	5d                   	pop    %ebp
 422:	c3                   	ret    
 423:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 42a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000430 <matrix_multiply>:
void matrix_multiply(int A[N][N], int B[N][N], int C[N][N]) {
 430:	55                   	push   %ebp
 431:	89 e5                	mov    %esp,%ebp
 433:	57                   	push   %edi
 434:	56                   	push   %esi
 435:	53                   	push   %ebx
 436:	83 ec 14             	sub    $0x14,%esp
 439:	8b 7d 08             	mov    0x8(%ebp),%edi
 43c:	8b 45 0c             	mov    0xc(%ebp),%eax
 43f:	8b 75 10             	mov    0x10(%ebp),%esi
 442:	89 7d f0             	mov    %edi,-0x10(%ebp)
 445:	81 c7 84 04 00 00    	add    $0x484,%edi
 44b:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 44e:	8d b8 84 04 00 00    	lea    0x484(%eax),%edi
 454:	05 c8 04 00 00       	add    $0x4c8,%eax
 459:	89 75 e8             	mov    %esi,-0x18(%ebp)
 45c:	89 7d e0             	mov    %edi,-0x20(%ebp)
 45f:	89 45 ec             	mov    %eax,-0x14(%ebp)
        for (j = 0; j < N; j++) {
 462:	8b 7d e0             	mov    -0x20(%ebp),%edi
void matrix_multiply(int A[N][N], int B[N][N], int C[N][N]) {
 465:	8b 75 e8             	mov    -0x18(%ebp),%esi
 468:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 46f:	90                   	nop
            C[i][j] = 0;
 470:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
 476:	8b 5d f0             	mov    -0x10(%ebp),%ebx
 479:	8d 87 7c fb ff ff    	lea    -0x484(%edi),%eax
 47f:	31 c9                	xor    %ecx,%ecx
 481:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
                C[i][j] += A[i][k] * B[k][j];
 488:	8b 13                	mov    (%ebx),%edx
 48a:	0f af 10             	imul   (%eax),%edx
            for (k = 0; k < N; k++) {
 48d:	83 c0 44             	add    $0x44,%eax
 490:	83 c3 04             	add    $0x4,%ebx
                C[i][j] += A[i][k] * B[k][j];
 493:	01 d1                	add    %edx,%ecx
 495:	89 0e                	mov    %ecx,(%esi)
            for (k = 0; k < N; k++) {
 497:	39 f8                	cmp    %edi,%eax
 499:	75 ed                	jne    488 <matrix_multiply+0x58>
        for (j = 0; j < N; j++) {
 49b:	83 c6 04             	add    $0x4,%esi
 49e:	8d 78 04             	lea    0x4(%eax),%edi
 4a1:	3b 7d ec             	cmp    -0x14(%ebp),%edi
 4a4:	75 ca                	jne    470 <matrix_multiply+0x40>
    for (i = 0; i < N; i++) {
 4a6:	83 45 f0 44          	addl   $0x44,-0x10(%ebp)
 4aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4ad:	83 45 e8 44          	addl   $0x44,-0x18(%ebp)
 4b1:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
 4b4:	75 ac                	jne    462 <matrix_multiply+0x32>
}
 4b6:	83 c4 14             	add    $0x14,%esp
 4b9:	5b                   	pop    %ebx
 4ba:	5e                   	pop    %esi
 4bb:	5f                   	pop    %edi
 4bc:	5d                   	pop    %ebp
 4bd:	c3                   	ret    
 4be:	66 90                	xchg   %ax,%ax

000004c0 <print_matrix>:
void print_matrix(int matrix[N][N]) {
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	57                   	push   %edi
 4c4:	56                   	push   %esi
 4c5:	53                   	push   %ebx
 4c6:	83 ec 0c             	sub    $0xc,%esp
 4c9:	8b 7d 08             	mov    0x8(%ebp),%edi
 4cc:	8d 77 44             	lea    0x44(%edi),%esi
 4cf:	81 c7 c8 04 00 00    	add    $0x4c8,%edi
 4d5:	8d 76 00             	lea    0x0(%esi),%esi
        for (j = 0; j < N; j++) {
 4d8:	8d 5e bc             	lea    -0x44(%esi),%ebx
 4db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4df:	90                   	nop
            printf(1, "%d ", matrix[i][j]);
 4e0:	83 ec 04             	sub    $0x4,%esp
 4e3:	ff 33                	push   (%ebx)
        for (j = 0; j < N; j++) {
 4e5:	83 c3 04             	add    $0x4,%ebx
            printf(1, "%d ", matrix[i][j]);
 4e8:	68 54 0c 00 00       	push   $0xc54
 4ed:	6a 01                	push   $0x1
 4ef:	e8 ec 03 00 00       	call   8e0 <printf>
        for (j = 0; j < N; j++) {
 4f4:	83 c4 10             	add    $0x10,%esp
 4f7:	39 f3                	cmp    %esi,%ebx
 4f9:	75 e5                	jne    4e0 <print_matrix+0x20>
        printf(1, "\n");
 4fb:	83 ec 08             	sub    $0x8,%esp
    for (i = 0; i < N; i++) {
 4fe:	8d 73 44             	lea    0x44(%ebx),%esi
        printf(1, "\n");
 501:	68 7a 0c 00 00       	push   $0xc7a
 506:	6a 01                	push   $0x1
 508:	e8 d3 03 00 00       	call   8e0 <printf>
    for (i = 0; i < N; i++) {
 50d:	83 c4 10             	add    $0x10,%esp
 510:	39 fe                	cmp    %edi,%esi
 512:	75 c4                	jne    4d8 <print_matrix+0x18>
}
 514:	8d 65 f4             	lea    -0xc(%ebp),%esp
 517:	5b                   	pop    %ebx
 518:	5e                   	pop    %esi
 519:	5f                   	pop    %edi
 51a:	5d                   	pop    %ebp
 51b:	c3                   	ret    
 51c:	66 90                	xchg   %ax,%ax
 51e:	66 90                	xchg   %ax,%ax

00000520 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 520:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 521:	31 c0                	xor    %eax,%eax
{
 523:	89 e5                	mov    %esp,%ebp
 525:	53                   	push   %ebx
 526:	8b 4d 08             	mov    0x8(%ebp),%ecx
 529:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 52c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 530:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 534:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 537:	83 c0 01             	add    $0x1,%eax
 53a:	84 d2                	test   %dl,%dl
 53c:	75 f2                	jne    530 <strcpy+0x10>
    ;
  return os;
}
 53e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 541:	89 c8                	mov    %ecx,%eax
 543:	c9                   	leave  
 544:	c3                   	ret    
 545:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 54c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000550 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 550:	55                   	push   %ebp
 551:	89 e5                	mov    %esp,%ebp
 553:	53                   	push   %ebx
 554:	8b 55 08             	mov    0x8(%ebp),%edx
 557:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 55a:	0f b6 02             	movzbl (%edx),%eax
 55d:	84 c0                	test   %al,%al
 55f:	75 17                	jne    578 <strcmp+0x28>
 561:	eb 3a                	jmp    59d <strcmp+0x4d>
 563:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 567:	90                   	nop
 568:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 56c:	83 c2 01             	add    $0x1,%edx
 56f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 572:	84 c0                	test   %al,%al
 574:	74 1a                	je     590 <strcmp+0x40>
    p++, q++;
 576:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
 578:	0f b6 19             	movzbl (%ecx),%ebx
 57b:	38 c3                	cmp    %al,%bl
 57d:	74 e9                	je     568 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 57f:	29 d8                	sub    %ebx,%eax
}
 581:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 584:	c9                   	leave  
 585:	c3                   	ret    
 586:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 58d:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 590:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 594:	31 c0                	xor    %eax,%eax
 596:	29 d8                	sub    %ebx,%eax
}
 598:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 59b:	c9                   	leave  
 59c:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
 59d:	0f b6 19             	movzbl (%ecx),%ebx
 5a0:	31 c0                	xor    %eax,%eax
 5a2:	eb db                	jmp    57f <strcmp+0x2f>
 5a4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5af:	90                   	nop

000005b0 <strlen>:

uint
strlen(const char *s)
{
 5b0:	55                   	push   %ebp
 5b1:	89 e5                	mov    %esp,%ebp
 5b3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 5b6:	80 3a 00             	cmpb   $0x0,(%edx)
 5b9:	74 15                	je     5d0 <strlen+0x20>
 5bb:	31 c0                	xor    %eax,%eax
 5bd:	8d 76 00             	lea    0x0(%esi),%esi
 5c0:	83 c0 01             	add    $0x1,%eax
 5c3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 5c7:	89 c1                	mov    %eax,%ecx
 5c9:	75 f5                	jne    5c0 <strlen+0x10>
    ;
  return n;
}
 5cb:	89 c8                	mov    %ecx,%eax
 5cd:	5d                   	pop    %ebp
 5ce:	c3                   	ret    
 5cf:	90                   	nop
  for(n = 0; s[n]; n++)
 5d0:	31 c9                	xor    %ecx,%ecx
}
 5d2:	5d                   	pop    %ebp
 5d3:	89 c8                	mov    %ecx,%eax
 5d5:	c3                   	ret    
 5d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5dd:	8d 76 00             	lea    0x0(%esi),%esi

000005e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 5e0:	55                   	push   %ebp
 5e1:	89 e5                	mov    %esp,%ebp
 5e3:	57                   	push   %edi
 5e4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 5e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 5ea:	8b 45 0c             	mov    0xc(%ebp),%eax
 5ed:	89 d7                	mov    %edx,%edi
 5ef:	fc                   	cld    
 5f0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 5f2:	8b 7d fc             	mov    -0x4(%ebp),%edi
 5f5:	89 d0                	mov    %edx,%eax
 5f7:	c9                   	leave  
 5f8:	c3                   	ret    
 5f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000600 <strchr>:

char*
strchr(const char *s, char c)
{
 600:	55                   	push   %ebp
 601:	89 e5                	mov    %esp,%ebp
 603:	8b 45 08             	mov    0x8(%ebp),%eax
 606:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 60a:	0f b6 10             	movzbl (%eax),%edx
 60d:	84 d2                	test   %dl,%dl
 60f:	75 12                	jne    623 <strchr+0x23>
 611:	eb 1d                	jmp    630 <strchr+0x30>
 613:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 617:	90                   	nop
 618:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 61c:	83 c0 01             	add    $0x1,%eax
 61f:	84 d2                	test   %dl,%dl
 621:	74 0d                	je     630 <strchr+0x30>
    if(*s == c)
 623:	38 d1                	cmp    %dl,%cl
 625:	75 f1                	jne    618 <strchr+0x18>
      return (char*)s;
  return 0;
}
 627:	5d                   	pop    %ebp
 628:	c3                   	ret    
 629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 630:	31 c0                	xor    %eax,%eax
}
 632:	5d                   	pop    %ebp
 633:	c3                   	ret    
 634:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 63b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 63f:	90                   	nop

00000640 <gets>:

char*
gets(char *buf, int max)
{
 640:	55                   	push   %ebp
 641:	89 e5                	mov    %esp,%ebp
 643:	57                   	push   %edi
 644:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 645:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 648:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 649:	31 db                	xor    %ebx,%ebx
{
 64b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 64e:	eb 27                	jmp    677 <gets+0x37>
    cc = read(0, &c, 1);
 650:	83 ec 04             	sub    $0x4,%esp
 653:	6a 01                	push   $0x1
 655:	57                   	push   %edi
 656:	6a 00                	push   $0x0
 658:	e8 2e 01 00 00       	call   78b <read>
    if(cc < 1)
 65d:	83 c4 10             	add    $0x10,%esp
 660:	85 c0                	test   %eax,%eax
 662:	7e 1d                	jle    681 <gets+0x41>
      break;
    buf[i++] = c;
 664:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 668:	8b 55 08             	mov    0x8(%ebp),%edx
 66b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 66f:	3c 0a                	cmp    $0xa,%al
 671:	74 1d                	je     690 <gets+0x50>
 673:	3c 0d                	cmp    $0xd,%al
 675:	74 19                	je     690 <gets+0x50>
  for(i=0; i+1 < max; ){
 677:	89 de                	mov    %ebx,%esi
 679:	83 c3 01             	add    $0x1,%ebx
 67c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 67f:	7c cf                	jl     650 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 681:	8b 45 08             	mov    0x8(%ebp),%eax
 684:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 688:	8d 65 f4             	lea    -0xc(%ebp),%esp
 68b:	5b                   	pop    %ebx
 68c:	5e                   	pop    %esi
 68d:	5f                   	pop    %edi
 68e:	5d                   	pop    %ebp
 68f:	c3                   	ret    
  buf[i] = '\0';
 690:	8b 45 08             	mov    0x8(%ebp),%eax
 693:	89 de                	mov    %ebx,%esi
 695:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 699:	8d 65 f4             	lea    -0xc(%ebp),%esp
 69c:	5b                   	pop    %ebx
 69d:	5e                   	pop    %esi
 69e:	5f                   	pop    %edi
 69f:	5d                   	pop    %ebp
 6a0:	c3                   	ret    
 6a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6af:	90                   	nop

000006b0 <stat>:

int
stat(const char *n, struct stat *st)
{
 6b0:	55                   	push   %ebp
 6b1:	89 e5                	mov    %esp,%ebp
 6b3:	56                   	push   %esi
 6b4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 6b5:	83 ec 08             	sub    $0x8,%esp
 6b8:	6a 00                	push   $0x0
 6ba:	ff 75 08             	push   0x8(%ebp)
 6bd:	e8 f1 00 00 00       	call   7b3 <open>
  if(fd < 0)
 6c2:	83 c4 10             	add    $0x10,%esp
 6c5:	85 c0                	test   %eax,%eax
 6c7:	78 27                	js     6f0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 6c9:	83 ec 08             	sub    $0x8,%esp
 6cc:	ff 75 0c             	push   0xc(%ebp)
 6cf:	89 c3                	mov    %eax,%ebx
 6d1:	50                   	push   %eax
 6d2:	e8 f4 00 00 00       	call   7cb <fstat>
  close(fd);
 6d7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 6da:	89 c6                	mov    %eax,%esi
  close(fd);
 6dc:	e8 ba 00 00 00       	call   79b <close>
  return r;
 6e1:	83 c4 10             	add    $0x10,%esp
}
 6e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 6e7:	89 f0                	mov    %esi,%eax
 6e9:	5b                   	pop    %ebx
 6ea:	5e                   	pop    %esi
 6eb:	5d                   	pop    %ebp
 6ec:	c3                   	ret    
 6ed:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 6f0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 6f5:	eb ed                	jmp    6e4 <stat+0x34>
 6f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6fe:	66 90                	xchg   %ax,%ax

00000700 <atoi>:

int
atoi(const char *s)
{
 700:	55                   	push   %ebp
 701:	89 e5                	mov    %esp,%ebp
 703:	53                   	push   %ebx
 704:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 707:	0f be 02             	movsbl (%edx),%eax
 70a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 70d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 710:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 715:	77 1e                	ja     735 <atoi+0x35>
 717:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 71e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 720:	83 c2 01             	add    $0x1,%edx
 723:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 726:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 72a:	0f be 02             	movsbl (%edx),%eax
 72d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 730:	80 fb 09             	cmp    $0x9,%bl
 733:	76 eb                	jbe    720 <atoi+0x20>
  return n;
}
 735:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 738:	89 c8                	mov    %ecx,%eax
 73a:	c9                   	leave  
 73b:	c3                   	ret    
 73c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000740 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 740:	55                   	push   %ebp
 741:	89 e5                	mov    %esp,%ebp
 743:	57                   	push   %edi
 744:	8b 45 10             	mov    0x10(%ebp),%eax
 747:	8b 55 08             	mov    0x8(%ebp),%edx
 74a:	56                   	push   %esi
 74b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 74e:	85 c0                	test   %eax,%eax
 750:	7e 13                	jle    765 <memmove+0x25>
 752:	01 d0                	add    %edx,%eax
  dst = vdst;
 754:	89 d7                	mov    %edx,%edi
 756:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 75d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 760:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 761:	39 f8                	cmp    %edi,%eax
 763:	75 fb                	jne    760 <memmove+0x20>
  return vdst;
}
 765:	5e                   	pop    %esi
 766:	89 d0                	mov    %edx,%eax
 768:	5f                   	pop    %edi
 769:	5d                   	pop    %ebp
 76a:	c3                   	ret    

0000076b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 76b:	b8 01 00 00 00       	mov    $0x1,%eax
 770:	cd 40                	int    $0x40
 772:	c3                   	ret    

00000773 <exit>:
SYSCALL(exit)
 773:	b8 02 00 00 00       	mov    $0x2,%eax
 778:	cd 40                	int    $0x40
 77a:	c3                   	ret    

0000077b <wait>:
SYSCALL(wait)
 77b:	b8 03 00 00 00       	mov    $0x3,%eax
 780:	cd 40                	int    $0x40
 782:	c3                   	ret    

00000783 <pipe>:
SYSCALL(pipe)
 783:	b8 04 00 00 00       	mov    $0x4,%eax
 788:	cd 40                	int    $0x40
 78a:	c3                   	ret    

0000078b <read>:
SYSCALL(read)
 78b:	b8 05 00 00 00       	mov    $0x5,%eax
 790:	cd 40                	int    $0x40
 792:	c3                   	ret    

00000793 <write>:
SYSCALL(write)
 793:	b8 10 00 00 00       	mov    $0x10,%eax
 798:	cd 40                	int    $0x40
 79a:	c3                   	ret    

0000079b <close>:
SYSCALL(close)
 79b:	b8 15 00 00 00       	mov    $0x15,%eax
 7a0:	cd 40                	int    $0x40
 7a2:	c3                   	ret    

000007a3 <kill>:
SYSCALL(kill)
 7a3:	b8 06 00 00 00       	mov    $0x6,%eax
 7a8:	cd 40                	int    $0x40
 7aa:	c3                   	ret    

000007ab <exec>:
SYSCALL(exec)
 7ab:	b8 07 00 00 00       	mov    $0x7,%eax
 7b0:	cd 40                	int    $0x40
 7b2:	c3                   	ret    

000007b3 <open>:
SYSCALL(open)
 7b3:	b8 0f 00 00 00       	mov    $0xf,%eax
 7b8:	cd 40                	int    $0x40
 7ba:	c3                   	ret    

000007bb <mknod>:
SYSCALL(mknod)
 7bb:	b8 11 00 00 00       	mov    $0x11,%eax
 7c0:	cd 40                	int    $0x40
 7c2:	c3                   	ret    

000007c3 <unlink>:
SYSCALL(unlink)
 7c3:	b8 12 00 00 00       	mov    $0x12,%eax
 7c8:	cd 40                	int    $0x40
 7ca:	c3                   	ret    

000007cb <fstat>:
SYSCALL(fstat)
 7cb:	b8 08 00 00 00       	mov    $0x8,%eax
 7d0:	cd 40                	int    $0x40
 7d2:	c3                   	ret    

000007d3 <link>:
SYSCALL(link)
 7d3:	b8 13 00 00 00       	mov    $0x13,%eax
 7d8:	cd 40                	int    $0x40
 7da:	c3                   	ret    

000007db <mkdir>:
SYSCALL(mkdir)
 7db:	b8 14 00 00 00       	mov    $0x14,%eax
 7e0:	cd 40                	int    $0x40
 7e2:	c3                   	ret    

000007e3 <chdir>:
SYSCALL(chdir)
 7e3:	b8 09 00 00 00       	mov    $0x9,%eax
 7e8:	cd 40                	int    $0x40
 7ea:	c3                   	ret    

000007eb <dup>:
SYSCALL(dup)
 7eb:	b8 0a 00 00 00       	mov    $0xa,%eax
 7f0:	cd 40                	int    $0x40
 7f2:	c3                   	ret    

000007f3 <getpid>:
SYSCALL(getpid)
 7f3:	b8 0b 00 00 00       	mov    $0xb,%eax
 7f8:	cd 40                	int    $0x40
 7fa:	c3                   	ret    

000007fb <sbrk>:
SYSCALL(sbrk)
 7fb:	b8 0c 00 00 00       	mov    $0xc,%eax
 800:	cd 40                	int    $0x40
 802:	c3                   	ret    

00000803 <sleep>:
SYSCALL(sleep)
 803:	b8 0d 00 00 00       	mov    $0xd,%eax
 808:	cd 40                	int    $0x40
 80a:	c3                   	ret    

0000080b <uptime>:
SYSCALL(uptime)
 80b:	b8 0e 00 00 00       	mov    $0xe,%eax
 810:	cd 40                	int    $0x40
 812:	c3                   	ret    

00000813 <ps>:
SYSCALL(ps)
 813:	b8 16 00 00 00       	mov    $0x16,%eax
 818:	cd 40                	int    $0x40
 81a:	c3                   	ret    

0000081b <sys_ps>:

// usys.S
.globl sys_ps
sys_ps:
    movl SYS_ps, %eax
 81b:	a1 16 00 00 00       	mov    0x16,%eax
    int $64
 820:	cd 40                	int    $0x40
    ret
 822:	c3                   	ret    
 823:	66 90                	xchg   %ax,%ax
 825:	66 90                	xchg   %ax,%ax
 827:	66 90                	xchg   %ax,%ax
 829:	66 90                	xchg   %ax,%ax
 82b:	66 90                	xchg   %ax,%ax
 82d:	66 90                	xchg   %ax,%ax
 82f:	90                   	nop

00000830 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 830:	55                   	push   %ebp
 831:	89 e5                	mov    %esp,%ebp
 833:	57                   	push   %edi
 834:	56                   	push   %esi
 835:	53                   	push   %ebx
 836:	83 ec 3c             	sub    $0x3c,%esp
 839:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 83c:	89 d1                	mov    %edx,%ecx
{
 83e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 841:	85 d2                	test   %edx,%edx
 843:	0f 89 7f 00 00 00    	jns    8c8 <printint+0x98>
 849:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 84d:	74 79                	je     8c8 <printint+0x98>
    neg = 1;
 84f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 856:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 858:	31 db                	xor    %ebx,%ebx
 85a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 85d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 860:	89 c8                	mov    %ecx,%eax
 862:	31 d2                	xor    %edx,%edx
 864:	89 cf                	mov    %ecx,%edi
 866:	f7 75 c4             	divl   -0x3c(%ebp)
 869:	0f b6 92 38 0d 00 00 	movzbl 0xd38(%edx),%edx
 870:	89 45 c0             	mov    %eax,-0x40(%ebp)
 873:	89 d8                	mov    %ebx,%eax
 875:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 878:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 87b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 87e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 881:	76 dd                	jbe    860 <printint+0x30>
  if(neg)
 883:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 886:	85 c9                	test   %ecx,%ecx
 888:	74 0c                	je     896 <printint+0x66>
    buf[i++] = '-';
 88a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 88f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 891:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 896:	8b 7d b8             	mov    -0x48(%ebp),%edi
 899:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 89d:	eb 07                	jmp    8a6 <printint+0x76>
 89f:	90                   	nop
    putc(fd, buf[i]);
 8a0:	0f b6 13             	movzbl (%ebx),%edx
 8a3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 8a6:	83 ec 04             	sub    $0x4,%esp
 8a9:	88 55 d7             	mov    %dl,-0x29(%ebp)
 8ac:	6a 01                	push   $0x1
 8ae:	56                   	push   %esi
 8af:	57                   	push   %edi
 8b0:	e8 de fe ff ff       	call   793 <write>
  while(--i >= 0)
 8b5:	83 c4 10             	add    $0x10,%esp
 8b8:	39 de                	cmp    %ebx,%esi
 8ba:	75 e4                	jne    8a0 <printint+0x70>
}
 8bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 8bf:	5b                   	pop    %ebx
 8c0:	5e                   	pop    %esi
 8c1:	5f                   	pop    %edi
 8c2:	5d                   	pop    %ebp
 8c3:	c3                   	ret    
 8c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 8c8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 8cf:	eb 87                	jmp    858 <printint+0x28>
 8d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8df:	90                   	nop

000008e0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 8e0:	55                   	push   %ebp
 8e1:	89 e5                	mov    %esp,%ebp
 8e3:	57                   	push   %edi
 8e4:	56                   	push   %esi
 8e5:	53                   	push   %ebx
 8e6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 8e9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 8ec:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 8ef:	0f b6 13             	movzbl (%ebx),%edx
 8f2:	84 d2                	test   %dl,%dl
 8f4:	74 6a                	je     960 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
 8f6:	8d 45 10             	lea    0x10(%ebp),%eax
 8f9:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 8fc:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 8ff:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
 901:	89 45 d0             	mov    %eax,-0x30(%ebp)
 904:	eb 36                	jmp    93c <printf+0x5c>
 906:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 90d:	8d 76 00             	lea    0x0(%esi),%esi
 910:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 913:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
 918:	83 f8 25             	cmp    $0x25,%eax
 91b:	74 15                	je     932 <printf+0x52>
  write(fd, &c, 1);
 91d:	83 ec 04             	sub    $0x4,%esp
 920:	88 55 e7             	mov    %dl,-0x19(%ebp)
 923:	6a 01                	push   $0x1
 925:	57                   	push   %edi
 926:	56                   	push   %esi
 927:	e8 67 fe ff ff       	call   793 <write>
 92c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
 92f:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 932:	0f b6 13             	movzbl (%ebx),%edx
 935:	83 c3 01             	add    $0x1,%ebx
 938:	84 d2                	test   %dl,%dl
 93a:	74 24                	je     960 <printf+0x80>
    c = fmt[i] & 0xff;
 93c:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 93f:	85 c9                	test   %ecx,%ecx
 941:	74 cd                	je     910 <printf+0x30>
      }
    } else if(state == '%'){
 943:	83 f9 25             	cmp    $0x25,%ecx
 946:	75 ea                	jne    932 <printf+0x52>
      if(c == 'd'){
 948:	83 f8 25             	cmp    $0x25,%eax
 94b:	0f 84 07 01 00 00    	je     a58 <printf+0x178>
 951:	83 e8 63             	sub    $0x63,%eax
 954:	83 f8 15             	cmp    $0x15,%eax
 957:	77 17                	ja     970 <printf+0x90>
 959:	ff 24 85 e0 0c 00 00 	jmp    *0xce0(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 960:	8d 65 f4             	lea    -0xc(%ebp),%esp
 963:	5b                   	pop    %ebx
 964:	5e                   	pop    %esi
 965:	5f                   	pop    %edi
 966:	5d                   	pop    %ebp
 967:	c3                   	ret    
 968:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 96f:	90                   	nop
  write(fd, &c, 1);
 970:	83 ec 04             	sub    $0x4,%esp
 973:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 976:	6a 01                	push   $0x1
 978:	57                   	push   %edi
 979:	56                   	push   %esi
 97a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 97e:	e8 10 fe ff ff       	call   793 <write>
        putc(fd, c);
 983:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 987:	83 c4 0c             	add    $0xc,%esp
 98a:	88 55 e7             	mov    %dl,-0x19(%ebp)
 98d:	6a 01                	push   $0x1
 98f:	57                   	push   %edi
 990:	56                   	push   %esi
 991:	e8 fd fd ff ff       	call   793 <write>
        putc(fd, c);
 996:	83 c4 10             	add    $0x10,%esp
      state = 0;
 999:	31 c9                	xor    %ecx,%ecx
 99b:	eb 95                	jmp    932 <printf+0x52>
 99d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 9a0:	83 ec 0c             	sub    $0xc,%esp
 9a3:	b9 10 00 00 00       	mov    $0x10,%ecx
 9a8:	6a 00                	push   $0x0
 9aa:	8b 45 d0             	mov    -0x30(%ebp),%eax
 9ad:	8b 10                	mov    (%eax),%edx
 9af:	89 f0                	mov    %esi,%eax
 9b1:	e8 7a fe ff ff       	call   830 <printint>
        ap++;
 9b6:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 9ba:	83 c4 10             	add    $0x10,%esp
      state = 0;
 9bd:	31 c9                	xor    %ecx,%ecx
 9bf:	e9 6e ff ff ff       	jmp    932 <printf+0x52>
 9c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 9c8:	8b 45 d0             	mov    -0x30(%ebp),%eax
 9cb:	8b 10                	mov    (%eax),%edx
        ap++;
 9cd:	83 c0 04             	add    $0x4,%eax
 9d0:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 9d3:	85 d2                	test   %edx,%edx
 9d5:	0f 84 8d 00 00 00    	je     a68 <printf+0x188>
        while(*s != 0){
 9db:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
 9de:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
 9e0:	84 c0                	test   %al,%al
 9e2:	0f 84 4a ff ff ff    	je     932 <printf+0x52>
 9e8:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 9eb:	89 d3                	mov    %edx,%ebx
 9ed:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 9f0:	83 ec 04             	sub    $0x4,%esp
          s++;
 9f3:	83 c3 01             	add    $0x1,%ebx
 9f6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 9f9:	6a 01                	push   $0x1
 9fb:	57                   	push   %edi
 9fc:	56                   	push   %esi
 9fd:	e8 91 fd ff ff       	call   793 <write>
        while(*s != 0){
 a02:	0f b6 03             	movzbl (%ebx),%eax
 a05:	83 c4 10             	add    $0x10,%esp
 a08:	84 c0                	test   %al,%al
 a0a:	75 e4                	jne    9f0 <printf+0x110>
      state = 0;
 a0c:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 a0f:	31 c9                	xor    %ecx,%ecx
 a11:	e9 1c ff ff ff       	jmp    932 <printf+0x52>
 a16:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a1d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 a20:	83 ec 0c             	sub    $0xc,%esp
 a23:	b9 0a 00 00 00       	mov    $0xa,%ecx
 a28:	6a 01                	push   $0x1
 a2a:	e9 7b ff ff ff       	jmp    9aa <printf+0xca>
 a2f:	90                   	nop
        putc(fd, *ap);
 a30:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
 a33:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 a36:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 a38:	6a 01                	push   $0x1
 a3a:	57                   	push   %edi
 a3b:	56                   	push   %esi
        putc(fd, *ap);
 a3c:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 a3f:	e8 4f fd ff ff       	call   793 <write>
        ap++;
 a44:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 a48:	83 c4 10             	add    $0x10,%esp
      state = 0;
 a4b:	31 c9                	xor    %ecx,%ecx
 a4d:	e9 e0 fe ff ff       	jmp    932 <printf+0x52>
 a52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
 a58:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 a5b:	83 ec 04             	sub    $0x4,%esp
 a5e:	e9 2a ff ff ff       	jmp    98d <printf+0xad>
 a63:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 a67:	90                   	nop
          s = "(null)";
 a68:	ba d8 0c 00 00       	mov    $0xcd8,%edx
        while(*s != 0){
 a6d:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 a70:	b8 28 00 00 00       	mov    $0x28,%eax
 a75:	89 d3                	mov    %edx,%ebx
 a77:	e9 74 ff ff ff       	jmp    9f0 <printf+0x110>
 a7c:	66 90                	xchg   %ax,%ax
 a7e:	66 90                	xchg   %ax,%ax

00000a80 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a80:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a81:	a1 fc 10 00 00       	mov    0x10fc,%eax
{
 a86:	89 e5                	mov    %esp,%ebp
 a88:	57                   	push   %edi
 a89:	56                   	push   %esi
 a8a:	53                   	push   %ebx
 a8b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 a8e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a98:	89 c2                	mov    %eax,%edx
 a9a:	8b 00                	mov    (%eax),%eax
 a9c:	39 ca                	cmp    %ecx,%edx
 a9e:	73 30                	jae    ad0 <free+0x50>
 aa0:	39 c1                	cmp    %eax,%ecx
 aa2:	72 04                	jb     aa8 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 aa4:	39 c2                	cmp    %eax,%edx
 aa6:	72 f0                	jb     a98 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 aa8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 aab:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 aae:	39 f8                	cmp    %edi,%eax
 ab0:	74 30                	je     ae2 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 ab2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 ab5:	8b 42 04             	mov    0x4(%edx),%eax
 ab8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 abb:	39 f1                	cmp    %esi,%ecx
 abd:	74 3a                	je     af9 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 abf:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 ac1:	5b                   	pop    %ebx
  freep = p;
 ac2:	89 15 fc 10 00 00    	mov    %edx,0x10fc
}
 ac8:	5e                   	pop    %esi
 ac9:	5f                   	pop    %edi
 aca:	5d                   	pop    %ebp
 acb:	c3                   	ret    
 acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ad0:	39 c2                	cmp    %eax,%edx
 ad2:	72 c4                	jb     a98 <free+0x18>
 ad4:	39 c1                	cmp    %eax,%ecx
 ad6:	73 c0                	jae    a98 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
 ad8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 adb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 ade:	39 f8                	cmp    %edi,%eax
 ae0:	75 d0                	jne    ab2 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
 ae2:	03 70 04             	add    0x4(%eax),%esi
 ae5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 ae8:	8b 02                	mov    (%edx),%eax
 aea:	8b 00                	mov    (%eax),%eax
 aec:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 aef:	8b 42 04             	mov    0x4(%edx),%eax
 af2:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 af5:	39 f1                	cmp    %esi,%ecx
 af7:	75 c6                	jne    abf <free+0x3f>
    p->s.size += bp->s.size;
 af9:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 afc:	89 15 fc 10 00 00    	mov    %edx,0x10fc
    p->s.size += bp->s.size;
 b02:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 b05:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 b08:	89 0a                	mov    %ecx,(%edx)
}
 b0a:	5b                   	pop    %ebx
 b0b:	5e                   	pop    %esi
 b0c:	5f                   	pop    %edi
 b0d:	5d                   	pop    %ebp
 b0e:	c3                   	ret    
 b0f:	90                   	nop

00000b10 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 b10:	55                   	push   %ebp
 b11:	89 e5                	mov    %esp,%ebp
 b13:	57                   	push   %edi
 b14:	56                   	push   %esi
 b15:	53                   	push   %ebx
 b16:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b19:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 b1c:	8b 3d fc 10 00 00    	mov    0x10fc,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b22:	8d 70 07             	lea    0x7(%eax),%esi
 b25:	c1 ee 03             	shr    $0x3,%esi
 b28:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 b2b:	85 ff                	test   %edi,%edi
 b2d:	0f 84 9d 00 00 00    	je     bd0 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b33:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 b35:	8b 4a 04             	mov    0x4(%edx),%ecx
 b38:	39 f1                	cmp    %esi,%ecx
 b3a:	73 6a                	jae    ba6 <malloc+0x96>
 b3c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 b41:	39 de                	cmp    %ebx,%esi
 b43:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 b46:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 b4d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 b50:	eb 17                	jmp    b69 <malloc+0x59>
 b52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b58:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 b5a:	8b 48 04             	mov    0x4(%eax),%ecx
 b5d:	39 f1                	cmp    %esi,%ecx
 b5f:	73 4f                	jae    bb0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 b61:	8b 3d fc 10 00 00    	mov    0x10fc,%edi
 b67:	89 c2                	mov    %eax,%edx
 b69:	39 d7                	cmp    %edx,%edi
 b6b:	75 eb                	jne    b58 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 b6d:	83 ec 0c             	sub    $0xc,%esp
 b70:	ff 75 e4             	push   -0x1c(%ebp)
 b73:	e8 83 fc ff ff       	call   7fb <sbrk>
  if(p == (char*)-1)
 b78:	83 c4 10             	add    $0x10,%esp
 b7b:	83 f8 ff             	cmp    $0xffffffff,%eax
 b7e:	74 1c                	je     b9c <malloc+0x8c>
  hp->s.size = nu;
 b80:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 b83:	83 ec 0c             	sub    $0xc,%esp
 b86:	83 c0 08             	add    $0x8,%eax
 b89:	50                   	push   %eax
 b8a:	e8 f1 fe ff ff       	call   a80 <free>
  return freep;
 b8f:	8b 15 fc 10 00 00    	mov    0x10fc,%edx
      if((p = morecore(nunits)) == 0)
 b95:	83 c4 10             	add    $0x10,%esp
 b98:	85 d2                	test   %edx,%edx
 b9a:	75 bc                	jne    b58 <malloc+0x48>
        return 0;
  }
}
 b9c:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 b9f:	31 c0                	xor    %eax,%eax
}
 ba1:	5b                   	pop    %ebx
 ba2:	5e                   	pop    %esi
 ba3:	5f                   	pop    %edi
 ba4:	5d                   	pop    %ebp
 ba5:	c3                   	ret    
    if(p->s.size >= nunits){
 ba6:	89 d0                	mov    %edx,%eax
 ba8:	89 fa                	mov    %edi,%edx
 baa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 bb0:	39 ce                	cmp    %ecx,%esi
 bb2:	74 4c                	je     c00 <malloc+0xf0>
        p->s.size -= nunits;
 bb4:	29 f1                	sub    %esi,%ecx
 bb6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 bb9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 bbc:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 bbf:	89 15 fc 10 00 00    	mov    %edx,0x10fc
}
 bc5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 bc8:	83 c0 08             	add    $0x8,%eax
}
 bcb:	5b                   	pop    %ebx
 bcc:	5e                   	pop    %esi
 bcd:	5f                   	pop    %edi
 bce:	5d                   	pop    %ebp
 bcf:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 bd0:	c7 05 fc 10 00 00 00 	movl   $0x1100,0x10fc
 bd7:	11 00 00 
    base.s.size = 0;
 bda:	bf 00 11 00 00       	mov    $0x1100,%edi
    base.s.ptr = freep = prevp = &base;
 bdf:	c7 05 00 11 00 00 00 	movl   $0x1100,0x1100
 be6:	11 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 be9:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 beb:	c7 05 04 11 00 00 00 	movl   $0x0,0x1104
 bf2:	00 00 00 
    if(p->s.size >= nunits){
 bf5:	e9 42 ff ff ff       	jmp    b3c <malloc+0x2c>
 bfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 c00:	8b 08                	mov    (%eax),%ecx
 c02:	89 0a                	mov    %ecx,(%edx)
 c04:	eb b9                	jmp    bbf <malloc+0xaf>
