
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
  11:	81 ec 18 03 00 00    	sub    $0x318,%esp
  17:	8b 19                	mov    (%ecx),%ebx
  19:	8b 71 04             	mov    0x4(%ecx),%esi
     int start_time, end_time;
    start_time = uptime();
  1c:	e8 ca 07 00 00       	call   7eb <uptime>
  21:	89 85 e0 fc ff ff    	mov    %eax,-0x320(%ebp)
    if (argc < 2) {
  27:	83 fb 01             	cmp    $0x1,%ebx
  2a:	0f 8e d5 00 00 00    	jle    105 <main+0x105>
        // Print usage message to stderr (fd 2)
        printf(2, "Usage: mdfork <text> [start_index]\n");
        exit();
    }

    char *text = argv[1];
  30:	8b 46 04             	mov    0x4(%esi),%eax
    int start_index = 1;
  33:	bf 01 00 00 00       	mov    $0x1,%edi
    char *text = argv[1];
  38:	89 85 e4 fc ff ff    	mov    %eax,-0x31c(%ebp)

    if (argc == 3) {
  3e:	83 fb 03             	cmp    $0x3,%ebx
  41:	0f 84 1e 01 00 00    	je     165 <main+0x165>
    }

    int pid1, pid2;

    // Create first child process for matrix multiplication
    if ((pid1 = fork()) == 0) {
  47:	e8 ff 06 00 00       	call   74b <fork>
  4c:	85 c0                	test   %eax,%eax
  4e:	75 6a                	jne    ba <main+0xba>
        // Child process 1: Matrix multiplication
        int A[N][N], B[N][N], C[N][N];
        int i, j;

        // Initialize matrices A and B with some values
        for (i = 0; i < N; i++) {
  50:	31 c9                	xor    %ecx,%ecx
  52:	8d b5 e8 fc ff ff    	lea    -0x318(%ebp),%esi
  58:	8d bd e8 fd ff ff    	lea    -0x218(%ebp),%edi
  5e:	66 90                	xchg   %ax,%ax
            for (j = 0; j < N; j++) {
  60:	89 ca                	mov    %ecx,%edx
  62:	31 c0                	xor    %eax,%eax
  64:	c1 e2 05             	shl    $0x5,%edx
  67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  6e:	66 90                	xchg   %ax,%ax
                A[i][j] = i + j;
  70:	8d 1c 08             	lea    (%eax,%ecx,1),%ebx
  73:	89 1c 16             	mov    %ebx,(%esi,%edx,1)
                B[i][j] = i - j;
  76:	89 cb                	mov    %ecx,%ebx
  78:	29 c3                	sub    %eax,%ebx
            for (j = 0; j < N; j++) {
  7a:	83 c0 01             	add    $0x1,%eax
                B[i][j] = i - j;
  7d:	89 1c 17             	mov    %ebx,(%edi,%edx,1)
            for (j = 0; j < N; j++) {
  80:	83 c2 04             	add    $0x4,%edx
  83:	83 f8 08             	cmp    $0x8,%eax
  86:	75 e8                	jne    70 <main+0x70>
        for (i = 0; i < N; i++) {
  88:	83 c1 01             	add    $0x1,%ecx
  8b:	83 f9 08             	cmp    $0x8,%ecx
  8e:	75 d0                	jne    60 <main+0x60>
            }
        }

        // Perform matrix multiplication
        matrix_multiply(A, B, C);
  90:	8d 9d e8 fe ff ff    	lea    -0x118(%ebp),%ebx
  96:	50                   	push   %eax
  97:	53                   	push   %ebx
  98:	57                   	push   %edi
  99:	56                   	push   %esi
  9a:	e8 71 03 00 00       	call   410 <matrix_multiply>

        // Print the result
        printf(1, "Matrix C:\n");
  9f:	58                   	pop    %eax
  a0:	5a                   	pop    %edx
  a1:	68 38 0c 00 00       	push   $0xc38
  a6:	6a 01                	push   $0x1
  a8:	e8 13 08 00 00       	call   8c0 <printf>
        print_matrix(C);
  ad:	89 1c 24             	mov    %ebx,(%esp)
  b0:	e8 eb 03 00 00       	call   4a0 <print_matrix>

        exit();
  b5:	e8 99 06 00 00       	call   753 <exit>
    } else if (pid1 < 0) {
  ba:	0f 88 92 00 00 00    	js     152 <main+0x152>
        printf(2, "Error: fork failed\n");
        exit();
    }

    // Create second child process for writing to files
    if ((pid2 = fork()) == 0) {
  c0:	e8 86 06 00 00       	call   74b <fork>
  c5:	85 c0                	test   %eax,%eax
  c7:	75 4f                	jne    118 <main+0x118>
        // Child process 2: Write text to files
        for (int i = start_index; i <= 100; i++) {
  c9:	83 ff 64             	cmp    $0x64,%edi
  cc:	7f 32                	jg     100 <main+0x100>
  ce:	8d 9d e8 fe ff ff    	lea    -0x118(%ebp),%ebx
  d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            char filename[20]; // Sufficient buffer size for "fileX.txt" where X is up to 100
            create_filename("file", i, filename);
  d8:	83 ec 04             	sub    $0x4,%esp
  db:	53                   	push   %ebx
  dc:	57                   	push   %edi
        for (int i = start_index; i <= 100; i++) {
  dd:	83 c7 01             	add    $0x1,%edi
            create_filename("file", i, filename);
  e0:	68 57 0c 00 00       	push   $0xc57
  e5:	e8 26 01 00 00       	call   210 <create_filename>

            // Write to the file directly
            write_to_file(filename, text);
  ea:	5a                   	pop    %edx
  eb:	59                   	pop    %ecx
  ec:	ff b5 e4 fc ff ff    	push   -0x31c(%ebp)
  f2:	53                   	push   %ebx
  f3:	e8 58 02 00 00       	call   350 <write_to_file>
        for (int i = start_index; i <= 100; i++) {
  f8:	83 c4 10             	add    $0x10,%esp
  fb:	83 ff 65             	cmp    $0x65,%edi
  fe:	75 d8                	jne    d8 <main+0xd8>
        }

        exit();
 100:	e8 4e 06 00 00       	call   753 <exit>
        printf(2, "Usage: mdfork <text> [start_index]\n");
 105:	51                   	push   %ecx
 106:	51                   	push   %ecx
 107:	68 74 0c 00 00       	push   $0xc74
 10c:	6a 02                	push   $0x2
 10e:	e8 ad 07 00 00       	call   8c0 <printf>
        exit();
 113:	e8 3b 06 00 00       	call   753 <exit>
    } else if (pid2 < 0) {
 118:	78 38                	js     152 <main+0x152>
        printf(2, "Error: fork failed\n");
        exit();
    }

    // Parent process: Wait for both children to finish
    wait();
 11a:	e8 3c 06 00 00       	call   75b <wait>
    wait();
 11f:	e8 37 06 00 00       	call   75b <wait>

    printf(1, "Both child processes completed\n");
 124:	50                   	push   %eax
 125:	50                   	push   %eax
 126:	68 98 0c 00 00       	push   $0xc98
 12b:	6a 01                	push   $0x1
 12d:	e8 8e 07 00 00       	call   8c0 <printf>
    end_time = uptime();
 132:	e8 b4 06 00 00       	call   7eb <uptime>
    printf(1, "Time taken: %d ticks\n", end_time - start_time);
 137:	83 c4 0c             	add    $0xc,%esp
 13a:	2b 85 e0 fc ff ff    	sub    -0x320(%ebp),%eax
 140:	50                   	push   %eax
 141:	68 5c 0c 00 00       	push   $0xc5c
 146:	6a 01                	push   $0x1
 148:	e8 73 07 00 00       	call   8c0 <printf>
    exit();
 14d:	e8 01 06 00 00       	call   753 <exit>
        printf(2, "Error: fork failed\n");
 152:	53                   	push   %ebx
 153:	53                   	push   %ebx
 154:	68 43 0c 00 00       	push   $0xc43
 159:	6a 02                	push   $0x2
 15b:	e8 60 07 00 00       	call   8c0 <printf>
        exit();
 160:	e8 ee 05 00 00       	call   753 <exit>
        start_index = atoi(argv[2]);
 165:	83 ec 0c             	sub    $0xc,%esp
 168:	ff 76 08             	push   0x8(%esi)
 16b:	e8 70 05 00 00       	call   6e0 <atoi>
 170:	83 c4 10             	add    $0x10,%esp
 173:	89 c7                	mov    %eax,%edi
 175:	e9 cd fe ff ff       	jmp    47 <main+0x47>
 17a:	66 90                	xchg   %ax,%ax
 17c:	66 90                	xchg   %ax,%ax
 17e:	66 90                	xchg   %ax,%ax

00000180 <int_to_str>:
void int_to_str(int n, char *str) {
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	57                   	push   %edi
 184:	8b 4d 08             	mov    0x8(%ebp),%ecx
 187:	56                   	push   %esi
 188:	53                   	push   %ebx
    if (n == 0) {
 189:	85 c9                	test   %ecx,%ecx
 18b:	74 63                	je     1f0 <int_to_str+0x70>
    while (temp_n > 0) {
 18d:	89 ca                	mov    %ecx,%edx
    int len = 0;
 18f:	be 00 00 00 00       	mov    $0x0,%esi
    while (temp_n > 0) {
 194:	7e 6a                	jle    200 <int_to_str+0x80>
 196:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 19d:	8d 76 00             	lea    0x0(%esi),%esi
        temp_n /= 10;
 1a0:	b8 cd cc cc cc       	mov    $0xcccccccd,%eax
 1a5:	89 d7                	mov    %edx,%edi
 1a7:	89 f3                	mov    %esi,%ebx
        len++;
 1a9:	83 c6 01             	add    $0x1,%esi
        temp_n /= 10;
 1ac:	f7 e2                	mul    %edx
 1ae:	c1 ea 03             	shr    $0x3,%edx
    while (temp_n > 0) {
 1b1:	83 ff 09             	cmp    $0x9,%edi
 1b4:	7f ea                	jg     1a0 <int_to_str+0x20>
    str[len] = '\0';
 1b6:	8b 45 0c             	mov    0xc(%ebp),%eax
 1b9:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
    while (n > 0) {
 1bd:	01 c3                	add    %eax,%ebx
        str[--len] = (n % 10) + '0';
 1bf:	be cd cc cc cc       	mov    $0xcccccccd,%esi
 1c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1c8:	89 c8                	mov    %ecx,%eax
    while (n > 0) {
 1ca:	83 eb 01             	sub    $0x1,%ebx
        str[--len] = (n % 10) + '0';
 1cd:	f7 e6                	mul    %esi
 1cf:	89 c8                	mov    %ecx,%eax
 1d1:	c1 ea 03             	shr    $0x3,%edx
 1d4:	8d 3c 92             	lea    (%edx,%edx,4),%edi
 1d7:	01 ff                	add    %edi,%edi
 1d9:	29 f8                	sub    %edi,%eax
 1db:	83 c0 30             	add    $0x30,%eax
 1de:	88 43 01             	mov    %al,0x1(%ebx)
        n /= 10;
 1e1:	89 c8                	mov    %ecx,%eax
 1e3:	89 d1                	mov    %edx,%ecx
    while (n > 0) {
 1e5:	83 f8 09             	cmp    $0x9,%eax
 1e8:	7f de                	jg     1c8 <int_to_str+0x48>
}
 1ea:	5b                   	pop    %ebx
 1eb:	5e                   	pop    %esi
 1ec:	5f                   	pop    %edi
 1ed:	5d                   	pop    %ebp
 1ee:	c3                   	ret    
 1ef:	90                   	nop
        str[0] = '0';
 1f0:	8b 45 0c             	mov    0xc(%ebp),%eax
 1f3:	ba 30 00 00 00       	mov    $0x30,%edx
 1f8:	66 89 10             	mov    %dx,(%eax)
}
 1fb:	5b                   	pop    %ebx
 1fc:	5e                   	pop    %esi
 1fd:	5f                   	pop    %edi
 1fe:	5d                   	pop    %ebp
 1ff:	c3                   	ret    
    str[len] = '\0';
 200:	8b 45 0c             	mov    0xc(%ebp),%eax
 203:	c6 00 00             	movb   $0x0,(%eax)
    while (n > 0) {
 206:	eb e2                	jmp    1ea <int_to_str+0x6a>
 208:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 20f:	90                   	nop

00000210 <create_filename>:
void create_filename(char *base, int num, char *filename) {
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	57                   	push   %edi
 214:	56                   	push   %esi
 215:	53                   	push   %ebx
 216:	83 ec 1c             	sub    $0x1c,%esp
 219:	8b 75 08             	mov    0x8(%ebp),%esi
 21c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    while (base[i] != '\0') {
 21f:	0f b6 06             	movzbl (%esi),%eax
 222:	84 c0                	test   %al,%al
 224:	0f 84 06 01 00 00    	je     330 <create_filename+0x120>
    int i = 0;
 22a:	8b 7d 10             	mov    0x10(%ebp),%edi
 22d:	31 c9                	xor    %ecx,%ecx
 22f:	90                   	nop
        filename[i] = base[i];
 230:	88 04 0f             	mov    %al,(%edi,%ecx,1)
        i++;
 233:	89 ca                	mov    %ecx,%edx
 235:	83 c1 01             	add    $0x1,%ecx
    while (base[i] != '\0') {
 238:	0f b6 04 0e          	movzbl (%esi,%ecx,1),%eax
 23c:	84 c0                	test   %al,%al
 23e:	75 f0                	jne    230 <create_filename+0x20>
    filename[i++] = '.';
 240:	8b 45 10             	mov    0x10(%ebp),%eax
 243:	01 c8                	add    %ecx,%eax
 245:	89 45 e0             	mov    %eax,-0x20(%ebp)
 248:	8d 42 02             	lea    0x2(%edx),%eax
 24b:	89 45 dc             	mov    %eax,-0x24(%ebp)
    if (n == 0) {
 24e:	85 db                	test   %ebx,%ebx
 250:	0f 84 ca 00 00 00    	je     320 <create_filename+0x110>
    while (temp_n > 0) {
 256:	89 da                	mov    %ebx,%edx
    int len = 0;
 258:	be 00 00 00 00       	mov    $0x0,%esi
    while (temp_n > 0) {
 25d:	0f 8e 95 00 00 00    	jle    2f8 <create_filename+0xe8>
 263:	89 4d d8             	mov    %ecx,-0x28(%ebp)
 266:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 26d:	8d 76 00             	lea    0x0(%esi),%esi
        temp_n /= 10;
 270:	b8 cd cc cc cc       	mov    $0xcccccccd,%eax
 275:	89 d1                	mov    %edx,%ecx
 277:	89 f7                	mov    %esi,%edi
        len++;
 279:	83 c6 01             	add    $0x1,%esi
        temp_n /= 10;
 27c:	f7 e2                	mul    %edx
 27e:	c1 ea 03             	shr    $0x3,%edx
    while (temp_n > 0) {
 281:	83 f9 09             	cmp    $0x9,%ecx
 284:	7f ea                	jg     270 <create_filename+0x60>
    str[len] = '\0';
 286:	c6 44 35 ea 00       	movb   $0x0,-0x16(%ebp,%esi,1)
 28b:	8b 4d d8             	mov    -0x28(%ebp),%ecx
    while (n > 0) {
 28e:	8d 75 ea             	lea    -0x16(%ebp),%esi
 291:	01 fe                	add    %edi,%esi
 293:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 297:	90                   	nop
        str[--len] = (n % 10) + '0';
 298:	b8 cd cc cc cc       	mov    $0xcccccccd,%eax
    while (n > 0) {
 29d:	83 ee 01             	sub    $0x1,%esi
        str[--len] = (n % 10) + '0';
 2a0:	f7 e3                	mul    %ebx
 2a2:	89 d8                	mov    %ebx,%eax
 2a4:	c1 ea 03             	shr    $0x3,%edx
 2a7:	8d 3c 92             	lea    (%edx,%edx,4),%edi
 2aa:	01 ff                	add    %edi,%edi
 2ac:	29 f8                	sub    %edi,%eax
 2ae:	83 c0 30             	add    $0x30,%eax
 2b1:	88 46 01             	mov    %al,0x1(%esi)
        n /= 10;
 2b4:	89 d8                	mov    %ebx,%eax
 2b6:	89 d3                	mov    %edx,%ebx
    while (n > 0) {
 2b8:	83 f8 09             	cmp    $0x9,%eax
 2bb:	7f db                	jg     298 <create_filename+0x88>
    while (num_str[j] != '\0') {
 2bd:	0f b6 55 ea          	movzbl -0x16(%ebp),%edx
 2c1:	8d 5d ea             	lea    -0x16(%ebp),%ebx
 2c4:	0f b6 45 eb          	movzbl -0x15(%ebp),%eax
 2c8:	8b 75 10             	mov    0x10(%ebp),%esi
 2cb:	29 cb                	sub    %ecx,%ebx
 2cd:	84 d2                	test   %dl,%dl
 2cf:	75 0e                	jne    2df <create_filename+0xcf>
 2d1:	eb 25                	jmp    2f8 <create_filename+0xe8>
 2d3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2d7:	90                   	nop
 2d8:	89 c2                	mov    %eax,%edx
 2da:	0f b6 44 19 01       	movzbl 0x1(%ecx,%ebx,1),%eax
        filename[i++] = num_str[j++];
 2df:	83 c1 01             	add    $0x1,%ecx
 2e2:	88 54 0e ff          	mov    %dl,-0x1(%esi,%ecx,1)
    while (num_str[j] != '\0') {
 2e6:	84 c0                	test   %al,%al
 2e8:	75 ee                	jne    2d8 <create_filename+0xc8>
    filename[i++] = '.';
 2ea:	8b 45 10             	mov    0x10(%ebp),%eax
 2ed:	01 c8                	add    %ecx,%eax
 2ef:	89 45 e0             	mov    %eax,-0x20(%ebp)
 2f2:	8d 41 01             	lea    0x1(%ecx),%eax
 2f5:	89 45 dc             	mov    %eax,-0x24(%ebp)
 2f8:	8b 45 e0             	mov    -0x20(%ebp),%eax
    filename[i++] = 't';
 2fb:	8b 7d dc             	mov    -0x24(%ebp),%edi
    filename[i++] = '.';
 2fe:	c6 00 2e             	movb   $0x2e,(%eax)
    filename[i++] = 't';
 301:	8b 45 10             	mov    0x10(%ebp),%eax
 304:	c6 04 38 74          	movb   $0x74,(%eax,%edi,1)
    filename[i++] = 'x';
 308:	c6 44 08 02 78       	movb   $0x78,0x2(%eax,%ecx,1)
    filename[i++] = 't';
 30d:	c6 44 08 03 74       	movb   $0x74,0x3(%eax,%ecx,1)
    filename[i] = '\0'; // Null-terminate the string
 312:	c6 44 08 04 00       	movb   $0x0,0x4(%eax,%ecx,1)
}
 317:	83 c4 1c             	add    $0x1c,%esp
 31a:	5b                   	pop    %ebx
 31b:	5e                   	pop    %esi
 31c:	5f                   	pop    %edi
 31d:	5d                   	pop    %ebp
 31e:	c3                   	ret    
 31f:	90                   	nop
        filename[i++] = num_str[j++];
 320:	8b 45 10             	mov    0x10(%ebp),%eax
 323:	83 c1 01             	add    $0x1,%ecx
 326:	c6 44 08 ff 30       	movb   $0x30,-0x1(%eax,%ecx,1)
    while (num_str[j] != '\0') {
 32b:	eb bd                	jmp    2ea <create_filename+0xda>
 32d:	8d 76 00             	lea    0x0(%esi),%esi
    while (base[i] != '\0') {
 330:	8b 45 10             	mov    0x10(%ebp),%eax
 333:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
    int i = 0;
 33a:	31 c9                	xor    %ecx,%ecx
    while (base[i] != '\0') {
 33c:	89 45 e0             	mov    %eax,-0x20(%ebp)
 33f:	e9 0a ff ff ff       	jmp    24e <create_filename+0x3e>
 344:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 34b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 34f:	90                   	nop

00000350 <write_to_file>:
void write_to_file(char *filename, char *text) {
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	57                   	push   %edi
 354:	56                   	push   %esi
 355:	53                   	push   %ebx
 356:	83 ec 28             	sub    $0x28,%esp
 359:	8b 55 0c             	mov    0xc(%ebp),%edx
 35c:	8b 7d 08             	mov    0x8(%ebp),%edi
    int n = strlen(text);
 35f:	52                   	push   %edx
 360:	89 55 e4             	mov    %edx,-0x1c(%ebp)
 363:	e8 28 02 00 00       	call   590 <strlen>
 368:	89 c6                	mov    %eax,%esi
    fd = open(filename, O_WRONLY | O_CREATE);
 36a:	58                   	pop    %eax
 36b:	5a                   	pop    %edx
 36c:	68 01 02 00 00       	push   $0x201
 371:	57                   	push   %edi
 372:	e8 1c 04 00 00       	call   793 <open>
    if (fd < 0) {
 377:	83 c4 10             	add    $0x10,%esp
 37a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 37d:	85 c0                	test   %eax,%eax
 37f:	78 67                	js     3e8 <write_to_file+0x98>
    if (write(fd, text, n) != n) {
 381:	83 ec 04             	sub    $0x4,%esp
 384:	89 c3                	mov    %eax,%ebx
 386:	56                   	push   %esi
 387:	52                   	push   %edx
 388:	50                   	push   %eax
 389:	e8 e5 03 00 00       	call   773 <write>
 38e:	83 c4 10             	add    $0x10,%esp
 391:	39 f0                	cmp    %esi,%eax
 393:	75 2b                	jne    3c0 <write_to_file+0x70>
    close(fd);
 395:	83 ec 0c             	sub    $0xc,%esp
 398:	53                   	push   %ebx
 399:	e8 dd 03 00 00       	call   77b <close>
    printf(1, "Successfully wrote to %s\n", filename); // Debugging print
 39e:	83 c4 0c             	add    $0xc,%esp
 3a1:	57                   	push   %edi
 3a2:	68 1a 0c 00 00       	push   $0xc1a
 3a7:	6a 01                	push   $0x1
 3a9:	e8 12 05 00 00       	call   8c0 <printf>
 3ae:	83 c4 10             	add    $0x10,%esp
}
 3b1:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3b4:	5b                   	pop    %ebx
 3b5:	5e                   	pop    %esi
 3b6:	5f                   	pop    %edi
 3b7:	5d                   	pop    %ebp
 3b8:	c3                   	ret    
 3b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printf(2, "Error: write error for %s\n", filename);
 3c0:	83 ec 04             	sub    $0x4,%esp
 3c3:	57                   	push   %edi
 3c4:	68 ff 0b 00 00       	push   $0xbff
 3c9:	6a 02                	push   $0x2
 3cb:	e8 f0 04 00 00       	call   8c0 <printf>
        close(fd);
 3d0:	89 5d 08             	mov    %ebx,0x8(%ebp)
 3d3:	83 c4 10             	add    $0x10,%esp
}
 3d6:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3d9:	5b                   	pop    %ebx
 3da:	5e                   	pop    %esi
 3db:	5f                   	pop    %edi
 3dc:	5d                   	pop    %ebp
        close(fd);
 3dd:	e9 99 03 00 00       	jmp    77b <close>
 3e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printf(2, "Error: cannot open %s\n", filename);
 3e8:	83 ec 04             	sub    $0x4,%esp
 3eb:	57                   	push   %edi
 3ec:	68 e8 0b 00 00       	push   $0xbe8
 3f1:	6a 02                	push   $0x2
 3f3:	e8 c8 04 00 00       	call   8c0 <printf>
        return;
 3f8:	83 c4 10             	add    $0x10,%esp
}
 3fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3fe:	5b                   	pop    %ebx
 3ff:	5e                   	pop    %esi
 400:	5f                   	pop    %edi
 401:	5d                   	pop    %ebp
 402:	c3                   	ret    
 403:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 40a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000410 <matrix_multiply>:
void matrix_multiply(int A[N][N], int B[N][N], int C[N][N]) {
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	57                   	push   %edi
 414:	56                   	push   %esi
 415:	53                   	push   %ebx
 416:	83 ec 14             	sub    $0x14,%esp
 419:	8b 45 08             	mov    0x8(%ebp),%eax
 41c:	8b 75 10             	mov    0x10(%ebp),%esi
 41f:	8d 78 20             	lea    0x20(%eax),%edi
 422:	05 20 01 00 00       	add    $0x120,%eax
 427:	89 75 e4             	mov    %esi,-0x1c(%ebp)
 42a:	89 45 e0             	mov    %eax,-0x20(%ebp)
 42d:	8b 45 0c             	mov    0xc(%ebp),%eax
 430:	83 c0 20             	add    $0x20,%eax
 433:	89 45 e8             	mov    %eax,-0x18(%ebp)
 436:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 43d:	8d 76 00             	lea    0x0(%esi),%esi
        for (j = 0; j < N; j++) {
 440:	8b 45 0c             	mov    0xc(%ebp),%eax
void matrix_multiply(int A[N][N], int B[N][N], int C[N][N]) {
 443:	8b 75 e4             	mov    -0x1c(%ebp),%esi
 446:	89 45 f0             	mov    %eax,-0x10(%ebp)
 449:	8d 47 e0             	lea    -0x20(%edi),%eax
 44c:	89 45 ec             	mov    %eax,-0x14(%ebp)
 44f:	90                   	nop
            C[i][j] = 0;
 450:	8b 45 ec             	mov    -0x14(%ebp),%eax
 453:	8b 5d f0             	mov    -0x10(%ebp),%ebx
 456:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
 45c:	31 c9                	xor    %ecx,%ecx
 45e:	66 90                	xchg   %ax,%ax
                C[i][j] += A[i][k] * B[k][j];
 460:	8b 10                	mov    (%eax),%edx
 462:	0f af 13             	imul   (%ebx),%edx
            for (k = 0; k < N; k++) {
 465:	83 c0 04             	add    $0x4,%eax
 468:	83 c3 20             	add    $0x20,%ebx
                C[i][j] += A[i][k] * B[k][j];
 46b:	01 d1                	add    %edx,%ecx
 46d:	89 0e                	mov    %ecx,(%esi)
            for (k = 0; k < N; k++) {
 46f:	39 f8                	cmp    %edi,%eax
 471:	75 ed                	jne    460 <matrix_multiply+0x50>
        for (j = 0; j < N; j++) {
 473:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 477:	83 c6 04             	add    $0x4,%esi
 47a:	8b 4d f0             	mov    -0x10(%ebp),%ecx
 47d:	3b 4d e8             	cmp    -0x18(%ebp),%ecx
 480:	75 ce                	jne    450 <matrix_multiply+0x40>
    for (i = 0; i < N; i++) {
 482:	83 45 e4 20          	addl   $0x20,-0x1c(%ebp)
 486:	8d 78 20             	lea    0x20(%eax),%edi
 489:	3b 7d e0             	cmp    -0x20(%ebp),%edi
 48c:	75 b2                	jne    440 <matrix_multiply+0x30>
}
 48e:	83 c4 14             	add    $0x14,%esp
 491:	5b                   	pop    %ebx
 492:	5e                   	pop    %esi
 493:	5f                   	pop    %edi
 494:	5d                   	pop    %ebp
 495:	c3                   	ret    
 496:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 49d:	8d 76 00             	lea    0x0(%esi),%esi

000004a0 <print_matrix>:
void print_matrix(int matrix[N][N]) {
 4a0:	55                   	push   %ebp
 4a1:	89 e5                	mov    %esp,%ebp
 4a3:	57                   	push   %edi
 4a4:	56                   	push   %esi
 4a5:	53                   	push   %ebx
 4a6:	83 ec 0c             	sub    $0xc,%esp
 4a9:	8b 7d 08             	mov    0x8(%ebp),%edi
 4ac:	8d 77 20             	lea    0x20(%edi),%esi
 4af:	81 c7 20 01 00 00    	add    $0x120,%edi
 4b5:	8d 76 00             	lea    0x0(%esi),%esi
        for (j = 0; j < N; j++) {
 4b8:	8d 5e e0             	lea    -0x20(%esi),%ebx
 4bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4bf:	90                   	nop
            printf(1, "%d ", matrix[i][j]);
 4c0:	83 ec 04             	sub    $0x4,%esp
 4c3:	ff 33                	push   (%ebx)
        for (j = 0; j < N; j++) {
 4c5:	83 c3 04             	add    $0x4,%ebx
            printf(1, "%d ", matrix[i][j]);
 4c8:	68 34 0c 00 00       	push   $0xc34
 4cd:	6a 01                	push   $0x1
 4cf:	e8 ec 03 00 00       	call   8c0 <printf>
        for (j = 0; j < N; j++) {
 4d4:	83 c4 10             	add    $0x10,%esp
 4d7:	39 f3                	cmp    %esi,%ebx
 4d9:	75 e5                	jne    4c0 <print_matrix+0x20>
        printf(1, "\n");
 4db:	83 ec 08             	sub    $0x8,%esp
    for (i = 0; i < N; i++) {
 4de:	8d 73 20             	lea    0x20(%ebx),%esi
        printf(1, "\n");
 4e1:	68 41 0c 00 00       	push   $0xc41
 4e6:	6a 01                	push   $0x1
 4e8:	e8 d3 03 00 00       	call   8c0 <printf>
    for (i = 0; i < N; i++) {
 4ed:	83 c4 10             	add    $0x10,%esp
 4f0:	39 fe                	cmp    %edi,%esi
 4f2:	75 c4                	jne    4b8 <print_matrix+0x18>
}
 4f4:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4f7:	5b                   	pop    %ebx
 4f8:	5e                   	pop    %esi
 4f9:	5f                   	pop    %edi
 4fa:	5d                   	pop    %ebp
 4fb:	c3                   	ret    
 4fc:	66 90                	xchg   %ax,%ax
 4fe:	66 90                	xchg   %ax,%ax

00000500 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 500:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 501:	31 c0                	xor    %eax,%eax
{
 503:	89 e5                	mov    %esp,%ebp
 505:	53                   	push   %ebx
 506:	8b 4d 08             	mov    0x8(%ebp),%ecx
 509:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 50c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 510:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 514:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 517:	83 c0 01             	add    $0x1,%eax
 51a:	84 d2                	test   %dl,%dl
 51c:	75 f2                	jne    510 <strcpy+0x10>
    ;
  return os;
}
 51e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 521:	89 c8                	mov    %ecx,%eax
 523:	c9                   	leave  
 524:	c3                   	ret    
 525:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 52c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000530 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 530:	55                   	push   %ebp
 531:	89 e5                	mov    %esp,%ebp
 533:	53                   	push   %ebx
 534:	8b 55 08             	mov    0x8(%ebp),%edx
 537:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 53a:	0f b6 02             	movzbl (%edx),%eax
 53d:	84 c0                	test   %al,%al
 53f:	75 17                	jne    558 <strcmp+0x28>
 541:	eb 3a                	jmp    57d <strcmp+0x4d>
 543:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 547:	90                   	nop
 548:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 54c:	83 c2 01             	add    $0x1,%edx
 54f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 552:	84 c0                	test   %al,%al
 554:	74 1a                	je     570 <strcmp+0x40>
    p++, q++;
 556:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
 558:	0f b6 19             	movzbl (%ecx),%ebx
 55b:	38 c3                	cmp    %al,%bl
 55d:	74 e9                	je     548 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 55f:	29 d8                	sub    %ebx,%eax
}
 561:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 564:	c9                   	leave  
 565:	c3                   	ret    
 566:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 56d:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 570:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 574:	31 c0                	xor    %eax,%eax
 576:	29 d8                	sub    %ebx,%eax
}
 578:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 57b:	c9                   	leave  
 57c:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
 57d:	0f b6 19             	movzbl (%ecx),%ebx
 580:	31 c0                	xor    %eax,%eax
 582:	eb db                	jmp    55f <strcmp+0x2f>
 584:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 58b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 58f:	90                   	nop

00000590 <strlen>:

uint
strlen(const char *s)
{
 590:	55                   	push   %ebp
 591:	89 e5                	mov    %esp,%ebp
 593:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 596:	80 3a 00             	cmpb   $0x0,(%edx)
 599:	74 15                	je     5b0 <strlen+0x20>
 59b:	31 c0                	xor    %eax,%eax
 59d:	8d 76 00             	lea    0x0(%esi),%esi
 5a0:	83 c0 01             	add    $0x1,%eax
 5a3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 5a7:	89 c1                	mov    %eax,%ecx
 5a9:	75 f5                	jne    5a0 <strlen+0x10>
    ;
  return n;
}
 5ab:	89 c8                	mov    %ecx,%eax
 5ad:	5d                   	pop    %ebp
 5ae:	c3                   	ret    
 5af:	90                   	nop
  for(n = 0; s[n]; n++)
 5b0:	31 c9                	xor    %ecx,%ecx
}
 5b2:	5d                   	pop    %ebp
 5b3:	89 c8                	mov    %ecx,%eax
 5b5:	c3                   	ret    
 5b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5bd:	8d 76 00             	lea    0x0(%esi),%esi

000005c0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 5c0:	55                   	push   %ebp
 5c1:	89 e5                	mov    %esp,%ebp
 5c3:	57                   	push   %edi
 5c4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 5c7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 5ca:	8b 45 0c             	mov    0xc(%ebp),%eax
 5cd:	89 d7                	mov    %edx,%edi
 5cf:	fc                   	cld    
 5d0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 5d2:	8b 7d fc             	mov    -0x4(%ebp),%edi
 5d5:	89 d0                	mov    %edx,%eax
 5d7:	c9                   	leave  
 5d8:	c3                   	ret    
 5d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000005e0 <strchr>:

char*
strchr(const char *s, char c)
{
 5e0:	55                   	push   %ebp
 5e1:	89 e5                	mov    %esp,%ebp
 5e3:	8b 45 08             	mov    0x8(%ebp),%eax
 5e6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 5ea:	0f b6 10             	movzbl (%eax),%edx
 5ed:	84 d2                	test   %dl,%dl
 5ef:	75 12                	jne    603 <strchr+0x23>
 5f1:	eb 1d                	jmp    610 <strchr+0x30>
 5f3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5f7:	90                   	nop
 5f8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 5fc:	83 c0 01             	add    $0x1,%eax
 5ff:	84 d2                	test   %dl,%dl
 601:	74 0d                	je     610 <strchr+0x30>
    if(*s == c)
 603:	38 d1                	cmp    %dl,%cl
 605:	75 f1                	jne    5f8 <strchr+0x18>
      return (char*)s;
  return 0;
}
 607:	5d                   	pop    %ebp
 608:	c3                   	ret    
 609:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 610:	31 c0                	xor    %eax,%eax
}
 612:	5d                   	pop    %ebp
 613:	c3                   	ret    
 614:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 61b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 61f:	90                   	nop

00000620 <gets>:

char*
gets(char *buf, int max)
{
 620:	55                   	push   %ebp
 621:	89 e5                	mov    %esp,%ebp
 623:	57                   	push   %edi
 624:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 625:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 628:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 629:	31 db                	xor    %ebx,%ebx
{
 62b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 62e:	eb 27                	jmp    657 <gets+0x37>
    cc = read(0, &c, 1);
 630:	83 ec 04             	sub    $0x4,%esp
 633:	6a 01                	push   $0x1
 635:	57                   	push   %edi
 636:	6a 00                	push   $0x0
 638:	e8 2e 01 00 00       	call   76b <read>
    if(cc < 1)
 63d:	83 c4 10             	add    $0x10,%esp
 640:	85 c0                	test   %eax,%eax
 642:	7e 1d                	jle    661 <gets+0x41>
      break;
    buf[i++] = c;
 644:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 648:	8b 55 08             	mov    0x8(%ebp),%edx
 64b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 64f:	3c 0a                	cmp    $0xa,%al
 651:	74 1d                	je     670 <gets+0x50>
 653:	3c 0d                	cmp    $0xd,%al
 655:	74 19                	je     670 <gets+0x50>
  for(i=0; i+1 < max; ){
 657:	89 de                	mov    %ebx,%esi
 659:	83 c3 01             	add    $0x1,%ebx
 65c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 65f:	7c cf                	jl     630 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 661:	8b 45 08             	mov    0x8(%ebp),%eax
 664:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 668:	8d 65 f4             	lea    -0xc(%ebp),%esp
 66b:	5b                   	pop    %ebx
 66c:	5e                   	pop    %esi
 66d:	5f                   	pop    %edi
 66e:	5d                   	pop    %ebp
 66f:	c3                   	ret    
  buf[i] = '\0';
 670:	8b 45 08             	mov    0x8(%ebp),%eax
 673:	89 de                	mov    %ebx,%esi
 675:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 679:	8d 65 f4             	lea    -0xc(%ebp),%esp
 67c:	5b                   	pop    %ebx
 67d:	5e                   	pop    %esi
 67e:	5f                   	pop    %edi
 67f:	5d                   	pop    %ebp
 680:	c3                   	ret    
 681:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 688:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 68f:	90                   	nop

00000690 <stat>:

int
stat(const char *n, struct stat *st)
{
 690:	55                   	push   %ebp
 691:	89 e5                	mov    %esp,%ebp
 693:	56                   	push   %esi
 694:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 695:	83 ec 08             	sub    $0x8,%esp
 698:	6a 00                	push   $0x0
 69a:	ff 75 08             	push   0x8(%ebp)
 69d:	e8 f1 00 00 00       	call   793 <open>
  if(fd < 0)
 6a2:	83 c4 10             	add    $0x10,%esp
 6a5:	85 c0                	test   %eax,%eax
 6a7:	78 27                	js     6d0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 6a9:	83 ec 08             	sub    $0x8,%esp
 6ac:	ff 75 0c             	push   0xc(%ebp)
 6af:	89 c3                	mov    %eax,%ebx
 6b1:	50                   	push   %eax
 6b2:	e8 f4 00 00 00       	call   7ab <fstat>
  close(fd);
 6b7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 6ba:	89 c6                	mov    %eax,%esi
  close(fd);
 6bc:	e8 ba 00 00 00       	call   77b <close>
  return r;
 6c1:	83 c4 10             	add    $0x10,%esp
}
 6c4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 6c7:	89 f0                	mov    %esi,%eax
 6c9:	5b                   	pop    %ebx
 6ca:	5e                   	pop    %esi
 6cb:	5d                   	pop    %ebp
 6cc:	c3                   	ret    
 6cd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 6d0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 6d5:	eb ed                	jmp    6c4 <stat+0x34>
 6d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6de:	66 90                	xchg   %ax,%ax

000006e0 <atoi>:

int
atoi(const char *s)
{
 6e0:	55                   	push   %ebp
 6e1:	89 e5                	mov    %esp,%ebp
 6e3:	53                   	push   %ebx
 6e4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 6e7:	0f be 02             	movsbl (%edx),%eax
 6ea:	8d 48 d0             	lea    -0x30(%eax),%ecx
 6ed:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 6f0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 6f5:	77 1e                	ja     715 <atoi+0x35>
 6f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6fe:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 700:	83 c2 01             	add    $0x1,%edx
 703:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 706:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 70a:	0f be 02             	movsbl (%edx),%eax
 70d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 710:	80 fb 09             	cmp    $0x9,%bl
 713:	76 eb                	jbe    700 <atoi+0x20>
  return n;
}
 715:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 718:	89 c8                	mov    %ecx,%eax
 71a:	c9                   	leave  
 71b:	c3                   	ret    
 71c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000720 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 720:	55                   	push   %ebp
 721:	89 e5                	mov    %esp,%ebp
 723:	57                   	push   %edi
 724:	8b 45 10             	mov    0x10(%ebp),%eax
 727:	8b 55 08             	mov    0x8(%ebp),%edx
 72a:	56                   	push   %esi
 72b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 72e:	85 c0                	test   %eax,%eax
 730:	7e 13                	jle    745 <memmove+0x25>
 732:	01 d0                	add    %edx,%eax
  dst = vdst;
 734:	89 d7                	mov    %edx,%edi
 736:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 73d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 740:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 741:	39 f8                	cmp    %edi,%eax
 743:	75 fb                	jne    740 <memmove+0x20>
  return vdst;
}
 745:	5e                   	pop    %esi
 746:	89 d0                	mov    %edx,%eax
 748:	5f                   	pop    %edi
 749:	5d                   	pop    %ebp
 74a:	c3                   	ret    

0000074b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 74b:	b8 01 00 00 00       	mov    $0x1,%eax
 750:	cd 40                	int    $0x40
 752:	c3                   	ret    

00000753 <exit>:
SYSCALL(exit)
 753:	b8 02 00 00 00       	mov    $0x2,%eax
 758:	cd 40                	int    $0x40
 75a:	c3                   	ret    

0000075b <wait>:
SYSCALL(wait)
 75b:	b8 03 00 00 00       	mov    $0x3,%eax
 760:	cd 40                	int    $0x40
 762:	c3                   	ret    

00000763 <pipe>:
SYSCALL(pipe)
 763:	b8 04 00 00 00       	mov    $0x4,%eax
 768:	cd 40                	int    $0x40
 76a:	c3                   	ret    

0000076b <read>:
SYSCALL(read)
 76b:	b8 05 00 00 00       	mov    $0x5,%eax
 770:	cd 40                	int    $0x40
 772:	c3                   	ret    

00000773 <write>:
SYSCALL(write)
 773:	b8 10 00 00 00       	mov    $0x10,%eax
 778:	cd 40                	int    $0x40
 77a:	c3                   	ret    

0000077b <close>:
SYSCALL(close)
 77b:	b8 15 00 00 00       	mov    $0x15,%eax
 780:	cd 40                	int    $0x40
 782:	c3                   	ret    

00000783 <kill>:
SYSCALL(kill)
 783:	b8 06 00 00 00       	mov    $0x6,%eax
 788:	cd 40                	int    $0x40
 78a:	c3                   	ret    

0000078b <exec>:
SYSCALL(exec)
 78b:	b8 07 00 00 00       	mov    $0x7,%eax
 790:	cd 40                	int    $0x40
 792:	c3                   	ret    

00000793 <open>:
SYSCALL(open)
 793:	b8 0f 00 00 00       	mov    $0xf,%eax
 798:	cd 40                	int    $0x40
 79a:	c3                   	ret    

0000079b <mknod>:
SYSCALL(mknod)
 79b:	b8 11 00 00 00       	mov    $0x11,%eax
 7a0:	cd 40                	int    $0x40
 7a2:	c3                   	ret    

000007a3 <unlink>:
SYSCALL(unlink)
 7a3:	b8 12 00 00 00       	mov    $0x12,%eax
 7a8:	cd 40                	int    $0x40
 7aa:	c3                   	ret    

000007ab <fstat>:
SYSCALL(fstat)
 7ab:	b8 08 00 00 00       	mov    $0x8,%eax
 7b0:	cd 40                	int    $0x40
 7b2:	c3                   	ret    

000007b3 <link>:
SYSCALL(link)
 7b3:	b8 13 00 00 00       	mov    $0x13,%eax
 7b8:	cd 40                	int    $0x40
 7ba:	c3                   	ret    

000007bb <mkdir>:
SYSCALL(mkdir)
 7bb:	b8 14 00 00 00       	mov    $0x14,%eax
 7c0:	cd 40                	int    $0x40
 7c2:	c3                   	ret    

000007c3 <chdir>:
SYSCALL(chdir)
 7c3:	b8 09 00 00 00       	mov    $0x9,%eax
 7c8:	cd 40                	int    $0x40
 7ca:	c3                   	ret    

000007cb <dup>:
SYSCALL(dup)
 7cb:	b8 0a 00 00 00       	mov    $0xa,%eax
 7d0:	cd 40                	int    $0x40
 7d2:	c3                   	ret    

000007d3 <getpid>:
SYSCALL(getpid)
 7d3:	b8 0b 00 00 00       	mov    $0xb,%eax
 7d8:	cd 40                	int    $0x40
 7da:	c3                   	ret    

000007db <sbrk>:
SYSCALL(sbrk)
 7db:	b8 0c 00 00 00       	mov    $0xc,%eax
 7e0:	cd 40                	int    $0x40
 7e2:	c3                   	ret    

000007e3 <sleep>:
SYSCALL(sleep)
 7e3:	b8 0d 00 00 00       	mov    $0xd,%eax
 7e8:	cd 40                	int    $0x40
 7ea:	c3                   	ret    

000007eb <uptime>:
SYSCALL(uptime)
 7eb:	b8 0e 00 00 00       	mov    $0xe,%eax
 7f0:	cd 40                	int    $0x40
 7f2:	c3                   	ret    

000007f3 <ps>:
SYSCALL(ps)
 7f3:	b8 16 00 00 00       	mov    $0x16,%eax
 7f8:	cd 40                	int    $0x40
 7fa:	c3                   	ret    

000007fb <sys_ps>:

// usys.S
.globl sys_ps
sys_ps:
    movl SYS_ps, %eax
 7fb:	a1 16 00 00 00       	mov    0x16,%eax
    int $64
 800:	cd 40                	int    $0x40
    ret
 802:	c3                   	ret    
 803:	66 90                	xchg   %ax,%ax
 805:	66 90                	xchg   %ax,%ax
 807:	66 90                	xchg   %ax,%ax
 809:	66 90                	xchg   %ax,%ax
 80b:	66 90                	xchg   %ax,%ax
 80d:	66 90                	xchg   %ax,%ax
 80f:	90                   	nop

00000810 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 810:	55                   	push   %ebp
 811:	89 e5                	mov    %esp,%ebp
 813:	57                   	push   %edi
 814:	56                   	push   %esi
 815:	53                   	push   %ebx
 816:	83 ec 3c             	sub    $0x3c,%esp
 819:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 81c:	89 d1                	mov    %edx,%ecx
{
 81e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 821:	85 d2                	test   %edx,%edx
 823:	0f 89 7f 00 00 00    	jns    8a8 <printint+0x98>
 829:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 82d:	74 79                	je     8a8 <printint+0x98>
    neg = 1;
 82f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 836:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 838:	31 db                	xor    %ebx,%ebx
 83a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 83d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 840:	89 c8                	mov    %ecx,%eax
 842:	31 d2                	xor    %edx,%edx
 844:	89 cf                	mov    %ecx,%edi
 846:	f7 75 c4             	divl   -0x3c(%ebp)
 849:	0f b6 92 18 0d 00 00 	movzbl 0xd18(%edx),%edx
 850:	89 45 c0             	mov    %eax,-0x40(%ebp)
 853:	89 d8                	mov    %ebx,%eax
 855:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 858:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 85b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 85e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 861:	76 dd                	jbe    840 <printint+0x30>
  if(neg)
 863:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 866:	85 c9                	test   %ecx,%ecx
 868:	74 0c                	je     876 <printint+0x66>
    buf[i++] = '-';
 86a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 86f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 871:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 876:	8b 7d b8             	mov    -0x48(%ebp),%edi
 879:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 87d:	eb 07                	jmp    886 <printint+0x76>
 87f:	90                   	nop
    putc(fd, buf[i]);
 880:	0f b6 13             	movzbl (%ebx),%edx
 883:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 886:	83 ec 04             	sub    $0x4,%esp
 889:	88 55 d7             	mov    %dl,-0x29(%ebp)
 88c:	6a 01                	push   $0x1
 88e:	56                   	push   %esi
 88f:	57                   	push   %edi
 890:	e8 de fe ff ff       	call   773 <write>
  while(--i >= 0)
 895:	83 c4 10             	add    $0x10,%esp
 898:	39 de                	cmp    %ebx,%esi
 89a:	75 e4                	jne    880 <printint+0x70>
}
 89c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 89f:	5b                   	pop    %ebx
 8a0:	5e                   	pop    %esi
 8a1:	5f                   	pop    %edi
 8a2:	5d                   	pop    %ebp
 8a3:	c3                   	ret    
 8a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 8a8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 8af:	eb 87                	jmp    838 <printint+0x28>
 8b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8bf:	90                   	nop

000008c0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 8c0:	55                   	push   %ebp
 8c1:	89 e5                	mov    %esp,%ebp
 8c3:	57                   	push   %edi
 8c4:	56                   	push   %esi
 8c5:	53                   	push   %ebx
 8c6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 8c9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 8cc:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 8cf:	0f b6 13             	movzbl (%ebx),%edx
 8d2:	84 d2                	test   %dl,%dl
 8d4:	74 6a                	je     940 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
 8d6:	8d 45 10             	lea    0x10(%ebp),%eax
 8d9:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 8dc:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 8df:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
 8e1:	89 45 d0             	mov    %eax,-0x30(%ebp)
 8e4:	eb 36                	jmp    91c <printf+0x5c>
 8e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8ed:	8d 76 00             	lea    0x0(%esi),%esi
 8f0:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 8f3:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
 8f8:	83 f8 25             	cmp    $0x25,%eax
 8fb:	74 15                	je     912 <printf+0x52>
  write(fd, &c, 1);
 8fd:	83 ec 04             	sub    $0x4,%esp
 900:	88 55 e7             	mov    %dl,-0x19(%ebp)
 903:	6a 01                	push   $0x1
 905:	57                   	push   %edi
 906:	56                   	push   %esi
 907:	e8 67 fe ff ff       	call   773 <write>
 90c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
 90f:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 912:	0f b6 13             	movzbl (%ebx),%edx
 915:	83 c3 01             	add    $0x1,%ebx
 918:	84 d2                	test   %dl,%dl
 91a:	74 24                	je     940 <printf+0x80>
    c = fmt[i] & 0xff;
 91c:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 91f:	85 c9                	test   %ecx,%ecx
 921:	74 cd                	je     8f0 <printf+0x30>
      }
    } else if(state == '%'){
 923:	83 f9 25             	cmp    $0x25,%ecx
 926:	75 ea                	jne    912 <printf+0x52>
      if(c == 'd'){
 928:	83 f8 25             	cmp    $0x25,%eax
 92b:	0f 84 07 01 00 00    	je     a38 <printf+0x178>
 931:	83 e8 63             	sub    $0x63,%eax
 934:	83 f8 15             	cmp    $0x15,%eax
 937:	77 17                	ja     950 <printf+0x90>
 939:	ff 24 85 c0 0c 00 00 	jmp    *0xcc0(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 940:	8d 65 f4             	lea    -0xc(%ebp),%esp
 943:	5b                   	pop    %ebx
 944:	5e                   	pop    %esi
 945:	5f                   	pop    %edi
 946:	5d                   	pop    %ebp
 947:	c3                   	ret    
 948:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 94f:	90                   	nop
  write(fd, &c, 1);
 950:	83 ec 04             	sub    $0x4,%esp
 953:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 956:	6a 01                	push   $0x1
 958:	57                   	push   %edi
 959:	56                   	push   %esi
 95a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 95e:	e8 10 fe ff ff       	call   773 <write>
        putc(fd, c);
 963:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 967:	83 c4 0c             	add    $0xc,%esp
 96a:	88 55 e7             	mov    %dl,-0x19(%ebp)
 96d:	6a 01                	push   $0x1
 96f:	57                   	push   %edi
 970:	56                   	push   %esi
 971:	e8 fd fd ff ff       	call   773 <write>
        putc(fd, c);
 976:	83 c4 10             	add    $0x10,%esp
      state = 0;
 979:	31 c9                	xor    %ecx,%ecx
 97b:	eb 95                	jmp    912 <printf+0x52>
 97d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 980:	83 ec 0c             	sub    $0xc,%esp
 983:	b9 10 00 00 00       	mov    $0x10,%ecx
 988:	6a 00                	push   $0x0
 98a:	8b 45 d0             	mov    -0x30(%ebp),%eax
 98d:	8b 10                	mov    (%eax),%edx
 98f:	89 f0                	mov    %esi,%eax
 991:	e8 7a fe ff ff       	call   810 <printint>
        ap++;
 996:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 99a:	83 c4 10             	add    $0x10,%esp
      state = 0;
 99d:	31 c9                	xor    %ecx,%ecx
 99f:	e9 6e ff ff ff       	jmp    912 <printf+0x52>
 9a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 9a8:	8b 45 d0             	mov    -0x30(%ebp),%eax
 9ab:	8b 10                	mov    (%eax),%edx
        ap++;
 9ad:	83 c0 04             	add    $0x4,%eax
 9b0:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 9b3:	85 d2                	test   %edx,%edx
 9b5:	0f 84 8d 00 00 00    	je     a48 <printf+0x188>
        while(*s != 0){
 9bb:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
 9be:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
 9c0:	84 c0                	test   %al,%al
 9c2:	0f 84 4a ff ff ff    	je     912 <printf+0x52>
 9c8:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 9cb:	89 d3                	mov    %edx,%ebx
 9cd:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 9d0:	83 ec 04             	sub    $0x4,%esp
          s++;
 9d3:	83 c3 01             	add    $0x1,%ebx
 9d6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 9d9:	6a 01                	push   $0x1
 9db:	57                   	push   %edi
 9dc:	56                   	push   %esi
 9dd:	e8 91 fd ff ff       	call   773 <write>
        while(*s != 0){
 9e2:	0f b6 03             	movzbl (%ebx),%eax
 9e5:	83 c4 10             	add    $0x10,%esp
 9e8:	84 c0                	test   %al,%al
 9ea:	75 e4                	jne    9d0 <printf+0x110>
      state = 0;
 9ec:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 9ef:	31 c9                	xor    %ecx,%ecx
 9f1:	e9 1c ff ff ff       	jmp    912 <printf+0x52>
 9f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 9fd:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 a00:	83 ec 0c             	sub    $0xc,%esp
 a03:	b9 0a 00 00 00       	mov    $0xa,%ecx
 a08:	6a 01                	push   $0x1
 a0a:	e9 7b ff ff ff       	jmp    98a <printf+0xca>
 a0f:	90                   	nop
        putc(fd, *ap);
 a10:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
 a13:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 a16:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 a18:	6a 01                	push   $0x1
 a1a:	57                   	push   %edi
 a1b:	56                   	push   %esi
        putc(fd, *ap);
 a1c:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 a1f:	e8 4f fd ff ff       	call   773 <write>
        ap++;
 a24:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 a28:	83 c4 10             	add    $0x10,%esp
      state = 0;
 a2b:	31 c9                	xor    %ecx,%ecx
 a2d:	e9 e0 fe ff ff       	jmp    912 <printf+0x52>
 a32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
 a38:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 a3b:	83 ec 04             	sub    $0x4,%esp
 a3e:	e9 2a ff ff ff       	jmp    96d <printf+0xad>
 a43:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 a47:	90                   	nop
          s = "(null)";
 a48:	ba b8 0c 00 00       	mov    $0xcb8,%edx
        while(*s != 0){
 a4d:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 a50:	b8 28 00 00 00       	mov    $0x28,%eax
 a55:	89 d3                	mov    %edx,%ebx
 a57:	e9 74 ff ff ff       	jmp    9d0 <printf+0x110>
 a5c:	66 90                	xchg   %ax,%ax
 a5e:	66 90                	xchg   %ax,%ax

00000a60 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a60:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a61:	a1 dc 10 00 00       	mov    0x10dc,%eax
{
 a66:	89 e5                	mov    %esp,%ebp
 a68:	57                   	push   %edi
 a69:	56                   	push   %esi
 a6a:	53                   	push   %ebx
 a6b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 a6e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a78:	89 c2                	mov    %eax,%edx
 a7a:	8b 00                	mov    (%eax),%eax
 a7c:	39 ca                	cmp    %ecx,%edx
 a7e:	73 30                	jae    ab0 <free+0x50>
 a80:	39 c1                	cmp    %eax,%ecx
 a82:	72 04                	jb     a88 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a84:	39 c2                	cmp    %eax,%edx
 a86:	72 f0                	jb     a78 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 a88:	8b 73 fc             	mov    -0x4(%ebx),%esi
 a8b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 a8e:	39 f8                	cmp    %edi,%eax
 a90:	74 30                	je     ac2 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 a92:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 a95:	8b 42 04             	mov    0x4(%edx),%eax
 a98:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 a9b:	39 f1                	cmp    %esi,%ecx
 a9d:	74 3a                	je     ad9 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 a9f:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 aa1:	5b                   	pop    %ebx
  freep = p;
 aa2:	89 15 dc 10 00 00    	mov    %edx,0x10dc
}
 aa8:	5e                   	pop    %esi
 aa9:	5f                   	pop    %edi
 aaa:	5d                   	pop    %ebp
 aab:	c3                   	ret    
 aac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ab0:	39 c2                	cmp    %eax,%edx
 ab2:	72 c4                	jb     a78 <free+0x18>
 ab4:	39 c1                	cmp    %eax,%ecx
 ab6:	73 c0                	jae    a78 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
 ab8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 abb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 abe:	39 f8                	cmp    %edi,%eax
 ac0:	75 d0                	jne    a92 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
 ac2:	03 70 04             	add    0x4(%eax),%esi
 ac5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 ac8:	8b 02                	mov    (%edx),%eax
 aca:	8b 00                	mov    (%eax),%eax
 acc:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 acf:	8b 42 04             	mov    0x4(%edx),%eax
 ad2:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 ad5:	39 f1                	cmp    %esi,%ecx
 ad7:	75 c6                	jne    a9f <free+0x3f>
    p->s.size += bp->s.size;
 ad9:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 adc:	89 15 dc 10 00 00    	mov    %edx,0x10dc
    p->s.size += bp->s.size;
 ae2:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 ae5:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 ae8:	89 0a                	mov    %ecx,(%edx)
}
 aea:	5b                   	pop    %ebx
 aeb:	5e                   	pop    %esi
 aec:	5f                   	pop    %edi
 aed:	5d                   	pop    %ebp
 aee:	c3                   	ret    
 aef:	90                   	nop

00000af0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 af0:	55                   	push   %ebp
 af1:	89 e5                	mov    %esp,%ebp
 af3:	57                   	push   %edi
 af4:	56                   	push   %esi
 af5:	53                   	push   %ebx
 af6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 af9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 afc:	8b 3d dc 10 00 00    	mov    0x10dc,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b02:	8d 70 07             	lea    0x7(%eax),%esi
 b05:	c1 ee 03             	shr    $0x3,%esi
 b08:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 b0b:	85 ff                	test   %edi,%edi
 b0d:	0f 84 9d 00 00 00    	je     bb0 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b13:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 b15:	8b 4a 04             	mov    0x4(%edx),%ecx
 b18:	39 f1                	cmp    %esi,%ecx
 b1a:	73 6a                	jae    b86 <malloc+0x96>
 b1c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 b21:	39 de                	cmp    %ebx,%esi
 b23:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 b26:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 b2d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 b30:	eb 17                	jmp    b49 <malloc+0x59>
 b32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b38:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 b3a:	8b 48 04             	mov    0x4(%eax),%ecx
 b3d:	39 f1                	cmp    %esi,%ecx
 b3f:	73 4f                	jae    b90 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 b41:	8b 3d dc 10 00 00    	mov    0x10dc,%edi
 b47:	89 c2                	mov    %eax,%edx
 b49:	39 d7                	cmp    %edx,%edi
 b4b:	75 eb                	jne    b38 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 b4d:	83 ec 0c             	sub    $0xc,%esp
 b50:	ff 75 e4             	push   -0x1c(%ebp)
 b53:	e8 83 fc ff ff       	call   7db <sbrk>
  if(p == (char*)-1)
 b58:	83 c4 10             	add    $0x10,%esp
 b5b:	83 f8 ff             	cmp    $0xffffffff,%eax
 b5e:	74 1c                	je     b7c <malloc+0x8c>
  hp->s.size = nu;
 b60:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 b63:	83 ec 0c             	sub    $0xc,%esp
 b66:	83 c0 08             	add    $0x8,%eax
 b69:	50                   	push   %eax
 b6a:	e8 f1 fe ff ff       	call   a60 <free>
  return freep;
 b6f:	8b 15 dc 10 00 00    	mov    0x10dc,%edx
      if((p = morecore(nunits)) == 0)
 b75:	83 c4 10             	add    $0x10,%esp
 b78:	85 d2                	test   %edx,%edx
 b7a:	75 bc                	jne    b38 <malloc+0x48>
        return 0;
  }
}
 b7c:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 b7f:	31 c0                	xor    %eax,%eax
}
 b81:	5b                   	pop    %ebx
 b82:	5e                   	pop    %esi
 b83:	5f                   	pop    %edi
 b84:	5d                   	pop    %ebp
 b85:	c3                   	ret    
    if(p->s.size >= nunits){
 b86:	89 d0                	mov    %edx,%eax
 b88:	89 fa                	mov    %edi,%edx
 b8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 b90:	39 ce                	cmp    %ecx,%esi
 b92:	74 4c                	je     be0 <malloc+0xf0>
        p->s.size -= nunits;
 b94:	29 f1                	sub    %esi,%ecx
 b96:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 b99:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 b9c:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 b9f:	89 15 dc 10 00 00    	mov    %edx,0x10dc
}
 ba5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 ba8:	83 c0 08             	add    $0x8,%eax
}
 bab:	5b                   	pop    %ebx
 bac:	5e                   	pop    %esi
 bad:	5f                   	pop    %edi
 bae:	5d                   	pop    %ebp
 baf:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 bb0:	c7 05 dc 10 00 00 e0 	movl   $0x10e0,0x10dc
 bb7:	10 00 00 
    base.s.size = 0;
 bba:	bf e0 10 00 00       	mov    $0x10e0,%edi
    base.s.ptr = freep = prevp = &base;
 bbf:	c7 05 e0 10 00 00 e0 	movl   $0x10e0,0x10e0
 bc6:	10 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bc9:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 bcb:	c7 05 e4 10 00 00 00 	movl   $0x0,0x10e4
 bd2:	00 00 00 
    if(p->s.size >= nunits){
 bd5:	e9 42 ff ff ff       	jmp    b1c <malloc+0x2c>
 bda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 be0:	8b 08                	mov    (%eax),%ecx
 be2:	89 0a                	mov    %ecx,(%edx)
 be4:	eb b9                	jmp    b9f <malloc+0xaf>
