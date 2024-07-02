
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
  1c:	e8 da 07 00 00       	call   7fb <uptime>
  21:	89 85 54 f2 ff ff    	mov    %eax,-0xdac(%ebp)
    if (argc < 2) {
  27:	83 fe 01             	cmp    $0x1,%esi
  2a:	0f 8e d1 00 00 00    	jle    101 <main+0x101>
        // Print usage message to stderr (fd 2)
        printf(2, "Usage: mdfork <text> [start_index]\n");
        exit();
    }

    char *text = argv[1];
  30:	8b 7b 04             	mov    0x4(%ebx),%edi
    int start_index = 1;

    if (argc == 3) {
  33:	83 fe 03             	cmp    $0x3,%esi
  36:	0f 84 25 01 00 00    	je     161 <main+0x161>
    }

    int pid1, pid2;

    // Create first child process for matrix multiplication
    if ((pid1 = fork()) == 0) {
  3c:	e8 1a 07 00 00       	call   75b <fork>
  41:	85 c0                	test   %eax,%eax
  43:	75 33                	jne    78 <main+0x78>
    int start_index = 1;
  45:	bb 01 00 00 00       	mov    $0x1,%ebx
  4a:	8d b5 64 fb ff ff    	lea    -0x49c(%ebp),%esi
        // Child process 1: Matrix multiplication
        for (int i = start_index; i <= 50; i++) {
            char filename[20]; // Sufficient buffer size for "fileX.txt" where X is up to 100
            create_filename("file", i, filename);
  50:	83 ec 04             	sub    $0x4,%esp
  53:	56                   	push   %esi
  54:	53                   	push   %ebx
        for (int i = start_index; i <= 50; i++) {
  55:	83 c3 01             	add    $0x1,%ebx
            create_filename("file", i, filename);
  58:	68 48 0c 00 00       	push   $0xc48
  5d:	e8 be 01 00 00       	call   220 <create_filename>

            // Write to the file directly
            write_to_file(filename, text);
  62:	58                   	pop    %eax
  63:	5a                   	pop    %edx
  64:	57                   	push   %edi
  65:	56                   	push   %esi
  66:	e8 f5 02 00 00       	call   360 <write_to_file>
        for (int i = start_index; i <= 50; i++) {
  6b:	83 c4 10             	add    $0x10,%esp
  6e:	83 fb 33             	cmp    $0x33,%ebx
  71:	75 dd                	jne    50 <main+0x50>
        }

        exit();
  73:	e8 eb 06 00 00       	call   763 <exit>
    } else if (pid1 < 0) {
  78:	85 c0                	test   %eax,%eax
  7a:	0f 88 ce 00 00 00    	js     14e <main+0x14e>
        printf(2, "Error: fork failed\n");
        exit();
    }

    // Create second child process for writing to files 
    if ((pid2 = fork()) == 0) {
  80:	e8 d6 06 00 00       	call   75b <fork>
  85:	85 c0                	test   %eax,%eax
  87:	0f 85 87 00 00 00    	jne    114 <main+0x114>

        int A[N][N], B[N][N], C[N][N];
        int i, j;

        // Initialize matrices A and B with some values
        for (i = 0; i < N; i++) {
  8d:	31 c9                	xor    %ecx,%ecx
  8f:	8d b5 5c f2 ff ff    	lea    -0xda4(%ebp),%esi
  95:	c7 85 54 f2 ff ff 00 	movl   $0x0,-0xdac(%ebp)
  9c:	00 00 00 
  9f:	8d bd e0 f6 ff ff    	lea    -0x920(%ebp),%edi
  a5:	8d 76 00             	lea    0x0(%esi),%esi
    int start_index = 1;
  a8:	8b 95 54 f2 ff ff    	mov    -0xdac(%ebp),%edx
            for (j = 0; j < N; j++) {
  ae:	31 c0                	xor    %eax,%eax
                A[i][j] = i + j;
  b0:	8d 1c 08             	lea    (%eax,%ecx,1),%ebx
  b3:	89 1c 16             	mov    %ebx,(%esi,%edx,1)
                B[i][j] = i - j;
  b6:	89 cb                	mov    %ecx,%ebx
  b8:	29 c3                	sub    %eax,%ebx
            for (j = 0; j < N; j++) {
  ba:	83 c0 01             	add    $0x1,%eax
                B[i][j] = i - j;
  bd:	89 1c 17             	mov    %ebx,(%edi,%edx,1)
            for (j = 0; j < N; j++) {
  c0:	83 c2 04             	add    $0x4,%edx
  c3:	83 f8 11             	cmp    $0x11,%eax
  c6:	75 e8                	jne    b0 <main+0xb0>
        for (i = 0; i < N; i++) {
  c8:	83 c1 01             	add    $0x1,%ecx
  cb:	83 85 54 f2 ff ff 44 	addl   $0x44,-0xdac(%ebp)
  d2:	83 f9 11             	cmp    $0x11,%ecx
  d5:	75 d1                	jne    a8 <main+0xa8>
            }
        }

        // Perform matrix multiplication
        matrix_multiply(A, B, C);
  d7:	8d 9d 64 fb ff ff    	lea    -0x49c(%ebp),%ebx
  dd:	52                   	push   %edx
  de:	53                   	push   %ebx
  df:	57                   	push   %edi
  e0:	56                   	push   %esi
  e1:	e8 3a 03 00 00       	call   420 <matrix_multiply>

        // Print the result
        printf(1, "Matrix C:\n");
  e6:	59                   	pop    %ecx
  e7:	5e                   	pop    %esi
  e8:	68 61 0c 00 00       	push   $0xc61
  ed:	6a 01                	push   $0x1
  ef:	e8 dc 07 00 00       	call   8d0 <printf>
        print_matrix(C);
  f4:	89 1c 24             	mov    %ebx,(%esp)
  f7:	e8 b4 03 00 00       	call   4b0 <print_matrix>

        exit();
  fc:	e8 62 06 00 00       	call   763 <exit>
        printf(2, "Usage: mdfork <text> [start_index]\n");
 101:	51                   	push   %ecx
 102:	51                   	push   %ecx
 103:	68 84 0c 00 00       	push   $0xc84
 108:	6a 02                	push   $0x2
 10a:	e8 c1 07 00 00       	call   8d0 <printf>
        exit();
 10f:	e8 4f 06 00 00       	call   763 <exit>


    } else if (pid2 < 0) {
 114:	78 38                	js     14e <main+0x14e>
        printf(2, "Error: fork failed\n");
        exit();
    }

    // Parent process: Wait for both children to finish
    wait();
 116:	e8 50 06 00 00       	call   76b <wait>
    wait();
 11b:	e8 4b 06 00 00       	call   76b <wait>

    printf(1, "Both child processes completed\n");
 120:	50                   	push   %eax
 121:	50                   	push   %eax
 122:	68 a8 0c 00 00       	push   $0xca8
 127:	6a 01                	push   $0x1
 129:	e8 a2 07 00 00       	call   8d0 <printf>
    end_time = uptime();
 12e:	e8 c8 06 00 00       	call   7fb <uptime>
    printf(1, "Time taken: %d ticks\n", end_time - start_time);
 133:	83 c4 0c             	add    $0xc,%esp
 136:	2b 85 54 f2 ff ff    	sub    -0xdac(%ebp),%eax
 13c:	50                   	push   %eax
 13d:	68 6c 0c 00 00       	push   $0xc6c
 142:	6a 01                	push   $0x1
 144:	e8 87 07 00 00       	call   8d0 <printf>
    exit();
 149:	e8 15 06 00 00       	call   763 <exit>
        printf(2, "Error: fork failed\n");
 14e:	57                   	push   %edi
 14f:	57                   	push   %edi
 150:	68 4d 0c 00 00       	push   $0xc4d
 155:	6a 02                	push   $0x2
 157:	e8 74 07 00 00       	call   8d0 <printf>
        exit();
 15c:	e8 02 06 00 00       	call   763 <exit>
        start_index = atoi(argv[2]);
 161:	83 ec 0c             	sub    $0xc,%esp
 164:	ff 73 08             	push   0x8(%ebx)
 167:	e8 84 05 00 00       	call   6f0 <atoi>
 16c:	89 c3                	mov    %eax,%ebx
    if ((pid1 = fork()) == 0) {
 16e:	e8 e8 05 00 00       	call   75b <fork>
 173:	83 c4 10             	add    $0x10,%esp
 176:	85 c0                	test   %eax,%eax
 178:	0f 85 fa fe ff ff    	jne    78 <main+0x78>
        for (int i = start_index; i <= 50; i++) {
 17e:	83 fb 32             	cmp    $0x32,%ebx
 181:	0f 8e c3 fe ff ff    	jle    4a <main+0x4a>
 187:	e9 e7 fe ff ff       	jmp    73 <main+0x73>
 18c:	66 90                	xchg   %ax,%ax
 18e:	66 90                	xchg   %ax,%ax

00000190 <int_to_str>:
void int_to_str(int n, char *str) {
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	57                   	push   %edi
 194:	8b 4d 08             	mov    0x8(%ebp),%ecx
 197:	56                   	push   %esi
 198:	53                   	push   %ebx
    if (n == 0) {
 199:	85 c9                	test   %ecx,%ecx
 19b:	74 63                	je     200 <int_to_str+0x70>
    while (temp_n > 0) {
 19d:	89 ca                	mov    %ecx,%edx
    int len = 0;
 19f:	be 00 00 00 00       	mov    $0x0,%esi
    while (temp_n > 0) {
 1a4:	7e 6a                	jle    210 <int_to_str+0x80>
 1a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1ad:	8d 76 00             	lea    0x0(%esi),%esi
        temp_n /= 10;
 1b0:	b8 cd cc cc cc       	mov    $0xcccccccd,%eax
 1b5:	89 d7                	mov    %edx,%edi
 1b7:	89 f3                	mov    %esi,%ebx
        len++;
 1b9:	83 c6 01             	add    $0x1,%esi
        temp_n /= 10;
 1bc:	f7 e2                	mul    %edx
 1be:	c1 ea 03             	shr    $0x3,%edx
    while (temp_n > 0) {
 1c1:	83 ff 09             	cmp    $0x9,%edi
 1c4:	7f ea                	jg     1b0 <int_to_str+0x20>
    str[len] = '\0';
 1c6:	8b 45 0c             	mov    0xc(%ebp),%eax
 1c9:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
    while (n > 0) {
 1cd:	01 c3                	add    %eax,%ebx
        str[--len] = (n % 10) + '0';
 1cf:	be cd cc cc cc       	mov    $0xcccccccd,%esi
 1d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1d8:	89 c8                	mov    %ecx,%eax
    while (n > 0) {
 1da:	83 eb 01             	sub    $0x1,%ebx
        str[--len] = (n % 10) + '0';
 1dd:	f7 e6                	mul    %esi
 1df:	89 c8                	mov    %ecx,%eax
 1e1:	c1 ea 03             	shr    $0x3,%edx
 1e4:	8d 3c 92             	lea    (%edx,%edx,4),%edi
 1e7:	01 ff                	add    %edi,%edi
 1e9:	29 f8                	sub    %edi,%eax
 1eb:	83 c0 30             	add    $0x30,%eax
 1ee:	88 43 01             	mov    %al,0x1(%ebx)
        n /= 10;
 1f1:	89 c8                	mov    %ecx,%eax
 1f3:	89 d1                	mov    %edx,%ecx
    while (n > 0) {
 1f5:	83 f8 09             	cmp    $0x9,%eax
 1f8:	7f de                	jg     1d8 <int_to_str+0x48>
}
 1fa:	5b                   	pop    %ebx
 1fb:	5e                   	pop    %esi
 1fc:	5f                   	pop    %edi
 1fd:	5d                   	pop    %ebp
 1fe:	c3                   	ret    
 1ff:	90                   	nop
        str[0] = '0';
 200:	8b 45 0c             	mov    0xc(%ebp),%eax
 203:	ba 30 00 00 00       	mov    $0x30,%edx
 208:	66 89 10             	mov    %dx,(%eax)
}
 20b:	5b                   	pop    %ebx
 20c:	5e                   	pop    %esi
 20d:	5f                   	pop    %edi
 20e:	5d                   	pop    %ebp
 20f:	c3                   	ret    
    str[len] = '\0';
 210:	8b 45 0c             	mov    0xc(%ebp),%eax
 213:	c6 00 00             	movb   $0x0,(%eax)
    while (n > 0) {
 216:	eb e2                	jmp    1fa <int_to_str+0x6a>
 218:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 21f:	90                   	nop

00000220 <create_filename>:
void create_filename(char *base, int num, char *filename) {
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	57                   	push   %edi
 224:	56                   	push   %esi
 225:	53                   	push   %ebx
 226:	83 ec 1c             	sub    $0x1c,%esp
 229:	8b 75 08             	mov    0x8(%ebp),%esi
 22c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    while (base[i] != '\0') {
 22f:	0f b6 06             	movzbl (%esi),%eax
 232:	84 c0                	test   %al,%al
 234:	0f 84 06 01 00 00    	je     340 <create_filename+0x120>
    int i = 0;
 23a:	8b 7d 10             	mov    0x10(%ebp),%edi
 23d:	31 c9                	xor    %ecx,%ecx
 23f:	90                   	nop
        filename[i] = base[i];
 240:	88 04 0f             	mov    %al,(%edi,%ecx,1)
        i++;
 243:	89 ca                	mov    %ecx,%edx
 245:	83 c1 01             	add    $0x1,%ecx
    while (base[i] != '\0') {
 248:	0f b6 04 0e          	movzbl (%esi,%ecx,1),%eax
 24c:	84 c0                	test   %al,%al
 24e:	75 f0                	jne    240 <create_filename+0x20>
    filename[i++] = '.';
 250:	8b 45 10             	mov    0x10(%ebp),%eax
 253:	01 c8                	add    %ecx,%eax
 255:	89 45 e0             	mov    %eax,-0x20(%ebp)
 258:	8d 42 02             	lea    0x2(%edx),%eax
 25b:	89 45 dc             	mov    %eax,-0x24(%ebp)
    if (n == 0) {
 25e:	85 db                	test   %ebx,%ebx
 260:	0f 84 ca 00 00 00    	je     330 <create_filename+0x110>
    while (temp_n > 0) {
 266:	89 da                	mov    %ebx,%edx
    int len = 0;
 268:	be 00 00 00 00       	mov    $0x0,%esi
    while (temp_n > 0) {
 26d:	0f 8e 95 00 00 00    	jle    308 <create_filename+0xe8>
 273:	89 4d d8             	mov    %ecx,-0x28(%ebp)
 276:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 27d:	8d 76 00             	lea    0x0(%esi),%esi
        temp_n /= 10;
 280:	b8 cd cc cc cc       	mov    $0xcccccccd,%eax
 285:	89 d1                	mov    %edx,%ecx
 287:	89 f7                	mov    %esi,%edi
        len++;
 289:	83 c6 01             	add    $0x1,%esi
        temp_n /= 10;
 28c:	f7 e2                	mul    %edx
 28e:	c1 ea 03             	shr    $0x3,%edx
    while (temp_n > 0) {
 291:	83 f9 09             	cmp    $0x9,%ecx
 294:	7f ea                	jg     280 <create_filename+0x60>
    str[len] = '\0';
 296:	c6 44 35 ea 00       	movb   $0x0,-0x16(%ebp,%esi,1)
 29b:	8b 4d d8             	mov    -0x28(%ebp),%ecx
    while (n > 0) {
 29e:	8d 75 ea             	lea    -0x16(%ebp),%esi
 2a1:	01 fe                	add    %edi,%esi
 2a3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2a7:	90                   	nop
        str[--len] = (n % 10) + '0';
 2a8:	b8 cd cc cc cc       	mov    $0xcccccccd,%eax
    while (n > 0) {
 2ad:	83 ee 01             	sub    $0x1,%esi
        str[--len] = (n % 10) + '0';
 2b0:	f7 e3                	mul    %ebx
 2b2:	89 d8                	mov    %ebx,%eax
 2b4:	c1 ea 03             	shr    $0x3,%edx
 2b7:	8d 3c 92             	lea    (%edx,%edx,4),%edi
 2ba:	01 ff                	add    %edi,%edi
 2bc:	29 f8                	sub    %edi,%eax
 2be:	83 c0 30             	add    $0x30,%eax
 2c1:	88 46 01             	mov    %al,0x1(%esi)
        n /= 10;
 2c4:	89 d8                	mov    %ebx,%eax
 2c6:	89 d3                	mov    %edx,%ebx
    while (n > 0) {
 2c8:	83 f8 09             	cmp    $0x9,%eax
 2cb:	7f db                	jg     2a8 <create_filename+0x88>
    while (num_str[j] != '\0') {
 2cd:	0f b6 55 ea          	movzbl -0x16(%ebp),%edx
 2d1:	8d 5d ea             	lea    -0x16(%ebp),%ebx
 2d4:	0f b6 45 eb          	movzbl -0x15(%ebp),%eax
 2d8:	8b 75 10             	mov    0x10(%ebp),%esi
 2db:	29 cb                	sub    %ecx,%ebx
 2dd:	84 d2                	test   %dl,%dl
 2df:	75 0e                	jne    2ef <create_filename+0xcf>
 2e1:	eb 25                	jmp    308 <create_filename+0xe8>
 2e3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2e7:	90                   	nop
 2e8:	89 c2                	mov    %eax,%edx
 2ea:	0f b6 44 19 01       	movzbl 0x1(%ecx,%ebx,1),%eax
        filename[i++] = num_str[j++];
 2ef:	83 c1 01             	add    $0x1,%ecx
 2f2:	88 54 0e ff          	mov    %dl,-0x1(%esi,%ecx,1)
    while (num_str[j] != '\0') {
 2f6:	84 c0                	test   %al,%al
 2f8:	75 ee                	jne    2e8 <create_filename+0xc8>
    filename[i++] = '.';
 2fa:	8b 45 10             	mov    0x10(%ebp),%eax
 2fd:	01 c8                	add    %ecx,%eax
 2ff:	89 45 e0             	mov    %eax,-0x20(%ebp)
 302:	8d 41 01             	lea    0x1(%ecx),%eax
 305:	89 45 dc             	mov    %eax,-0x24(%ebp)
 308:	8b 45 e0             	mov    -0x20(%ebp),%eax
    filename[i++] = 't';
 30b:	8b 7d dc             	mov    -0x24(%ebp),%edi
    filename[i++] = '.';
 30e:	c6 00 2e             	movb   $0x2e,(%eax)
    filename[i++] = 't';
 311:	8b 45 10             	mov    0x10(%ebp),%eax
 314:	c6 04 38 74          	movb   $0x74,(%eax,%edi,1)
    filename[i++] = 'x';
 318:	c6 44 08 02 78       	movb   $0x78,0x2(%eax,%ecx,1)
    filename[i++] = 't';
 31d:	c6 44 08 03 74       	movb   $0x74,0x3(%eax,%ecx,1)
    filename[i] = '\0'; // Null-terminate the string
 322:	c6 44 08 04 00       	movb   $0x0,0x4(%eax,%ecx,1)
}
 327:	83 c4 1c             	add    $0x1c,%esp
 32a:	5b                   	pop    %ebx
 32b:	5e                   	pop    %esi
 32c:	5f                   	pop    %edi
 32d:	5d                   	pop    %ebp
 32e:	c3                   	ret    
 32f:	90                   	nop
        filename[i++] = num_str[j++];
 330:	8b 45 10             	mov    0x10(%ebp),%eax
 333:	83 c1 01             	add    $0x1,%ecx
 336:	c6 44 08 ff 30       	movb   $0x30,-0x1(%eax,%ecx,1)
    while (num_str[j] != '\0') {
 33b:	eb bd                	jmp    2fa <create_filename+0xda>
 33d:	8d 76 00             	lea    0x0(%esi),%esi
    while (base[i] != '\0') {
 340:	8b 45 10             	mov    0x10(%ebp),%eax
 343:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
    int i = 0;
 34a:	31 c9                	xor    %ecx,%ecx
    while (base[i] != '\0') {
 34c:	89 45 e0             	mov    %eax,-0x20(%ebp)
 34f:	e9 0a ff ff ff       	jmp    25e <create_filename+0x3e>
 354:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 35b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 35f:	90                   	nop

00000360 <write_to_file>:
void write_to_file(char *filename, char *text) {
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	57                   	push   %edi
 364:	56                   	push   %esi
 365:	53                   	push   %ebx
 366:	83 ec 28             	sub    $0x28,%esp
 369:	8b 55 0c             	mov    0xc(%ebp),%edx
 36c:	8b 7d 08             	mov    0x8(%ebp),%edi
    int n = strlen(text);
 36f:	52                   	push   %edx
 370:	89 55 e4             	mov    %edx,-0x1c(%ebp)
 373:	e8 28 02 00 00       	call   5a0 <strlen>
 378:	89 c6                	mov    %eax,%esi
    fd = open(filename, O_WRONLY | O_CREATE);
 37a:	58                   	pop    %eax
 37b:	5a                   	pop    %edx
 37c:	68 01 02 00 00       	push   $0x201
 381:	57                   	push   %edi
 382:	e8 1c 04 00 00       	call   7a3 <open>
    if (fd < 0) {
 387:	83 c4 10             	add    $0x10,%esp
 38a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 38d:	85 c0                	test   %eax,%eax
 38f:	78 67                	js     3f8 <write_to_file+0x98>
    if (write(fd, text, n) != n) {
 391:	83 ec 04             	sub    $0x4,%esp
 394:	89 c3                	mov    %eax,%ebx
 396:	56                   	push   %esi
 397:	52                   	push   %edx
 398:	50                   	push   %eax
 399:	e8 e5 03 00 00       	call   783 <write>
 39e:	83 c4 10             	add    $0x10,%esp
 3a1:	39 f0                	cmp    %esi,%eax
 3a3:	75 2b                	jne    3d0 <write_to_file+0x70>
    close(fd);
 3a5:	83 ec 0c             	sub    $0xc,%esp
 3a8:	53                   	push   %ebx
 3a9:	e8 dd 03 00 00       	call   78b <close>
    printf(1, "Successfully wrote to %s\n", filename); // Debugging print
 3ae:	83 c4 0c             	add    $0xc,%esp
 3b1:	57                   	push   %edi
 3b2:	68 2a 0c 00 00       	push   $0xc2a
 3b7:	6a 01                	push   $0x1
 3b9:	e8 12 05 00 00       	call   8d0 <printf>
 3be:	83 c4 10             	add    $0x10,%esp
}
 3c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3c4:	5b                   	pop    %ebx
 3c5:	5e                   	pop    %esi
 3c6:	5f                   	pop    %edi
 3c7:	5d                   	pop    %ebp
 3c8:	c3                   	ret    
 3c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printf(2, "Error: write error for %s\n", filename);
 3d0:	83 ec 04             	sub    $0x4,%esp
 3d3:	57                   	push   %edi
 3d4:	68 0f 0c 00 00       	push   $0xc0f
 3d9:	6a 02                	push   $0x2
 3db:	e8 f0 04 00 00       	call   8d0 <printf>
        close(fd);
 3e0:	89 5d 08             	mov    %ebx,0x8(%ebp)
 3e3:	83 c4 10             	add    $0x10,%esp
}
 3e6:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3e9:	5b                   	pop    %ebx
 3ea:	5e                   	pop    %esi
 3eb:	5f                   	pop    %edi
 3ec:	5d                   	pop    %ebp
        close(fd);
 3ed:	e9 99 03 00 00       	jmp    78b <close>
 3f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printf(2, "Error: cannot open %s\n", filename);
 3f8:	83 ec 04             	sub    $0x4,%esp
 3fb:	57                   	push   %edi
 3fc:	68 f8 0b 00 00       	push   $0xbf8
 401:	6a 02                	push   $0x2
 403:	e8 c8 04 00 00       	call   8d0 <printf>
        return;
 408:	83 c4 10             	add    $0x10,%esp
}
 40b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 40e:	5b                   	pop    %ebx
 40f:	5e                   	pop    %esi
 410:	5f                   	pop    %edi
 411:	5d                   	pop    %ebp
 412:	c3                   	ret    
 413:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 41a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000420 <matrix_multiply>:
void matrix_multiply(int A[N][N], int B[N][N], int C[N][N]) {
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	57                   	push   %edi
 424:	56                   	push   %esi
 425:	53                   	push   %ebx
 426:	83 ec 14             	sub    $0x14,%esp
 429:	8b 7d 08             	mov    0x8(%ebp),%edi
 42c:	8b 45 0c             	mov    0xc(%ebp),%eax
 42f:	8b 75 10             	mov    0x10(%ebp),%esi
 432:	89 7d f0             	mov    %edi,-0x10(%ebp)
 435:	81 c7 84 04 00 00    	add    $0x484,%edi
 43b:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 43e:	8d b8 84 04 00 00    	lea    0x484(%eax),%edi
 444:	05 c8 04 00 00       	add    $0x4c8,%eax
 449:	89 75 e8             	mov    %esi,-0x18(%ebp)
 44c:	89 7d e0             	mov    %edi,-0x20(%ebp)
 44f:	89 45 ec             	mov    %eax,-0x14(%ebp)
        for (j = 0; j < N; j++) {
 452:	8b 7d e0             	mov    -0x20(%ebp),%edi
void matrix_multiply(int A[N][N], int B[N][N], int C[N][N]) {
 455:	8b 75 e8             	mov    -0x18(%ebp),%esi
 458:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 45f:	90                   	nop
            C[i][j] = 0;
 460:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
 466:	8b 5d f0             	mov    -0x10(%ebp),%ebx
 469:	8d 87 7c fb ff ff    	lea    -0x484(%edi),%eax
 46f:	31 c9                	xor    %ecx,%ecx
 471:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
                C[i][j] += A[i][k] * B[k][j];
 478:	8b 13                	mov    (%ebx),%edx
 47a:	0f af 10             	imul   (%eax),%edx
            for (k = 0; k < N; k++) {
 47d:	83 c0 44             	add    $0x44,%eax
 480:	83 c3 04             	add    $0x4,%ebx
                C[i][j] += A[i][k] * B[k][j];
 483:	01 d1                	add    %edx,%ecx
 485:	89 0e                	mov    %ecx,(%esi)
            for (k = 0; k < N; k++) {
 487:	39 f8                	cmp    %edi,%eax
 489:	75 ed                	jne    478 <matrix_multiply+0x58>
        for (j = 0; j < N; j++) {
 48b:	83 c6 04             	add    $0x4,%esi
 48e:	8d 78 04             	lea    0x4(%eax),%edi
 491:	3b 7d ec             	cmp    -0x14(%ebp),%edi
 494:	75 ca                	jne    460 <matrix_multiply+0x40>
    for (i = 0; i < N; i++) {
 496:	83 45 f0 44          	addl   $0x44,-0x10(%ebp)
 49a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 49d:	83 45 e8 44          	addl   $0x44,-0x18(%ebp)
 4a1:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
 4a4:	75 ac                	jne    452 <matrix_multiply+0x32>
}
 4a6:	83 c4 14             	add    $0x14,%esp
 4a9:	5b                   	pop    %ebx
 4aa:	5e                   	pop    %esi
 4ab:	5f                   	pop    %edi
 4ac:	5d                   	pop    %ebp
 4ad:	c3                   	ret    
 4ae:	66 90                	xchg   %ax,%ax

000004b0 <print_matrix>:
void print_matrix(int matrix[N][N]) {
 4b0:	55                   	push   %ebp
 4b1:	89 e5                	mov    %esp,%ebp
 4b3:	57                   	push   %edi
 4b4:	56                   	push   %esi
 4b5:	53                   	push   %ebx
 4b6:	83 ec 0c             	sub    $0xc,%esp
 4b9:	8b 7d 08             	mov    0x8(%ebp),%edi
 4bc:	8d 77 44             	lea    0x44(%edi),%esi
 4bf:	81 c7 c8 04 00 00    	add    $0x4c8,%edi
 4c5:	8d 76 00             	lea    0x0(%esi),%esi
        for (j = 0; j < N; j++) {
 4c8:	8d 5e bc             	lea    -0x44(%esi),%ebx
 4cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4cf:	90                   	nop
            printf(1, "%d ", matrix[i][j]);
 4d0:	83 ec 04             	sub    $0x4,%esp
 4d3:	ff 33                	push   (%ebx)
        for (j = 0; j < N; j++) {
 4d5:	83 c3 04             	add    $0x4,%ebx
            printf(1, "%d ", matrix[i][j]);
 4d8:	68 44 0c 00 00       	push   $0xc44
 4dd:	6a 01                	push   $0x1
 4df:	e8 ec 03 00 00       	call   8d0 <printf>
        for (j = 0; j < N; j++) {
 4e4:	83 c4 10             	add    $0x10,%esp
 4e7:	39 f3                	cmp    %esi,%ebx
 4e9:	75 e5                	jne    4d0 <print_matrix+0x20>
        printf(1, "\n");
 4eb:	83 ec 08             	sub    $0x8,%esp
    for (i = 0; i < N; i++) {
 4ee:	8d 73 44             	lea    0x44(%ebx),%esi
        printf(1, "\n");
 4f1:	68 6a 0c 00 00       	push   $0xc6a
 4f6:	6a 01                	push   $0x1
 4f8:	e8 d3 03 00 00       	call   8d0 <printf>
    for (i = 0; i < N; i++) {
 4fd:	83 c4 10             	add    $0x10,%esp
 500:	39 fe                	cmp    %edi,%esi
 502:	75 c4                	jne    4c8 <print_matrix+0x18>
}
 504:	8d 65 f4             	lea    -0xc(%ebp),%esp
 507:	5b                   	pop    %ebx
 508:	5e                   	pop    %esi
 509:	5f                   	pop    %edi
 50a:	5d                   	pop    %ebp
 50b:	c3                   	ret    
 50c:	66 90                	xchg   %ax,%ax
 50e:	66 90                	xchg   %ax,%ax

00000510 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 510:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 511:	31 c0                	xor    %eax,%eax
{
 513:	89 e5                	mov    %esp,%ebp
 515:	53                   	push   %ebx
 516:	8b 4d 08             	mov    0x8(%ebp),%ecx
 519:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 51c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 520:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 524:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 527:	83 c0 01             	add    $0x1,%eax
 52a:	84 d2                	test   %dl,%dl
 52c:	75 f2                	jne    520 <strcpy+0x10>
    ;
  return os;
}
 52e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 531:	89 c8                	mov    %ecx,%eax
 533:	c9                   	leave  
 534:	c3                   	ret    
 535:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 53c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000540 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 540:	55                   	push   %ebp
 541:	89 e5                	mov    %esp,%ebp
 543:	53                   	push   %ebx
 544:	8b 55 08             	mov    0x8(%ebp),%edx
 547:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 54a:	0f b6 02             	movzbl (%edx),%eax
 54d:	84 c0                	test   %al,%al
 54f:	75 17                	jne    568 <strcmp+0x28>
 551:	eb 3a                	jmp    58d <strcmp+0x4d>
 553:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 557:	90                   	nop
 558:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 55c:	83 c2 01             	add    $0x1,%edx
 55f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 562:	84 c0                	test   %al,%al
 564:	74 1a                	je     580 <strcmp+0x40>
    p++, q++;
 566:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
 568:	0f b6 19             	movzbl (%ecx),%ebx
 56b:	38 c3                	cmp    %al,%bl
 56d:	74 e9                	je     558 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 56f:	29 d8                	sub    %ebx,%eax
}
 571:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 574:	c9                   	leave  
 575:	c3                   	ret    
 576:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 57d:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 580:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 584:	31 c0                	xor    %eax,%eax
 586:	29 d8                	sub    %ebx,%eax
}
 588:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 58b:	c9                   	leave  
 58c:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
 58d:	0f b6 19             	movzbl (%ecx),%ebx
 590:	31 c0                	xor    %eax,%eax
 592:	eb db                	jmp    56f <strcmp+0x2f>
 594:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 59b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 59f:	90                   	nop

000005a0 <strlen>:

uint
strlen(const char *s)
{
 5a0:	55                   	push   %ebp
 5a1:	89 e5                	mov    %esp,%ebp
 5a3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 5a6:	80 3a 00             	cmpb   $0x0,(%edx)
 5a9:	74 15                	je     5c0 <strlen+0x20>
 5ab:	31 c0                	xor    %eax,%eax
 5ad:	8d 76 00             	lea    0x0(%esi),%esi
 5b0:	83 c0 01             	add    $0x1,%eax
 5b3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 5b7:	89 c1                	mov    %eax,%ecx
 5b9:	75 f5                	jne    5b0 <strlen+0x10>
    ;
  return n;
}
 5bb:	89 c8                	mov    %ecx,%eax
 5bd:	5d                   	pop    %ebp
 5be:	c3                   	ret    
 5bf:	90                   	nop
  for(n = 0; s[n]; n++)
 5c0:	31 c9                	xor    %ecx,%ecx
}
 5c2:	5d                   	pop    %ebp
 5c3:	89 c8                	mov    %ecx,%eax
 5c5:	c3                   	ret    
 5c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5cd:	8d 76 00             	lea    0x0(%esi),%esi

000005d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 5d0:	55                   	push   %ebp
 5d1:	89 e5                	mov    %esp,%ebp
 5d3:	57                   	push   %edi
 5d4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 5d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 5da:	8b 45 0c             	mov    0xc(%ebp),%eax
 5dd:	89 d7                	mov    %edx,%edi
 5df:	fc                   	cld    
 5e0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 5e2:	8b 7d fc             	mov    -0x4(%ebp),%edi
 5e5:	89 d0                	mov    %edx,%eax
 5e7:	c9                   	leave  
 5e8:	c3                   	ret    
 5e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000005f0 <strchr>:

char*
strchr(const char *s, char c)
{
 5f0:	55                   	push   %ebp
 5f1:	89 e5                	mov    %esp,%ebp
 5f3:	8b 45 08             	mov    0x8(%ebp),%eax
 5f6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 5fa:	0f b6 10             	movzbl (%eax),%edx
 5fd:	84 d2                	test   %dl,%dl
 5ff:	75 12                	jne    613 <strchr+0x23>
 601:	eb 1d                	jmp    620 <strchr+0x30>
 603:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 607:	90                   	nop
 608:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 60c:	83 c0 01             	add    $0x1,%eax
 60f:	84 d2                	test   %dl,%dl
 611:	74 0d                	je     620 <strchr+0x30>
    if(*s == c)
 613:	38 d1                	cmp    %dl,%cl
 615:	75 f1                	jne    608 <strchr+0x18>
      return (char*)s;
  return 0;
}
 617:	5d                   	pop    %ebp
 618:	c3                   	ret    
 619:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 620:	31 c0                	xor    %eax,%eax
}
 622:	5d                   	pop    %ebp
 623:	c3                   	ret    
 624:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 62b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 62f:	90                   	nop

00000630 <gets>:

char*
gets(char *buf, int max)
{
 630:	55                   	push   %ebp
 631:	89 e5                	mov    %esp,%ebp
 633:	57                   	push   %edi
 634:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 635:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 638:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 639:	31 db                	xor    %ebx,%ebx
{
 63b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 63e:	eb 27                	jmp    667 <gets+0x37>
    cc = read(0, &c, 1);
 640:	83 ec 04             	sub    $0x4,%esp
 643:	6a 01                	push   $0x1
 645:	57                   	push   %edi
 646:	6a 00                	push   $0x0
 648:	e8 2e 01 00 00       	call   77b <read>
    if(cc < 1)
 64d:	83 c4 10             	add    $0x10,%esp
 650:	85 c0                	test   %eax,%eax
 652:	7e 1d                	jle    671 <gets+0x41>
      break;
    buf[i++] = c;
 654:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 658:	8b 55 08             	mov    0x8(%ebp),%edx
 65b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 65f:	3c 0a                	cmp    $0xa,%al
 661:	74 1d                	je     680 <gets+0x50>
 663:	3c 0d                	cmp    $0xd,%al
 665:	74 19                	je     680 <gets+0x50>
  for(i=0; i+1 < max; ){
 667:	89 de                	mov    %ebx,%esi
 669:	83 c3 01             	add    $0x1,%ebx
 66c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 66f:	7c cf                	jl     640 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 671:	8b 45 08             	mov    0x8(%ebp),%eax
 674:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 678:	8d 65 f4             	lea    -0xc(%ebp),%esp
 67b:	5b                   	pop    %ebx
 67c:	5e                   	pop    %esi
 67d:	5f                   	pop    %edi
 67e:	5d                   	pop    %ebp
 67f:	c3                   	ret    
  buf[i] = '\0';
 680:	8b 45 08             	mov    0x8(%ebp),%eax
 683:	89 de                	mov    %ebx,%esi
 685:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 689:	8d 65 f4             	lea    -0xc(%ebp),%esp
 68c:	5b                   	pop    %ebx
 68d:	5e                   	pop    %esi
 68e:	5f                   	pop    %edi
 68f:	5d                   	pop    %ebp
 690:	c3                   	ret    
 691:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 698:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 69f:	90                   	nop

000006a0 <stat>:

int
stat(const char *n, struct stat *st)
{
 6a0:	55                   	push   %ebp
 6a1:	89 e5                	mov    %esp,%ebp
 6a3:	56                   	push   %esi
 6a4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 6a5:	83 ec 08             	sub    $0x8,%esp
 6a8:	6a 00                	push   $0x0
 6aa:	ff 75 08             	push   0x8(%ebp)
 6ad:	e8 f1 00 00 00       	call   7a3 <open>
  if(fd < 0)
 6b2:	83 c4 10             	add    $0x10,%esp
 6b5:	85 c0                	test   %eax,%eax
 6b7:	78 27                	js     6e0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 6b9:	83 ec 08             	sub    $0x8,%esp
 6bc:	ff 75 0c             	push   0xc(%ebp)
 6bf:	89 c3                	mov    %eax,%ebx
 6c1:	50                   	push   %eax
 6c2:	e8 f4 00 00 00       	call   7bb <fstat>
  close(fd);
 6c7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 6ca:	89 c6                	mov    %eax,%esi
  close(fd);
 6cc:	e8 ba 00 00 00       	call   78b <close>
  return r;
 6d1:	83 c4 10             	add    $0x10,%esp
}
 6d4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 6d7:	89 f0                	mov    %esi,%eax
 6d9:	5b                   	pop    %ebx
 6da:	5e                   	pop    %esi
 6db:	5d                   	pop    %ebp
 6dc:	c3                   	ret    
 6dd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 6e0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 6e5:	eb ed                	jmp    6d4 <stat+0x34>
 6e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6ee:	66 90                	xchg   %ax,%ax

000006f0 <atoi>:

int
atoi(const char *s)
{
 6f0:	55                   	push   %ebp
 6f1:	89 e5                	mov    %esp,%ebp
 6f3:	53                   	push   %ebx
 6f4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 6f7:	0f be 02             	movsbl (%edx),%eax
 6fa:	8d 48 d0             	lea    -0x30(%eax),%ecx
 6fd:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 700:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 705:	77 1e                	ja     725 <atoi+0x35>
 707:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 70e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 710:	83 c2 01             	add    $0x1,%edx
 713:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 716:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 71a:	0f be 02             	movsbl (%edx),%eax
 71d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 720:	80 fb 09             	cmp    $0x9,%bl
 723:	76 eb                	jbe    710 <atoi+0x20>
  return n;
}
 725:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 728:	89 c8                	mov    %ecx,%eax
 72a:	c9                   	leave  
 72b:	c3                   	ret    
 72c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000730 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 730:	55                   	push   %ebp
 731:	89 e5                	mov    %esp,%ebp
 733:	57                   	push   %edi
 734:	8b 45 10             	mov    0x10(%ebp),%eax
 737:	8b 55 08             	mov    0x8(%ebp),%edx
 73a:	56                   	push   %esi
 73b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 73e:	85 c0                	test   %eax,%eax
 740:	7e 13                	jle    755 <memmove+0x25>
 742:	01 d0                	add    %edx,%eax
  dst = vdst;
 744:	89 d7                	mov    %edx,%edi
 746:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 74d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 750:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 751:	39 f8                	cmp    %edi,%eax
 753:	75 fb                	jne    750 <memmove+0x20>
  return vdst;
}
 755:	5e                   	pop    %esi
 756:	89 d0                	mov    %edx,%eax
 758:	5f                   	pop    %edi
 759:	5d                   	pop    %ebp
 75a:	c3                   	ret    

0000075b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 75b:	b8 01 00 00 00       	mov    $0x1,%eax
 760:	cd 40                	int    $0x40
 762:	c3                   	ret    

00000763 <exit>:
SYSCALL(exit)
 763:	b8 02 00 00 00       	mov    $0x2,%eax
 768:	cd 40                	int    $0x40
 76a:	c3                   	ret    

0000076b <wait>:
SYSCALL(wait)
 76b:	b8 03 00 00 00       	mov    $0x3,%eax
 770:	cd 40                	int    $0x40
 772:	c3                   	ret    

00000773 <pipe>:
SYSCALL(pipe)
 773:	b8 04 00 00 00       	mov    $0x4,%eax
 778:	cd 40                	int    $0x40
 77a:	c3                   	ret    

0000077b <read>:
SYSCALL(read)
 77b:	b8 05 00 00 00       	mov    $0x5,%eax
 780:	cd 40                	int    $0x40
 782:	c3                   	ret    

00000783 <write>:
SYSCALL(write)
 783:	b8 10 00 00 00       	mov    $0x10,%eax
 788:	cd 40                	int    $0x40
 78a:	c3                   	ret    

0000078b <close>:
SYSCALL(close)
 78b:	b8 15 00 00 00       	mov    $0x15,%eax
 790:	cd 40                	int    $0x40
 792:	c3                   	ret    

00000793 <kill>:
SYSCALL(kill)
 793:	b8 06 00 00 00       	mov    $0x6,%eax
 798:	cd 40                	int    $0x40
 79a:	c3                   	ret    

0000079b <exec>:
SYSCALL(exec)
 79b:	b8 07 00 00 00       	mov    $0x7,%eax
 7a0:	cd 40                	int    $0x40
 7a2:	c3                   	ret    

000007a3 <open>:
SYSCALL(open)
 7a3:	b8 0f 00 00 00       	mov    $0xf,%eax
 7a8:	cd 40                	int    $0x40
 7aa:	c3                   	ret    

000007ab <mknod>:
SYSCALL(mknod)
 7ab:	b8 11 00 00 00       	mov    $0x11,%eax
 7b0:	cd 40                	int    $0x40
 7b2:	c3                   	ret    

000007b3 <unlink>:
SYSCALL(unlink)
 7b3:	b8 12 00 00 00       	mov    $0x12,%eax
 7b8:	cd 40                	int    $0x40
 7ba:	c3                   	ret    

000007bb <fstat>:
SYSCALL(fstat)
 7bb:	b8 08 00 00 00       	mov    $0x8,%eax
 7c0:	cd 40                	int    $0x40
 7c2:	c3                   	ret    

000007c3 <link>:
SYSCALL(link)
 7c3:	b8 13 00 00 00       	mov    $0x13,%eax
 7c8:	cd 40                	int    $0x40
 7ca:	c3                   	ret    

000007cb <mkdir>:
SYSCALL(mkdir)
 7cb:	b8 14 00 00 00       	mov    $0x14,%eax
 7d0:	cd 40                	int    $0x40
 7d2:	c3                   	ret    

000007d3 <chdir>:
SYSCALL(chdir)
 7d3:	b8 09 00 00 00       	mov    $0x9,%eax
 7d8:	cd 40                	int    $0x40
 7da:	c3                   	ret    

000007db <dup>:
SYSCALL(dup)
 7db:	b8 0a 00 00 00       	mov    $0xa,%eax
 7e0:	cd 40                	int    $0x40
 7e2:	c3                   	ret    

000007e3 <getpid>:
SYSCALL(getpid)
 7e3:	b8 0b 00 00 00       	mov    $0xb,%eax
 7e8:	cd 40                	int    $0x40
 7ea:	c3                   	ret    

000007eb <sbrk>:
SYSCALL(sbrk)
 7eb:	b8 0c 00 00 00       	mov    $0xc,%eax
 7f0:	cd 40                	int    $0x40
 7f2:	c3                   	ret    

000007f3 <sleep>:
SYSCALL(sleep)
 7f3:	b8 0d 00 00 00       	mov    $0xd,%eax
 7f8:	cd 40                	int    $0x40
 7fa:	c3                   	ret    

000007fb <uptime>:
SYSCALL(uptime)
 7fb:	b8 0e 00 00 00       	mov    $0xe,%eax
 800:	cd 40                	int    $0x40
 802:	c3                   	ret    

00000803 <ps>:
SYSCALL(ps)
 803:	b8 16 00 00 00       	mov    $0x16,%eax
 808:	cd 40                	int    $0x40
 80a:	c3                   	ret    

0000080b <sys_ps>:

// usys.S
.globl sys_ps
sys_ps:
    movl SYS_ps, %eax
 80b:	a1 16 00 00 00       	mov    0x16,%eax
    int $64
 810:	cd 40                	int    $0x40
    ret
 812:	c3                   	ret    
 813:	66 90                	xchg   %ax,%ax
 815:	66 90                	xchg   %ax,%ax
 817:	66 90                	xchg   %ax,%ax
 819:	66 90                	xchg   %ax,%ax
 81b:	66 90                	xchg   %ax,%ax
 81d:	66 90                	xchg   %ax,%ax
 81f:	90                   	nop

00000820 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 820:	55                   	push   %ebp
 821:	89 e5                	mov    %esp,%ebp
 823:	57                   	push   %edi
 824:	56                   	push   %esi
 825:	53                   	push   %ebx
 826:	83 ec 3c             	sub    $0x3c,%esp
 829:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 82c:	89 d1                	mov    %edx,%ecx
{
 82e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 831:	85 d2                	test   %edx,%edx
 833:	0f 89 7f 00 00 00    	jns    8b8 <printint+0x98>
 839:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 83d:	74 79                	je     8b8 <printint+0x98>
    neg = 1;
 83f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 846:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 848:	31 db                	xor    %ebx,%ebx
 84a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 84d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 850:	89 c8                	mov    %ecx,%eax
 852:	31 d2                	xor    %edx,%edx
 854:	89 cf                	mov    %ecx,%edi
 856:	f7 75 c4             	divl   -0x3c(%ebp)
 859:	0f b6 92 28 0d 00 00 	movzbl 0xd28(%edx),%edx
 860:	89 45 c0             	mov    %eax,-0x40(%ebp)
 863:	89 d8                	mov    %ebx,%eax
 865:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 868:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 86b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 86e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 871:	76 dd                	jbe    850 <printint+0x30>
  if(neg)
 873:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 876:	85 c9                	test   %ecx,%ecx
 878:	74 0c                	je     886 <printint+0x66>
    buf[i++] = '-';
 87a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 87f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 881:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 886:	8b 7d b8             	mov    -0x48(%ebp),%edi
 889:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 88d:	eb 07                	jmp    896 <printint+0x76>
 88f:	90                   	nop
    putc(fd, buf[i]);
 890:	0f b6 13             	movzbl (%ebx),%edx
 893:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 896:	83 ec 04             	sub    $0x4,%esp
 899:	88 55 d7             	mov    %dl,-0x29(%ebp)
 89c:	6a 01                	push   $0x1
 89e:	56                   	push   %esi
 89f:	57                   	push   %edi
 8a0:	e8 de fe ff ff       	call   783 <write>
  while(--i >= 0)
 8a5:	83 c4 10             	add    $0x10,%esp
 8a8:	39 de                	cmp    %ebx,%esi
 8aa:	75 e4                	jne    890 <printint+0x70>
}
 8ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
 8af:	5b                   	pop    %ebx
 8b0:	5e                   	pop    %esi
 8b1:	5f                   	pop    %edi
 8b2:	5d                   	pop    %ebp
 8b3:	c3                   	ret    
 8b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 8b8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 8bf:	eb 87                	jmp    848 <printint+0x28>
 8c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8cf:	90                   	nop

000008d0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 8d0:	55                   	push   %ebp
 8d1:	89 e5                	mov    %esp,%ebp
 8d3:	57                   	push   %edi
 8d4:	56                   	push   %esi
 8d5:	53                   	push   %ebx
 8d6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 8d9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 8dc:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 8df:	0f b6 13             	movzbl (%ebx),%edx
 8e2:	84 d2                	test   %dl,%dl
 8e4:	74 6a                	je     950 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
 8e6:	8d 45 10             	lea    0x10(%ebp),%eax
 8e9:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 8ec:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 8ef:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
 8f1:	89 45 d0             	mov    %eax,-0x30(%ebp)
 8f4:	eb 36                	jmp    92c <printf+0x5c>
 8f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8fd:	8d 76 00             	lea    0x0(%esi),%esi
 900:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 903:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
 908:	83 f8 25             	cmp    $0x25,%eax
 90b:	74 15                	je     922 <printf+0x52>
  write(fd, &c, 1);
 90d:	83 ec 04             	sub    $0x4,%esp
 910:	88 55 e7             	mov    %dl,-0x19(%ebp)
 913:	6a 01                	push   $0x1
 915:	57                   	push   %edi
 916:	56                   	push   %esi
 917:	e8 67 fe ff ff       	call   783 <write>
 91c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
 91f:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 922:	0f b6 13             	movzbl (%ebx),%edx
 925:	83 c3 01             	add    $0x1,%ebx
 928:	84 d2                	test   %dl,%dl
 92a:	74 24                	je     950 <printf+0x80>
    c = fmt[i] & 0xff;
 92c:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 92f:	85 c9                	test   %ecx,%ecx
 931:	74 cd                	je     900 <printf+0x30>
      }
    } else if(state == '%'){
 933:	83 f9 25             	cmp    $0x25,%ecx
 936:	75 ea                	jne    922 <printf+0x52>
      if(c == 'd'){
 938:	83 f8 25             	cmp    $0x25,%eax
 93b:	0f 84 07 01 00 00    	je     a48 <printf+0x178>
 941:	83 e8 63             	sub    $0x63,%eax
 944:	83 f8 15             	cmp    $0x15,%eax
 947:	77 17                	ja     960 <printf+0x90>
 949:	ff 24 85 d0 0c 00 00 	jmp    *0xcd0(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 950:	8d 65 f4             	lea    -0xc(%ebp),%esp
 953:	5b                   	pop    %ebx
 954:	5e                   	pop    %esi
 955:	5f                   	pop    %edi
 956:	5d                   	pop    %ebp
 957:	c3                   	ret    
 958:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 95f:	90                   	nop
  write(fd, &c, 1);
 960:	83 ec 04             	sub    $0x4,%esp
 963:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 966:	6a 01                	push   $0x1
 968:	57                   	push   %edi
 969:	56                   	push   %esi
 96a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 96e:	e8 10 fe ff ff       	call   783 <write>
        putc(fd, c);
 973:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 977:	83 c4 0c             	add    $0xc,%esp
 97a:	88 55 e7             	mov    %dl,-0x19(%ebp)
 97d:	6a 01                	push   $0x1
 97f:	57                   	push   %edi
 980:	56                   	push   %esi
 981:	e8 fd fd ff ff       	call   783 <write>
        putc(fd, c);
 986:	83 c4 10             	add    $0x10,%esp
      state = 0;
 989:	31 c9                	xor    %ecx,%ecx
 98b:	eb 95                	jmp    922 <printf+0x52>
 98d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 990:	83 ec 0c             	sub    $0xc,%esp
 993:	b9 10 00 00 00       	mov    $0x10,%ecx
 998:	6a 00                	push   $0x0
 99a:	8b 45 d0             	mov    -0x30(%ebp),%eax
 99d:	8b 10                	mov    (%eax),%edx
 99f:	89 f0                	mov    %esi,%eax
 9a1:	e8 7a fe ff ff       	call   820 <printint>
        ap++;
 9a6:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 9aa:	83 c4 10             	add    $0x10,%esp
      state = 0;
 9ad:	31 c9                	xor    %ecx,%ecx
 9af:	e9 6e ff ff ff       	jmp    922 <printf+0x52>
 9b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 9b8:	8b 45 d0             	mov    -0x30(%ebp),%eax
 9bb:	8b 10                	mov    (%eax),%edx
        ap++;
 9bd:	83 c0 04             	add    $0x4,%eax
 9c0:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 9c3:	85 d2                	test   %edx,%edx
 9c5:	0f 84 8d 00 00 00    	je     a58 <printf+0x188>
        while(*s != 0){
 9cb:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
 9ce:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
 9d0:	84 c0                	test   %al,%al
 9d2:	0f 84 4a ff ff ff    	je     922 <printf+0x52>
 9d8:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 9db:	89 d3                	mov    %edx,%ebx
 9dd:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 9e0:	83 ec 04             	sub    $0x4,%esp
          s++;
 9e3:	83 c3 01             	add    $0x1,%ebx
 9e6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 9e9:	6a 01                	push   $0x1
 9eb:	57                   	push   %edi
 9ec:	56                   	push   %esi
 9ed:	e8 91 fd ff ff       	call   783 <write>
        while(*s != 0){
 9f2:	0f b6 03             	movzbl (%ebx),%eax
 9f5:	83 c4 10             	add    $0x10,%esp
 9f8:	84 c0                	test   %al,%al
 9fa:	75 e4                	jne    9e0 <printf+0x110>
      state = 0;
 9fc:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 9ff:	31 c9                	xor    %ecx,%ecx
 a01:	e9 1c ff ff ff       	jmp    922 <printf+0x52>
 a06:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a0d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 a10:	83 ec 0c             	sub    $0xc,%esp
 a13:	b9 0a 00 00 00       	mov    $0xa,%ecx
 a18:	6a 01                	push   $0x1
 a1a:	e9 7b ff ff ff       	jmp    99a <printf+0xca>
 a1f:	90                   	nop
        putc(fd, *ap);
 a20:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
 a23:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 a26:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 a28:	6a 01                	push   $0x1
 a2a:	57                   	push   %edi
 a2b:	56                   	push   %esi
        putc(fd, *ap);
 a2c:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 a2f:	e8 4f fd ff ff       	call   783 <write>
        ap++;
 a34:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 a38:	83 c4 10             	add    $0x10,%esp
      state = 0;
 a3b:	31 c9                	xor    %ecx,%ecx
 a3d:	e9 e0 fe ff ff       	jmp    922 <printf+0x52>
 a42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
 a48:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 a4b:	83 ec 04             	sub    $0x4,%esp
 a4e:	e9 2a ff ff ff       	jmp    97d <printf+0xad>
 a53:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 a57:	90                   	nop
          s = "(null)";
 a58:	ba c8 0c 00 00       	mov    $0xcc8,%edx
        while(*s != 0){
 a5d:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 a60:	b8 28 00 00 00       	mov    $0x28,%eax
 a65:	89 d3                	mov    %edx,%ebx
 a67:	e9 74 ff ff ff       	jmp    9e0 <printf+0x110>
 a6c:	66 90                	xchg   %ax,%ax
 a6e:	66 90                	xchg   %ax,%ax

00000a70 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a70:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a71:	a1 ec 10 00 00       	mov    0x10ec,%eax
{
 a76:	89 e5                	mov    %esp,%ebp
 a78:	57                   	push   %edi
 a79:	56                   	push   %esi
 a7a:	53                   	push   %ebx
 a7b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 a7e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a88:	89 c2                	mov    %eax,%edx
 a8a:	8b 00                	mov    (%eax),%eax
 a8c:	39 ca                	cmp    %ecx,%edx
 a8e:	73 30                	jae    ac0 <free+0x50>
 a90:	39 c1                	cmp    %eax,%ecx
 a92:	72 04                	jb     a98 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a94:	39 c2                	cmp    %eax,%edx
 a96:	72 f0                	jb     a88 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 a98:	8b 73 fc             	mov    -0x4(%ebx),%esi
 a9b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 a9e:	39 f8                	cmp    %edi,%eax
 aa0:	74 30                	je     ad2 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 aa2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 aa5:	8b 42 04             	mov    0x4(%edx),%eax
 aa8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 aab:	39 f1                	cmp    %esi,%ecx
 aad:	74 3a                	je     ae9 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 aaf:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 ab1:	5b                   	pop    %ebx
  freep = p;
 ab2:	89 15 ec 10 00 00    	mov    %edx,0x10ec
}
 ab8:	5e                   	pop    %esi
 ab9:	5f                   	pop    %edi
 aba:	5d                   	pop    %ebp
 abb:	c3                   	ret    
 abc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ac0:	39 c2                	cmp    %eax,%edx
 ac2:	72 c4                	jb     a88 <free+0x18>
 ac4:	39 c1                	cmp    %eax,%ecx
 ac6:	73 c0                	jae    a88 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
 ac8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 acb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 ace:	39 f8                	cmp    %edi,%eax
 ad0:	75 d0                	jne    aa2 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
 ad2:	03 70 04             	add    0x4(%eax),%esi
 ad5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 ad8:	8b 02                	mov    (%edx),%eax
 ada:	8b 00                	mov    (%eax),%eax
 adc:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 adf:	8b 42 04             	mov    0x4(%edx),%eax
 ae2:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 ae5:	39 f1                	cmp    %esi,%ecx
 ae7:	75 c6                	jne    aaf <free+0x3f>
    p->s.size += bp->s.size;
 ae9:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 aec:	89 15 ec 10 00 00    	mov    %edx,0x10ec
    p->s.size += bp->s.size;
 af2:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 af5:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 af8:	89 0a                	mov    %ecx,(%edx)
}
 afa:	5b                   	pop    %ebx
 afb:	5e                   	pop    %esi
 afc:	5f                   	pop    %edi
 afd:	5d                   	pop    %ebp
 afe:	c3                   	ret    
 aff:	90                   	nop

00000b00 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 b00:	55                   	push   %ebp
 b01:	89 e5                	mov    %esp,%ebp
 b03:	57                   	push   %edi
 b04:	56                   	push   %esi
 b05:	53                   	push   %ebx
 b06:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b09:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 b0c:	8b 3d ec 10 00 00    	mov    0x10ec,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b12:	8d 70 07             	lea    0x7(%eax),%esi
 b15:	c1 ee 03             	shr    $0x3,%esi
 b18:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 b1b:	85 ff                	test   %edi,%edi
 b1d:	0f 84 9d 00 00 00    	je     bc0 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b23:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 b25:	8b 4a 04             	mov    0x4(%edx),%ecx
 b28:	39 f1                	cmp    %esi,%ecx
 b2a:	73 6a                	jae    b96 <malloc+0x96>
 b2c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 b31:	39 de                	cmp    %ebx,%esi
 b33:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 b36:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 b3d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 b40:	eb 17                	jmp    b59 <malloc+0x59>
 b42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b48:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 b4a:	8b 48 04             	mov    0x4(%eax),%ecx
 b4d:	39 f1                	cmp    %esi,%ecx
 b4f:	73 4f                	jae    ba0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 b51:	8b 3d ec 10 00 00    	mov    0x10ec,%edi
 b57:	89 c2                	mov    %eax,%edx
 b59:	39 d7                	cmp    %edx,%edi
 b5b:	75 eb                	jne    b48 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 b5d:	83 ec 0c             	sub    $0xc,%esp
 b60:	ff 75 e4             	push   -0x1c(%ebp)
 b63:	e8 83 fc ff ff       	call   7eb <sbrk>
  if(p == (char*)-1)
 b68:	83 c4 10             	add    $0x10,%esp
 b6b:	83 f8 ff             	cmp    $0xffffffff,%eax
 b6e:	74 1c                	je     b8c <malloc+0x8c>
  hp->s.size = nu;
 b70:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 b73:	83 ec 0c             	sub    $0xc,%esp
 b76:	83 c0 08             	add    $0x8,%eax
 b79:	50                   	push   %eax
 b7a:	e8 f1 fe ff ff       	call   a70 <free>
  return freep;
 b7f:	8b 15 ec 10 00 00    	mov    0x10ec,%edx
      if((p = morecore(nunits)) == 0)
 b85:	83 c4 10             	add    $0x10,%esp
 b88:	85 d2                	test   %edx,%edx
 b8a:	75 bc                	jne    b48 <malloc+0x48>
        return 0;
  }
}
 b8c:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 b8f:	31 c0                	xor    %eax,%eax
}
 b91:	5b                   	pop    %ebx
 b92:	5e                   	pop    %esi
 b93:	5f                   	pop    %edi
 b94:	5d                   	pop    %ebp
 b95:	c3                   	ret    
    if(p->s.size >= nunits){
 b96:	89 d0                	mov    %edx,%eax
 b98:	89 fa                	mov    %edi,%edx
 b9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 ba0:	39 ce                	cmp    %ecx,%esi
 ba2:	74 4c                	je     bf0 <malloc+0xf0>
        p->s.size -= nunits;
 ba4:	29 f1                	sub    %esi,%ecx
 ba6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 ba9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 bac:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 baf:	89 15 ec 10 00 00    	mov    %edx,0x10ec
}
 bb5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 bb8:	83 c0 08             	add    $0x8,%eax
}
 bbb:	5b                   	pop    %ebx
 bbc:	5e                   	pop    %esi
 bbd:	5f                   	pop    %edi
 bbe:	5d                   	pop    %ebp
 bbf:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 bc0:	c7 05 ec 10 00 00 f0 	movl   $0x10f0,0x10ec
 bc7:	10 00 00 
    base.s.size = 0;
 bca:	bf f0 10 00 00       	mov    $0x10f0,%edi
    base.s.ptr = freep = prevp = &base;
 bcf:	c7 05 f0 10 00 00 f0 	movl   $0x10f0,0x10f0
 bd6:	10 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bd9:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 bdb:	c7 05 f4 10 00 00 00 	movl   $0x0,0x10f4
 be2:	00 00 00 
    if(p->s.size >= nunits){
 be5:	e9 42 ff ff ff       	jmp    b2c <malloc+0x2c>
 bea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 bf0:	8b 08                	mov    (%eax),%ecx
 bf2:	89 0a                	mov    %ecx,(%edx)
 bf4:	eb b9                	jmp    baf <malloc+0xaf>
