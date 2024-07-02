
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
  11:	81 ec c8 00 00 00    	sub    $0xc8,%esp
  17:	8b 01                	mov    (%ecx),%eax
  19:	8b 51 04             	mov    0x4(%ecx),%edx
    if (argc < 2) {
  1c:	83 f8 01             	cmp    $0x1,%eax
  1f:	0f 8e b3 00 00 00    	jle    d8 <main+0xd8>
        // Print usage message to stderr (fd 2)
        printf(2, "Usage: combined_program <text> [start_index]\n");
        exit();
    }

    char *text = argv[1];
  25:	8b 72 04             	mov    0x4(%edx),%esi
    int start_index = 1;
  28:	bb 01 00 00 00       	mov    $0x1,%ebx

    if (argc == 3) {
  2d:	83 f8 03             	cmp    $0x3,%eax
  30:	0f 84 e7 00 00 00    	je     11d <main+0x11d>
    }

    int pid1, pid2;

    // Create first child process for matrix multiplication
    if ((pid1 = fork()) == 0) {
  36:	e8 b0 06 00 00       	call   6eb <fork>
  3b:	85 c0                	test   %eax,%eax
  3d:	75 5c                	jne    9b <main+0x9b>
        // Child process 1: Matrix multiplication
        int A[N][N], B[N][N], C[N][N];
        int i, j;

        // Initialize matrices A and B with some values
        for (i = 0; i < N; i++) {
  3f:	31 c9                	xor    %ecx,%ecx
  41:	8d b5 28 ff ff ff    	lea    -0xd8(%ebp),%esi
  47:	8d bd 68 ff ff ff    	lea    -0x98(%ebp),%edi
            for (j = 0; j < N; j++) {
  4d:	89 ca                	mov    %ecx,%edx
  4f:	31 c0                	xor    %eax,%eax
  51:	c1 e2 04             	shl    $0x4,%edx
                A[i][j] = i + j;
  54:	8d 1c 08             	lea    (%eax,%ecx,1),%ebx
  57:	89 1c 16             	mov    %ebx,(%esi,%edx,1)
                B[i][j] = i - j;
  5a:	89 cb                	mov    %ecx,%ebx
  5c:	29 c3                	sub    %eax,%ebx
            for (j = 0; j < N; j++) {
  5e:	83 c0 01             	add    $0x1,%eax
                B[i][j] = i - j;
  61:	89 1c 17             	mov    %ebx,(%edi,%edx,1)
            for (j = 0; j < N; j++) {
  64:	83 c2 04             	add    $0x4,%edx
  67:	83 f8 04             	cmp    $0x4,%eax
  6a:	75 e8                	jne    54 <main+0x54>
        for (i = 0; i < N; i++) {
  6c:	83 c1 01             	add    $0x1,%ecx
  6f:	83 f9 04             	cmp    $0x4,%ecx
  72:	75 d9                	jne    4d <main+0x4d>
            }
        }

        // Perform matrix multiplication
        matrix_multiply(A, B, C);
  74:	8d 5d a8             	lea    -0x58(%ebp),%ebx
  77:	50                   	push   %eax
  78:	53                   	push   %ebx
  79:	57                   	push   %edi
  7a:	56                   	push   %esi
  7b:	e8 50 03 00 00       	call   3d0 <matrix_multiply>

        // Print the result
        printf(1, "Matrix C:\n");
  80:	58                   	pop    %eax
  81:	5a                   	pop    %edx
  82:	68 d8 0b 00 00       	push   $0xbd8
  87:	6a 01                	push   $0x1
  89:	e8 d2 07 00 00       	call   860 <printf>
        print_matrix(C);
  8e:	89 1c 24             	mov    %ebx,(%esp)
  91:	e8 ba 03 00 00       	call   450 <print_matrix>

        exit();
  96:	e8 58 06 00 00       	call   6f3 <exit>
    } else if (pid1 < 0) {
  9b:	78 6d                	js     10a <main+0x10a>
        printf(2, "Error: fork failed\n");
        exit();
    }

    // Create second child process for writing to files
    if ((pid2 = fork()) == 0) {
  9d:	e8 49 06 00 00       	call   6eb <fork>
  a2:	85 c0                	test   %eax,%eax
  a4:	75 45                	jne    eb <main+0xeb>
        // Child process 2: Write text to files
        for (int i = start_index; i <= 100; i++) {
  a6:	83 fb 64             	cmp    $0x64,%ebx
  a9:	7f 28                	jg     d3 <main+0xd3>
  ab:	8d 7d a8             	lea    -0x58(%ebp),%edi
  ae:	66 90                	xchg   %ax,%ax
            char filename[20]; // Sufficient buffer size for "fileX.txt" where X is up to 100
            create_filename("file", i, filename);
  b0:	83 ec 04             	sub    $0x4,%esp
  b3:	57                   	push   %edi
  b4:	53                   	push   %ebx
        for (int i = start_index; i <= 100; i++) {
  b5:	83 c3 01             	add    $0x1,%ebx
            create_filename("file", i, filename);
  b8:	68 f7 0b 00 00       	push   $0xbf7
  bd:	e8 0e 01 00 00       	call   1d0 <create_filename>

            // Write to the file directly
            write_to_file(filename, text);
  c2:	5a                   	pop    %edx
  c3:	59                   	pop    %ecx
  c4:	56                   	push   %esi
  c5:	57                   	push   %edi
  c6:	e8 45 02 00 00       	call   310 <write_to_file>
        for (int i = start_index; i <= 100; i++) {
  cb:	83 c4 10             	add    $0x10,%esp
  ce:	83 fb 65             	cmp    $0x65,%ebx
  d1:	75 dd                	jne    b0 <main+0xb0>
        }

        exit();
  d3:	e8 1b 06 00 00       	call   6f3 <exit>
        printf(2, "Usage: combined_program <text> [start_index]\n");
  d8:	51                   	push   %ecx
  d9:	51                   	push   %ecx
  da:	68 fc 0b 00 00       	push   $0xbfc
  df:	6a 02                	push   $0x2
  e1:	e8 7a 07 00 00       	call   860 <printf>
        exit();
  e6:	e8 08 06 00 00       	call   6f3 <exit>
    } else if (pid2 < 0) {
  eb:	78 1d                	js     10a <main+0x10a>
        printf(2, "Error: fork failed\n");
        exit();
    }

    // Parent process: Wait for both children to finish
    wait();
  ed:	e8 09 06 00 00       	call   6fb <wait>
    wait();
  f2:	e8 04 06 00 00       	call   6fb <wait>

    printf(1, "Both child processes completed\n");
  f7:	50                   	push   %eax
  f8:	50                   	push   %eax
  f9:	68 2c 0c 00 00       	push   $0xc2c
  fe:	6a 01                	push   $0x1
 100:	e8 5b 07 00 00       	call   860 <printf>
    exit();
 105:	e8 e9 05 00 00       	call   6f3 <exit>
        printf(2, "Error: fork failed\n");
 10a:	53                   	push   %ebx
 10b:	53                   	push   %ebx
 10c:	68 e3 0b 00 00       	push   $0xbe3
 111:	6a 02                	push   $0x2
 113:	e8 48 07 00 00       	call   860 <printf>
        exit();
 118:	e8 d6 05 00 00       	call   6f3 <exit>
        start_index = atoi(argv[2]);
 11d:	83 ec 0c             	sub    $0xc,%esp
 120:	ff 72 08             	push   0x8(%edx)
 123:	e8 58 05 00 00       	call   680 <atoi>
 128:	83 c4 10             	add    $0x10,%esp
 12b:	89 c3                	mov    %eax,%ebx
 12d:	e9 04 ff ff ff       	jmp    36 <main+0x36>
 132:	66 90                	xchg   %ax,%ax
 134:	66 90                	xchg   %ax,%ax
 136:	66 90                	xchg   %ax,%ax
 138:	66 90                	xchg   %ax,%ax
 13a:	66 90                	xchg   %ax,%ax
 13c:	66 90                	xchg   %ax,%ax
 13e:	66 90                	xchg   %ax,%ax

00000140 <int_to_str>:
void int_to_str(int n, char *str) {
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	57                   	push   %edi
 144:	8b 4d 08             	mov    0x8(%ebp),%ecx
 147:	56                   	push   %esi
 148:	53                   	push   %ebx
    if (n == 0) {
 149:	85 c9                	test   %ecx,%ecx
 14b:	74 63                	je     1b0 <int_to_str+0x70>
    while (temp_n > 0) {
 14d:	89 ca                	mov    %ecx,%edx
    int len = 0;
 14f:	be 00 00 00 00       	mov    $0x0,%esi
    while (temp_n > 0) {
 154:	7e 6a                	jle    1c0 <int_to_str+0x80>
 156:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 15d:	8d 76 00             	lea    0x0(%esi),%esi
        temp_n /= 10;
 160:	b8 cd cc cc cc       	mov    $0xcccccccd,%eax
 165:	89 d7                	mov    %edx,%edi
 167:	89 f3                	mov    %esi,%ebx
        len++;
 169:	83 c6 01             	add    $0x1,%esi
        temp_n /= 10;
 16c:	f7 e2                	mul    %edx
 16e:	c1 ea 03             	shr    $0x3,%edx
    while (temp_n > 0) {
 171:	83 ff 09             	cmp    $0x9,%edi
 174:	7f ea                	jg     160 <int_to_str+0x20>
    str[len] = '\0';
 176:	8b 45 0c             	mov    0xc(%ebp),%eax
 179:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
    while (n > 0) {
 17d:	01 c3                	add    %eax,%ebx
        str[--len] = (n % 10) + '0';
 17f:	be cd cc cc cc       	mov    $0xcccccccd,%esi
 184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 188:	89 c8                	mov    %ecx,%eax
    while (n > 0) {
 18a:	83 eb 01             	sub    $0x1,%ebx
        str[--len] = (n % 10) + '0';
 18d:	f7 e6                	mul    %esi
 18f:	89 c8                	mov    %ecx,%eax
 191:	c1 ea 03             	shr    $0x3,%edx
 194:	8d 3c 92             	lea    (%edx,%edx,4),%edi
 197:	01 ff                	add    %edi,%edi
 199:	29 f8                	sub    %edi,%eax
 19b:	83 c0 30             	add    $0x30,%eax
 19e:	88 43 01             	mov    %al,0x1(%ebx)
        n /= 10;
 1a1:	89 c8                	mov    %ecx,%eax
 1a3:	89 d1                	mov    %edx,%ecx
    while (n > 0) {
 1a5:	83 f8 09             	cmp    $0x9,%eax
 1a8:	7f de                	jg     188 <int_to_str+0x48>
}
 1aa:	5b                   	pop    %ebx
 1ab:	5e                   	pop    %esi
 1ac:	5f                   	pop    %edi
 1ad:	5d                   	pop    %ebp
 1ae:	c3                   	ret    
 1af:	90                   	nop
        str[0] = '0';
 1b0:	8b 45 0c             	mov    0xc(%ebp),%eax
 1b3:	ba 30 00 00 00       	mov    $0x30,%edx
 1b8:	66 89 10             	mov    %dx,(%eax)
}
 1bb:	5b                   	pop    %ebx
 1bc:	5e                   	pop    %esi
 1bd:	5f                   	pop    %edi
 1be:	5d                   	pop    %ebp
 1bf:	c3                   	ret    
    str[len] = '\0';
 1c0:	8b 45 0c             	mov    0xc(%ebp),%eax
 1c3:	c6 00 00             	movb   $0x0,(%eax)
    while (n > 0) {
 1c6:	eb e2                	jmp    1aa <int_to_str+0x6a>
 1c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1cf:	90                   	nop

000001d0 <create_filename>:
void create_filename(char *base, int num, char *filename) {
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	57                   	push   %edi
 1d4:	56                   	push   %esi
 1d5:	53                   	push   %ebx
 1d6:	83 ec 1c             	sub    $0x1c,%esp
 1d9:	8b 75 08             	mov    0x8(%ebp),%esi
 1dc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    while (base[i] != '\0') {
 1df:	0f b6 06             	movzbl (%esi),%eax
 1e2:	84 c0                	test   %al,%al
 1e4:	0f 84 06 01 00 00    	je     2f0 <create_filename+0x120>
    int i = 0;
 1ea:	8b 7d 10             	mov    0x10(%ebp),%edi
 1ed:	31 c9                	xor    %ecx,%ecx
 1ef:	90                   	nop
        filename[i] = base[i];
 1f0:	88 04 0f             	mov    %al,(%edi,%ecx,1)
        i++;
 1f3:	89 ca                	mov    %ecx,%edx
 1f5:	83 c1 01             	add    $0x1,%ecx
    while (base[i] != '\0') {
 1f8:	0f b6 04 0e          	movzbl (%esi,%ecx,1),%eax
 1fc:	84 c0                	test   %al,%al
 1fe:	75 f0                	jne    1f0 <create_filename+0x20>
    filename[i++] = '.';
 200:	8b 45 10             	mov    0x10(%ebp),%eax
 203:	01 c8                	add    %ecx,%eax
 205:	89 45 e0             	mov    %eax,-0x20(%ebp)
 208:	8d 42 02             	lea    0x2(%edx),%eax
 20b:	89 45 dc             	mov    %eax,-0x24(%ebp)
    if (n == 0) {
 20e:	85 db                	test   %ebx,%ebx
 210:	0f 84 ca 00 00 00    	je     2e0 <create_filename+0x110>
    while (temp_n > 0) {
 216:	89 da                	mov    %ebx,%edx
    int len = 0;
 218:	be 00 00 00 00       	mov    $0x0,%esi
    while (temp_n > 0) {
 21d:	0f 8e 95 00 00 00    	jle    2b8 <create_filename+0xe8>
 223:	89 4d d8             	mov    %ecx,-0x28(%ebp)
 226:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 22d:	8d 76 00             	lea    0x0(%esi),%esi
        temp_n /= 10;
 230:	b8 cd cc cc cc       	mov    $0xcccccccd,%eax
 235:	89 d1                	mov    %edx,%ecx
 237:	89 f7                	mov    %esi,%edi
        len++;
 239:	83 c6 01             	add    $0x1,%esi
        temp_n /= 10;
 23c:	f7 e2                	mul    %edx
 23e:	c1 ea 03             	shr    $0x3,%edx
    while (temp_n > 0) {
 241:	83 f9 09             	cmp    $0x9,%ecx
 244:	7f ea                	jg     230 <create_filename+0x60>
    str[len] = '\0';
 246:	c6 44 35 ea 00       	movb   $0x0,-0x16(%ebp,%esi,1)
 24b:	8b 4d d8             	mov    -0x28(%ebp),%ecx
    while (n > 0) {
 24e:	8d 75 ea             	lea    -0x16(%ebp),%esi
 251:	01 fe                	add    %edi,%esi
 253:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 257:	90                   	nop
        str[--len] = (n % 10) + '0';
 258:	b8 cd cc cc cc       	mov    $0xcccccccd,%eax
    while (n > 0) {
 25d:	83 ee 01             	sub    $0x1,%esi
        str[--len] = (n % 10) + '0';
 260:	f7 e3                	mul    %ebx
 262:	89 d8                	mov    %ebx,%eax
 264:	c1 ea 03             	shr    $0x3,%edx
 267:	8d 3c 92             	lea    (%edx,%edx,4),%edi
 26a:	01 ff                	add    %edi,%edi
 26c:	29 f8                	sub    %edi,%eax
 26e:	83 c0 30             	add    $0x30,%eax
 271:	88 46 01             	mov    %al,0x1(%esi)
        n /= 10;
 274:	89 d8                	mov    %ebx,%eax
 276:	89 d3                	mov    %edx,%ebx
    while (n > 0) {
 278:	83 f8 09             	cmp    $0x9,%eax
 27b:	7f db                	jg     258 <create_filename+0x88>
    while (num_str[j] != '\0') {
 27d:	0f b6 55 ea          	movzbl -0x16(%ebp),%edx
 281:	8d 5d ea             	lea    -0x16(%ebp),%ebx
 284:	0f b6 45 eb          	movzbl -0x15(%ebp),%eax
 288:	8b 75 10             	mov    0x10(%ebp),%esi
 28b:	29 cb                	sub    %ecx,%ebx
 28d:	84 d2                	test   %dl,%dl
 28f:	75 0e                	jne    29f <create_filename+0xcf>
 291:	eb 25                	jmp    2b8 <create_filename+0xe8>
 293:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 297:	90                   	nop
 298:	89 c2                	mov    %eax,%edx
 29a:	0f b6 44 19 01       	movzbl 0x1(%ecx,%ebx,1),%eax
        filename[i++] = num_str[j++];
 29f:	83 c1 01             	add    $0x1,%ecx
 2a2:	88 54 0e ff          	mov    %dl,-0x1(%esi,%ecx,1)
    while (num_str[j] != '\0') {
 2a6:	84 c0                	test   %al,%al
 2a8:	75 ee                	jne    298 <create_filename+0xc8>
    filename[i++] = '.';
 2aa:	8b 45 10             	mov    0x10(%ebp),%eax
 2ad:	01 c8                	add    %ecx,%eax
 2af:	89 45 e0             	mov    %eax,-0x20(%ebp)
 2b2:	8d 41 01             	lea    0x1(%ecx),%eax
 2b5:	89 45 dc             	mov    %eax,-0x24(%ebp)
 2b8:	8b 45 e0             	mov    -0x20(%ebp),%eax
    filename[i++] = 't';
 2bb:	8b 7d dc             	mov    -0x24(%ebp),%edi
    filename[i++] = '.';
 2be:	c6 00 2e             	movb   $0x2e,(%eax)
    filename[i++] = 't';
 2c1:	8b 45 10             	mov    0x10(%ebp),%eax
 2c4:	c6 04 38 74          	movb   $0x74,(%eax,%edi,1)
    filename[i++] = 'x';
 2c8:	c6 44 08 02 78       	movb   $0x78,0x2(%eax,%ecx,1)
    filename[i++] = 't';
 2cd:	c6 44 08 03 74       	movb   $0x74,0x3(%eax,%ecx,1)
    filename[i] = '\0'; // Null-terminate the string
 2d2:	c6 44 08 04 00       	movb   $0x0,0x4(%eax,%ecx,1)
}
 2d7:	83 c4 1c             	add    $0x1c,%esp
 2da:	5b                   	pop    %ebx
 2db:	5e                   	pop    %esi
 2dc:	5f                   	pop    %edi
 2dd:	5d                   	pop    %ebp
 2de:	c3                   	ret    
 2df:	90                   	nop
        filename[i++] = num_str[j++];
 2e0:	8b 45 10             	mov    0x10(%ebp),%eax
 2e3:	83 c1 01             	add    $0x1,%ecx
 2e6:	c6 44 08 ff 30       	movb   $0x30,-0x1(%eax,%ecx,1)
    while (num_str[j] != '\0') {
 2eb:	eb bd                	jmp    2aa <create_filename+0xda>
 2ed:	8d 76 00             	lea    0x0(%esi),%esi
    while (base[i] != '\0') {
 2f0:	8b 45 10             	mov    0x10(%ebp),%eax
 2f3:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
    int i = 0;
 2fa:	31 c9                	xor    %ecx,%ecx
    while (base[i] != '\0') {
 2fc:	89 45 e0             	mov    %eax,-0x20(%ebp)
 2ff:	e9 0a ff ff ff       	jmp    20e <create_filename+0x3e>
 304:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 30b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 30f:	90                   	nop

00000310 <write_to_file>:
void write_to_file(char *filename, char *text) {
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	57                   	push   %edi
 314:	56                   	push   %esi
 315:	53                   	push   %ebx
 316:	83 ec 28             	sub    $0x28,%esp
 319:	8b 55 0c             	mov    0xc(%ebp),%edx
 31c:	8b 7d 08             	mov    0x8(%ebp),%edi
    int n = strlen(text);
 31f:	52                   	push   %edx
 320:	89 55 e4             	mov    %edx,-0x1c(%ebp)
 323:	e8 08 02 00 00       	call   530 <strlen>
 328:	89 c6                	mov    %eax,%esi
    fd = open(filename, O_WRONLY | O_CREATE);
 32a:	58                   	pop    %eax
 32b:	5a                   	pop    %edx
 32c:	68 01 02 00 00       	push   $0x201
 331:	57                   	push   %edi
 332:	e8 fc 03 00 00       	call   733 <open>
    if (fd < 0) {
 337:	83 c4 10             	add    $0x10,%esp
 33a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 33d:	85 c0                	test   %eax,%eax
 33f:	78 67                	js     3a8 <write_to_file+0x98>
    if (write(fd, text, n) != n) {
 341:	83 ec 04             	sub    $0x4,%esp
 344:	89 c3                	mov    %eax,%ebx
 346:	56                   	push   %esi
 347:	52                   	push   %edx
 348:	50                   	push   %eax
 349:	e8 c5 03 00 00       	call   713 <write>
 34e:	83 c4 10             	add    $0x10,%esp
 351:	39 f0                	cmp    %esi,%eax
 353:	75 2b                	jne    380 <write_to_file+0x70>
    close(fd);
 355:	83 ec 0c             	sub    $0xc,%esp
 358:	53                   	push   %ebx
 359:	e8 bd 03 00 00       	call   71b <close>
    printf(1, "Successfully wrote to %s\n", filename); // Debugging print
 35e:	83 c4 0c             	add    $0xc,%esp
 361:	57                   	push   %edi
 362:	68 ba 0b 00 00       	push   $0xbba
 367:	6a 01                	push   $0x1
 369:	e8 f2 04 00 00       	call   860 <printf>
 36e:	83 c4 10             	add    $0x10,%esp
}
 371:	8d 65 f4             	lea    -0xc(%ebp),%esp
 374:	5b                   	pop    %ebx
 375:	5e                   	pop    %esi
 376:	5f                   	pop    %edi
 377:	5d                   	pop    %ebp
 378:	c3                   	ret    
 379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printf(2, "Error: write error for %s\n", filename);
 380:	83 ec 04             	sub    $0x4,%esp
 383:	57                   	push   %edi
 384:	68 9f 0b 00 00       	push   $0xb9f
 389:	6a 02                	push   $0x2
 38b:	e8 d0 04 00 00       	call   860 <printf>
        close(fd);
 390:	89 5d 08             	mov    %ebx,0x8(%ebp)
 393:	83 c4 10             	add    $0x10,%esp
}
 396:	8d 65 f4             	lea    -0xc(%ebp),%esp
 399:	5b                   	pop    %ebx
 39a:	5e                   	pop    %esi
 39b:	5f                   	pop    %edi
 39c:	5d                   	pop    %ebp
        close(fd);
 39d:	e9 79 03 00 00       	jmp    71b <close>
 3a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printf(2, "Error: cannot open %s\n", filename);
 3a8:	83 ec 04             	sub    $0x4,%esp
 3ab:	57                   	push   %edi
 3ac:	68 88 0b 00 00       	push   $0xb88
 3b1:	6a 02                	push   $0x2
 3b3:	e8 a8 04 00 00       	call   860 <printf>
        return;
 3b8:	83 c4 10             	add    $0x10,%esp
}
 3bb:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3be:	5b                   	pop    %ebx
 3bf:	5e                   	pop    %esi
 3c0:	5f                   	pop    %edi
 3c1:	5d                   	pop    %ebp
 3c2:	c3                   	ret    
 3c3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000003d0 <matrix_multiply>:
void matrix_multiply(int A[N][N], int B[N][N], int C[N][N]) {
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	57                   	push   %edi
 3d4:	56                   	push   %esi
 3d5:	53                   	push   %ebx
 3d6:	83 ec 0c             	sub    $0xc,%esp
 3d9:	8b 45 0c             	mov    0xc(%ebp),%eax
            for (k = 0; k < N; k++) {
 3dc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 3e3:	83 c0 10             	add    $0x10,%eax
 3e6:	89 45 e8             	mov    %eax,-0x18(%ebp)
        for (j = 0; j < N; j++) {
 3e9:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3ec:	8b 7d 08             	mov    0x8(%ebp),%edi
 3ef:	01 c7                	add    %eax,%edi
 3f1:	03 45 10             	add    0x10(%ebp),%eax
 3f4:	89 c6                	mov    %eax,%esi
 3f6:	8b 45 0c             	mov    0xc(%ebp),%eax
 3f9:	89 45 f0             	mov    %eax,-0x10(%ebp)
            C[i][j] = 0;
 3fc:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
 402:	8b 5d f0             	mov    -0x10(%ebp),%ebx
 405:	31 c9                	xor    %ecx,%ecx
            for (k = 0; k < N; k++) {
 407:	31 c0                	xor    %eax,%eax
                C[i][j] += A[i][k] * B[k][j];
 409:	8b 14 87             	mov    (%edi,%eax,4),%edx
 40c:	0f af 13             	imul   (%ebx),%edx
            for (k = 0; k < N; k++) {
 40f:	83 c0 01             	add    $0x1,%eax
 412:	83 c3 10             	add    $0x10,%ebx
                C[i][j] += A[i][k] * B[k][j];
 415:	01 d1                	add    %edx,%ecx
 417:	89 0e                	mov    %ecx,(%esi)
            for (k = 0; k < N; k++) {
 419:	83 f8 04             	cmp    $0x4,%eax
 41c:	75 eb                	jne    409 <matrix_multiply+0x39>
        for (j = 0; j < N; j++) {
 41e:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
 422:	83 c6 04             	add    $0x4,%esi
 425:	8b 45 f0             	mov    -0x10(%ebp),%eax
 428:	3b 45 e8             	cmp    -0x18(%ebp),%eax
 42b:	75 cf                	jne    3fc <matrix_multiply+0x2c>
    for (i = 0; i < N; i++) {
 42d:	83 45 ec 10          	addl   $0x10,-0x14(%ebp)
 431:	8b 45 ec             	mov    -0x14(%ebp),%eax
 434:	83 f8 40             	cmp    $0x40,%eax
 437:	75 b0                	jne    3e9 <matrix_multiply+0x19>
}
 439:	83 c4 0c             	add    $0xc,%esp
 43c:	5b                   	pop    %ebx
 43d:	5e                   	pop    %esi
 43e:	5f                   	pop    %edi
 43f:	5d                   	pop    %ebp
 440:	c3                   	ret    
 441:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 448:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 44f:	90                   	nop

00000450 <print_matrix>:
void print_matrix(int matrix[N][N]) {
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	57                   	push   %edi
 454:	56                   	push   %esi
 455:	53                   	push   %ebx
 456:	83 ec 0c             	sub    $0xc,%esp
 459:	8b 75 08             	mov    0x8(%ebp),%esi
 45c:	8d 7e 40             	lea    0x40(%esi),%edi
        for (j = 0; j < N; j++) {
 45f:	31 db                	xor    %ebx,%ebx
            printf(1, "%d ", matrix[i][j]);
 461:	83 ec 04             	sub    $0x4,%esp
 464:	ff 34 9e             	push   (%esi,%ebx,4)
        for (j = 0; j < N; j++) {
 467:	83 c3 01             	add    $0x1,%ebx
            printf(1, "%d ", matrix[i][j]);
 46a:	68 d4 0b 00 00       	push   $0xbd4
 46f:	6a 01                	push   $0x1
 471:	e8 ea 03 00 00       	call   860 <printf>
        for (j = 0; j < N; j++) {
 476:	83 c4 10             	add    $0x10,%esp
 479:	83 fb 04             	cmp    $0x4,%ebx
 47c:	75 e3                	jne    461 <print_matrix+0x11>
        printf(1, "\n");
 47e:	83 ec 08             	sub    $0x8,%esp
    for (i = 0; i < N; i++) {
 481:	83 c6 10             	add    $0x10,%esi
        printf(1, "\n");
 484:	68 e1 0b 00 00       	push   $0xbe1
 489:	6a 01                	push   $0x1
 48b:	e8 d0 03 00 00       	call   860 <printf>
    for (i = 0; i < N; i++) {
 490:	83 c4 10             	add    $0x10,%esp
 493:	39 f7                	cmp    %esi,%edi
 495:	75 c8                	jne    45f <print_matrix+0xf>
}
 497:	8d 65 f4             	lea    -0xc(%ebp),%esp
 49a:	5b                   	pop    %ebx
 49b:	5e                   	pop    %esi
 49c:	5f                   	pop    %edi
 49d:	5d                   	pop    %ebp
 49e:	c3                   	ret    
 49f:	90                   	nop

000004a0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 4a0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 4a1:	31 c0                	xor    %eax,%eax
{
 4a3:	89 e5                	mov    %esp,%ebp
 4a5:	53                   	push   %ebx
 4a6:	8b 4d 08             	mov    0x8(%ebp),%ecx
 4a9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 4ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 4b0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 4b4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 4b7:	83 c0 01             	add    $0x1,%eax
 4ba:	84 d2                	test   %dl,%dl
 4bc:	75 f2                	jne    4b0 <strcpy+0x10>
    ;
  return os;
}
 4be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 4c1:	89 c8                	mov    %ecx,%eax
 4c3:	c9                   	leave  
 4c4:	c3                   	ret    
 4c5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000004d0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 4d0:	55                   	push   %ebp
 4d1:	89 e5                	mov    %esp,%ebp
 4d3:	53                   	push   %ebx
 4d4:	8b 55 08             	mov    0x8(%ebp),%edx
 4d7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 4da:	0f b6 02             	movzbl (%edx),%eax
 4dd:	84 c0                	test   %al,%al
 4df:	75 17                	jne    4f8 <strcmp+0x28>
 4e1:	eb 3a                	jmp    51d <strcmp+0x4d>
 4e3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4e7:	90                   	nop
 4e8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 4ec:	83 c2 01             	add    $0x1,%edx
 4ef:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 4f2:	84 c0                	test   %al,%al
 4f4:	74 1a                	je     510 <strcmp+0x40>
    p++, q++;
 4f6:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
 4f8:	0f b6 19             	movzbl (%ecx),%ebx
 4fb:	38 c3                	cmp    %al,%bl
 4fd:	74 e9                	je     4e8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 4ff:	29 d8                	sub    %ebx,%eax
}
 501:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 504:	c9                   	leave  
 505:	c3                   	ret    
 506:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 50d:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 510:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 514:	31 c0                	xor    %eax,%eax
 516:	29 d8                	sub    %ebx,%eax
}
 518:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 51b:	c9                   	leave  
 51c:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
 51d:	0f b6 19             	movzbl (%ecx),%ebx
 520:	31 c0                	xor    %eax,%eax
 522:	eb db                	jmp    4ff <strcmp+0x2f>
 524:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 52b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 52f:	90                   	nop

00000530 <strlen>:

uint
strlen(const char *s)
{
 530:	55                   	push   %ebp
 531:	89 e5                	mov    %esp,%ebp
 533:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 536:	80 3a 00             	cmpb   $0x0,(%edx)
 539:	74 15                	je     550 <strlen+0x20>
 53b:	31 c0                	xor    %eax,%eax
 53d:	8d 76 00             	lea    0x0(%esi),%esi
 540:	83 c0 01             	add    $0x1,%eax
 543:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 547:	89 c1                	mov    %eax,%ecx
 549:	75 f5                	jne    540 <strlen+0x10>
    ;
  return n;
}
 54b:	89 c8                	mov    %ecx,%eax
 54d:	5d                   	pop    %ebp
 54e:	c3                   	ret    
 54f:	90                   	nop
  for(n = 0; s[n]; n++)
 550:	31 c9                	xor    %ecx,%ecx
}
 552:	5d                   	pop    %ebp
 553:	89 c8                	mov    %ecx,%eax
 555:	c3                   	ret    
 556:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 55d:	8d 76 00             	lea    0x0(%esi),%esi

00000560 <memset>:

void*
memset(void *dst, int c, uint n)
{
 560:	55                   	push   %ebp
 561:	89 e5                	mov    %esp,%ebp
 563:	57                   	push   %edi
 564:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 567:	8b 4d 10             	mov    0x10(%ebp),%ecx
 56a:	8b 45 0c             	mov    0xc(%ebp),%eax
 56d:	89 d7                	mov    %edx,%edi
 56f:	fc                   	cld    
 570:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 572:	8b 7d fc             	mov    -0x4(%ebp),%edi
 575:	89 d0                	mov    %edx,%eax
 577:	c9                   	leave  
 578:	c3                   	ret    
 579:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000580 <strchr>:

char*
strchr(const char *s, char c)
{
 580:	55                   	push   %ebp
 581:	89 e5                	mov    %esp,%ebp
 583:	8b 45 08             	mov    0x8(%ebp),%eax
 586:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 58a:	0f b6 10             	movzbl (%eax),%edx
 58d:	84 d2                	test   %dl,%dl
 58f:	75 12                	jne    5a3 <strchr+0x23>
 591:	eb 1d                	jmp    5b0 <strchr+0x30>
 593:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 597:	90                   	nop
 598:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 59c:	83 c0 01             	add    $0x1,%eax
 59f:	84 d2                	test   %dl,%dl
 5a1:	74 0d                	je     5b0 <strchr+0x30>
    if(*s == c)
 5a3:	38 d1                	cmp    %dl,%cl
 5a5:	75 f1                	jne    598 <strchr+0x18>
      return (char*)s;
  return 0;
}
 5a7:	5d                   	pop    %ebp
 5a8:	c3                   	ret    
 5a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 5b0:	31 c0                	xor    %eax,%eax
}
 5b2:	5d                   	pop    %ebp
 5b3:	c3                   	ret    
 5b4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5bf:	90                   	nop

000005c0 <gets>:

char*
gets(char *buf, int max)
{
 5c0:	55                   	push   %ebp
 5c1:	89 e5                	mov    %esp,%ebp
 5c3:	57                   	push   %edi
 5c4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 5c5:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 5c8:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 5c9:	31 db                	xor    %ebx,%ebx
{
 5cb:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 5ce:	eb 27                	jmp    5f7 <gets+0x37>
    cc = read(0, &c, 1);
 5d0:	83 ec 04             	sub    $0x4,%esp
 5d3:	6a 01                	push   $0x1
 5d5:	57                   	push   %edi
 5d6:	6a 00                	push   $0x0
 5d8:	e8 2e 01 00 00       	call   70b <read>
    if(cc < 1)
 5dd:	83 c4 10             	add    $0x10,%esp
 5e0:	85 c0                	test   %eax,%eax
 5e2:	7e 1d                	jle    601 <gets+0x41>
      break;
    buf[i++] = c;
 5e4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 5e8:	8b 55 08             	mov    0x8(%ebp),%edx
 5eb:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 5ef:	3c 0a                	cmp    $0xa,%al
 5f1:	74 1d                	je     610 <gets+0x50>
 5f3:	3c 0d                	cmp    $0xd,%al
 5f5:	74 19                	je     610 <gets+0x50>
  for(i=0; i+1 < max; ){
 5f7:	89 de                	mov    %ebx,%esi
 5f9:	83 c3 01             	add    $0x1,%ebx
 5fc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 5ff:	7c cf                	jl     5d0 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 601:	8b 45 08             	mov    0x8(%ebp),%eax
 604:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 608:	8d 65 f4             	lea    -0xc(%ebp),%esp
 60b:	5b                   	pop    %ebx
 60c:	5e                   	pop    %esi
 60d:	5f                   	pop    %edi
 60e:	5d                   	pop    %ebp
 60f:	c3                   	ret    
  buf[i] = '\0';
 610:	8b 45 08             	mov    0x8(%ebp),%eax
 613:	89 de                	mov    %ebx,%esi
 615:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 619:	8d 65 f4             	lea    -0xc(%ebp),%esp
 61c:	5b                   	pop    %ebx
 61d:	5e                   	pop    %esi
 61e:	5f                   	pop    %edi
 61f:	5d                   	pop    %ebp
 620:	c3                   	ret    
 621:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 628:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 62f:	90                   	nop

00000630 <stat>:

int
stat(const char *n, struct stat *st)
{
 630:	55                   	push   %ebp
 631:	89 e5                	mov    %esp,%ebp
 633:	56                   	push   %esi
 634:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 635:	83 ec 08             	sub    $0x8,%esp
 638:	6a 00                	push   $0x0
 63a:	ff 75 08             	push   0x8(%ebp)
 63d:	e8 f1 00 00 00       	call   733 <open>
  if(fd < 0)
 642:	83 c4 10             	add    $0x10,%esp
 645:	85 c0                	test   %eax,%eax
 647:	78 27                	js     670 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 649:	83 ec 08             	sub    $0x8,%esp
 64c:	ff 75 0c             	push   0xc(%ebp)
 64f:	89 c3                	mov    %eax,%ebx
 651:	50                   	push   %eax
 652:	e8 f4 00 00 00       	call   74b <fstat>
  close(fd);
 657:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 65a:	89 c6                	mov    %eax,%esi
  close(fd);
 65c:	e8 ba 00 00 00       	call   71b <close>
  return r;
 661:	83 c4 10             	add    $0x10,%esp
}
 664:	8d 65 f8             	lea    -0x8(%ebp),%esp
 667:	89 f0                	mov    %esi,%eax
 669:	5b                   	pop    %ebx
 66a:	5e                   	pop    %esi
 66b:	5d                   	pop    %ebp
 66c:	c3                   	ret    
 66d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 670:	be ff ff ff ff       	mov    $0xffffffff,%esi
 675:	eb ed                	jmp    664 <stat+0x34>
 677:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 67e:	66 90                	xchg   %ax,%ax

00000680 <atoi>:

int
atoi(const char *s)
{
 680:	55                   	push   %ebp
 681:	89 e5                	mov    %esp,%ebp
 683:	53                   	push   %ebx
 684:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 687:	0f be 02             	movsbl (%edx),%eax
 68a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 68d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 690:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 695:	77 1e                	ja     6b5 <atoi+0x35>
 697:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 69e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 6a0:	83 c2 01             	add    $0x1,%edx
 6a3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 6a6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 6aa:	0f be 02             	movsbl (%edx),%eax
 6ad:	8d 58 d0             	lea    -0x30(%eax),%ebx
 6b0:	80 fb 09             	cmp    $0x9,%bl
 6b3:	76 eb                	jbe    6a0 <atoi+0x20>
  return n;
}
 6b5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 6b8:	89 c8                	mov    %ecx,%eax
 6ba:	c9                   	leave  
 6bb:	c3                   	ret    
 6bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000006c0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 6c0:	55                   	push   %ebp
 6c1:	89 e5                	mov    %esp,%ebp
 6c3:	57                   	push   %edi
 6c4:	8b 45 10             	mov    0x10(%ebp),%eax
 6c7:	8b 55 08             	mov    0x8(%ebp),%edx
 6ca:	56                   	push   %esi
 6cb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 6ce:	85 c0                	test   %eax,%eax
 6d0:	7e 13                	jle    6e5 <memmove+0x25>
 6d2:	01 d0                	add    %edx,%eax
  dst = vdst;
 6d4:	89 d7                	mov    %edx,%edi
 6d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6dd:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 6e0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 6e1:	39 f8                	cmp    %edi,%eax
 6e3:	75 fb                	jne    6e0 <memmove+0x20>
  return vdst;
}
 6e5:	5e                   	pop    %esi
 6e6:	89 d0                	mov    %edx,%eax
 6e8:	5f                   	pop    %edi
 6e9:	5d                   	pop    %ebp
 6ea:	c3                   	ret    

000006eb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 6eb:	b8 01 00 00 00       	mov    $0x1,%eax
 6f0:	cd 40                	int    $0x40
 6f2:	c3                   	ret    

000006f3 <exit>:
SYSCALL(exit)
 6f3:	b8 02 00 00 00       	mov    $0x2,%eax
 6f8:	cd 40                	int    $0x40
 6fa:	c3                   	ret    

000006fb <wait>:
SYSCALL(wait)
 6fb:	b8 03 00 00 00       	mov    $0x3,%eax
 700:	cd 40                	int    $0x40
 702:	c3                   	ret    

00000703 <pipe>:
SYSCALL(pipe)
 703:	b8 04 00 00 00       	mov    $0x4,%eax
 708:	cd 40                	int    $0x40
 70a:	c3                   	ret    

0000070b <read>:
SYSCALL(read)
 70b:	b8 05 00 00 00       	mov    $0x5,%eax
 710:	cd 40                	int    $0x40
 712:	c3                   	ret    

00000713 <write>:
SYSCALL(write)
 713:	b8 10 00 00 00       	mov    $0x10,%eax
 718:	cd 40                	int    $0x40
 71a:	c3                   	ret    

0000071b <close>:
SYSCALL(close)
 71b:	b8 15 00 00 00       	mov    $0x15,%eax
 720:	cd 40                	int    $0x40
 722:	c3                   	ret    

00000723 <kill>:
SYSCALL(kill)
 723:	b8 06 00 00 00       	mov    $0x6,%eax
 728:	cd 40                	int    $0x40
 72a:	c3                   	ret    

0000072b <exec>:
SYSCALL(exec)
 72b:	b8 07 00 00 00       	mov    $0x7,%eax
 730:	cd 40                	int    $0x40
 732:	c3                   	ret    

00000733 <open>:
SYSCALL(open)
 733:	b8 0f 00 00 00       	mov    $0xf,%eax
 738:	cd 40                	int    $0x40
 73a:	c3                   	ret    

0000073b <mknod>:
SYSCALL(mknod)
 73b:	b8 11 00 00 00       	mov    $0x11,%eax
 740:	cd 40                	int    $0x40
 742:	c3                   	ret    

00000743 <unlink>:
SYSCALL(unlink)
 743:	b8 12 00 00 00       	mov    $0x12,%eax
 748:	cd 40                	int    $0x40
 74a:	c3                   	ret    

0000074b <fstat>:
SYSCALL(fstat)
 74b:	b8 08 00 00 00       	mov    $0x8,%eax
 750:	cd 40                	int    $0x40
 752:	c3                   	ret    

00000753 <link>:
SYSCALL(link)
 753:	b8 13 00 00 00       	mov    $0x13,%eax
 758:	cd 40                	int    $0x40
 75a:	c3                   	ret    

0000075b <mkdir>:
SYSCALL(mkdir)
 75b:	b8 14 00 00 00       	mov    $0x14,%eax
 760:	cd 40                	int    $0x40
 762:	c3                   	ret    

00000763 <chdir>:
SYSCALL(chdir)
 763:	b8 09 00 00 00       	mov    $0x9,%eax
 768:	cd 40                	int    $0x40
 76a:	c3                   	ret    

0000076b <dup>:
SYSCALL(dup)
 76b:	b8 0a 00 00 00       	mov    $0xa,%eax
 770:	cd 40                	int    $0x40
 772:	c3                   	ret    

00000773 <getpid>:
SYSCALL(getpid)
 773:	b8 0b 00 00 00       	mov    $0xb,%eax
 778:	cd 40                	int    $0x40
 77a:	c3                   	ret    

0000077b <sbrk>:
SYSCALL(sbrk)
 77b:	b8 0c 00 00 00       	mov    $0xc,%eax
 780:	cd 40                	int    $0x40
 782:	c3                   	ret    

00000783 <sleep>:
SYSCALL(sleep)
 783:	b8 0d 00 00 00       	mov    $0xd,%eax
 788:	cd 40                	int    $0x40
 78a:	c3                   	ret    

0000078b <uptime>:
SYSCALL(uptime)
 78b:	b8 0e 00 00 00       	mov    $0xe,%eax
 790:	cd 40                	int    $0x40
 792:	c3                   	ret    

00000793 <ps>:
SYSCALL(ps)
 793:	b8 16 00 00 00       	mov    $0x16,%eax
 798:	cd 40                	int    $0x40
 79a:	c3                   	ret    

0000079b <sys_ps>:

// usys.S
.globl sys_ps
sys_ps:
    movl SYS_ps, %eax
 79b:	a1 16 00 00 00       	mov    0x16,%eax
    int $64
 7a0:	cd 40                	int    $0x40
    ret
 7a2:	c3                   	ret    
 7a3:	66 90                	xchg   %ax,%ax
 7a5:	66 90                	xchg   %ax,%ax
 7a7:	66 90                	xchg   %ax,%ax
 7a9:	66 90                	xchg   %ax,%ax
 7ab:	66 90                	xchg   %ax,%ax
 7ad:	66 90                	xchg   %ax,%ax
 7af:	90                   	nop

000007b0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 7b0:	55                   	push   %ebp
 7b1:	89 e5                	mov    %esp,%ebp
 7b3:	57                   	push   %edi
 7b4:	56                   	push   %esi
 7b5:	53                   	push   %ebx
 7b6:	83 ec 3c             	sub    $0x3c,%esp
 7b9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 7bc:	89 d1                	mov    %edx,%ecx
{
 7be:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 7c1:	85 d2                	test   %edx,%edx
 7c3:	0f 89 7f 00 00 00    	jns    848 <printint+0x98>
 7c9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 7cd:	74 79                	je     848 <printint+0x98>
    neg = 1;
 7cf:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 7d6:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 7d8:	31 db                	xor    %ebx,%ebx
 7da:	8d 75 d7             	lea    -0x29(%ebp),%esi
 7dd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 7e0:	89 c8                	mov    %ecx,%eax
 7e2:	31 d2                	xor    %edx,%edx
 7e4:	89 cf                	mov    %ecx,%edi
 7e6:	f7 75 c4             	divl   -0x3c(%ebp)
 7e9:	0f b6 92 ac 0c 00 00 	movzbl 0xcac(%edx),%edx
 7f0:	89 45 c0             	mov    %eax,-0x40(%ebp)
 7f3:	89 d8                	mov    %ebx,%eax
 7f5:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 7f8:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 7fb:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 7fe:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 801:	76 dd                	jbe    7e0 <printint+0x30>
  if(neg)
 803:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 806:	85 c9                	test   %ecx,%ecx
 808:	74 0c                	je     816 <printint+0x66>
    buf[i++] = '-';
 80a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 80f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 811:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 816:	8b 7d b8             	mov    -0x48(%ebp),%edi
 819:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 81d:	eb 07                	jmp    826 <printint+0x76>
 81f:	90                   	nop
    putc(fd, buf[i]);
 820:	0f b6 13             	movzbl (%ebx),%edx
 823:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 826:	83 ec 04             	sub    $0x4,%esp
 829:	88 55 d7             	mov    %dl,-0x29(%ebp)
 82c:	6a 01                	push   $0x1
 82e:	56                   	push   %esi
 82f:	57                   	push   %edi
 830:	e8 de fe ff ff       	call   713 <write>
  while(--i >= 0)
 835:	83 c4 10             	add    $0x10,%esp
 838:	39 de                	cmp    %ebx,%esi
 83a:	75 e4                	jne    820 <printint+0x70>
}
 83c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 83f:	5b                   	pop    %ebx
 840:	5e                   	pop    %esi
 841:	5f                   	pop    %edi
 842:	5d                   	pop    %ebp
 843:	c3                   	ret    
 844:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 848:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 84f:	eb 87                	jmp    7d8 <printint+0x28>
 851:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 858:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 85f:	90                   	nop

00000860 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 860:	55                   	push   %ebp
 861:	89 e5                	mov    %esp,%ebp
 863:	57                   	push   %edi
 864:	56                   	push   %esi
 865:	53                   	push   %ebx
 866:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 869:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 86c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 86f:	0f b6 13             	movzbl (%ebx),%edx
 872:	84 d2                	test   %dl,%dl
 874:	74 6a                	je     8e0 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
 876:	8d 45 10             	lea    0x10(%ebp),%eax
 879:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 87c:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 87f:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
 881:	89 45 d0             	mov    %eax,-0x30(%ebp)
 884:	eb 36                	jmp    8bc <printf+0x5c>
 886:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 88d:	8d 76 00             	lea    0x0(%esi),%esi
 890:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 893:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
 898:	83 f8 25             	cmp    $0x25,%eax
 89b:	74 15                	je     8b2 <printf+0x52>
  write(fd, &c, 1);
 89d:	83 ec 04             	sub    $0x4,%esp
 8a0:	88 55 e7             	mov    %dl,-0x19(%ebp)
 8a3:	6a 01                	push   $0x1
 8a5:	57                   	push   %edi
 8a6:	56                   	push   %esi
 8a7:	e8 67 fe ff ff       	call   713 <write>
 8ac:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
 8af:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 8b2:	0f b6 13             	movzbl (%ebx),%edx
 8b5:	83 c3 01             	add    $0x1,%ebx
 8b8:	84 d2                	test   %dl,%dl
 8ba:	74 24                	je     8e0 <printf+0x80>
    c = fmt[i] & 0xff;
 8bc:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 8bf:	85 c9                	test   %ecx,%ecx
 8c1:	74 cd                	je     890 <printf+0x30>
      }
    } else if(state == '%'){
 8c3:	83 f9 25             	cmp    $0x25,%ecx
 8c6:	75 ea                	jne    8b2 <printf+0x52>
      if(c == 'd'){
 8c8:	83 f8 25             	cmp    $0x25,%eax
 8cb:	0f 84 07 01 00 00    	je     9d8 <printf+0x178>
 8d1:	83 e8 63             	sub    $0x63,%eax
 8d4:	83 f8 15             	cmp    $0x15,%eax
 8d7:	77 17                	ja     8f0 <printf+0x90>
 8d9:	ff 24 85 54 0c 00 00 	jmp    *0xc54(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 8e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
 8e3:	5b                   	pop    %ebx
 8e4:	5e                   	pop    %esi
 8e5:	5f                   	pop    %edi
 8e6:	5d                   	pop    %ebp
 8e7:	c3                   	ret    
 8e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8ef:	90                   	nop
  write(fd, &c, 1);
 8f0:	83 ec 04             	sub    $0x4,%esp
 8f3:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 8f6:	6a 01                	push   $0x1
 8f8:	57                   	push   %edi
 8f9:	56                   	push   %esi
 8fa:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 8fe:	e8 10 fe ff ff       	call   713 <write>
        putc(fd, c);
 903:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 907:	83 c4 0c             	add    $0xc,%esp
 90a:	88 55 e7             	mov    %dl,-0x19(%ebp)
 90d:	6a 01                	push   $0x1
 90f:	57                   	push   %edi
 910:	56                   	push   %esi
 911:	e8 fd fd ff ff       	call   713 <write>
        putc(fd, c);
 916:	83 c4 10             	add    $0x10,%esp
      state = 0;
 919:	31 c9                	xor    %ecx,%ecx
 91b:	eb 95                	jmp    8b2 <printf+0x52>
 91d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 920:	83 ec 0c             	sub    $0xc,%esp
 923:	b9 10 00 00 00       	mov    $0x10,%ecx
 928:	6a 00                	push   $0x0
 92a:	8b 45 d0             	mov    -0x30(%ebp),%eax
 92d:	8b 10                	mov    (%eax),%edx
 92f:	89 f0                	mov    %esi,%eax
 931:	e8 7a fe ff ff       	call   7b0 <printint>
        ap++;
 936:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 93a:	83 c4 10             	add    $0x10,%esp
      state = 0;
 93d:	31 c9                	xor    %ecx,%ecx
 93f:	e9 6e ff ff ff       	jmp    8b2 <printf+0x52>
 944:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 948:	8b 45 d0             	mov    -0x30(%ebp),%eax
 94b:	8b 10                	mov    (%eax),%edx
        ap++;
 94d:	83 c0 04             	add    $0x4,%eax
 950:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 953:	85 d2                	test   %edx,%edx
 955:	0f 84 8d 00 00 00    	je     9e8 <printf+0x188>
        while(*s != 0){
 95b:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
 95e:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
 960:	84 c0                	test   %al,%al
 962:	0f 84 4a ff ff ff    	je     8b2 <printf+0x52>
 968:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 96b:	89 d3                	mov    %edx,%ebx
 96d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 970:	83 ec 04             	sub    $0x4,%esp
          s++;
 973:	83 c3 01             	add    $0x1,%ebx
 976:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 979:	6a 01                	push   $0x1
 97b:	57                   	push   %edi
 97c:	56                   	push   %esi
 97d:	e8 91 fd ff ff       	call   713 <write>
        while(*s != 0){
 982:	0f b6 03             	movzbl (%ebx),%eax
 985:	83 c4 10             	add    $0x10,%esp
 988:	84 c0                	test   %al,%al
 98a:	75 e4                	jne    970 <printf+0x110>
      state = 0;
 98c:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 98f:	31 c9                	xor    %ecx,%ecx
 991:	e9 1c ff ff ff       	jmp    8b2 <printf+0x52>
 996:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 99d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 9a0:	83 ec 0c             	sub    $0xc,%esp
 9a3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 9a8:	6a 01                	push   $0x1
 9aa:	e9 7b ff ff ff       	jmp    92a <printf+0xca>
 9af:	90                   	nop
        putc(fd, *ap);
 9b0:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
 9b3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 9b6:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 9b8:	6a 01                	push   $0x1
 9ba:	57                   	push   %edi
 9bb:	56                   	push   %esi
        putc(fd, *ap);
 9bc:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 9bf:	e8 4f fd ff ff       	call   713 <write>
        ap++;
 9c4:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 9c8:	83 c4 10             	add    $0x10,%esp
      state = 0;
 9cb:	31 c9                	xor    %ecx,%ecx
 9cd:	e9 e0 fe ff ff       	jmp    8b2 <printf+0x52>
 9d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
 9d8:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 9db:	83 ec 04             	sub    $0x4,%esp
 9de:	e9 2a ff ff ff       	jmp    90d <printf+0xad>
 9e3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 9e7:	90                   	nop
          s = "(null)";
 9e8:	ba 4c 0c 00 00       	mov    $0xc4c,%edx
        while(*s != 0){
 9ed:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 9f0:	b8 28 00 00 00       	mov    $0x28,%eax
 9f5:	89 d3                	mov    %edx,%ebx
 9f7:	e9 74 ff ff ff       	jmp    970 <printf+0x110>
 9fc:	66 90                	xchg   %ax,%ax
 9fe:	66 90                	xchg   %ax,%ax

00000a00 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a00:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a01:	a1 70 10 00 00       	mov    0x1070,%eax
{
 a06:	89 e5                	mov    %esp,%ebp
 a08:	57                   	push   %edi
 a09:	56                   	push   %esi
 a0a:	53                   	push   %ebx
 a0b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 a0e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a18:	89 c2                	mov    %eax,%edx
 a1a:	8b 00                	mov    (%eax),%eax
 a1c:	39 ca                	cmp    %ecx,%edx
 a1e:	73 30                	jae    a50 <free+0x50>
 a20:	39 c1                	cmp    %eax,%ecx
 a22:	72 04                	jb     a28 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a24:	39 c2                	cmp    %eax,%edx
 a26:	72 f0                	jb     a18 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 a28:	8b 73 fc             	mov    -0x4(%ebx),%esi
 a2b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 a2e:	39 f8                	cmp    %edi,%eax
 a30:	74 30                	je     a62 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 a32:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 a35:	8b 42 04             	mov    0x4(%edx),%eax
 a38:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 a3b:	39 f1                	cmp    %esi,%ecx
 a3d:	74 3a                	je     a79 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 a3f:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 a41:	5b                   	pop    %ebx
  freep = p;
 a42:	89 15 70 10 00 00    	mov    %edx,0x1070
}
 a48:	5e                   	pop    %esi
 a49:	5f                   	pop    %edi
 a4a:	5d                   	pop    %ebp
 a4b:	c3                   	ret    
 a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a50:	39 c2                	cmp    %eax,%edx
 a52:	72 c4                	jb     a18 <free+0x18>
 a54:	39 c1                	cmp    %eax,%ecx
 a56:	73 c0                	jae    a18 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
 a58:	8b 73 fc             	mov    -0x4(%ebx),%esi
 a5b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 a5e:	39 f8                	cmp    %edi,%eax
 a60:	75 d0                	jne    a32 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
 a62:	03 70 04             	add    0x4(%eax),%esi
 a65:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 a68:	8b 02                	mov    (%edx),%eax
 a6a:	8b 00                	mov    (%eax),%eax
 a6c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 a6f:	8b 42 04             	mov    0x4(%edx),%eax
 a72:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 a75:	39 f1                	cmp    %esi,%ecx
 a77:	75 c6                	jne    a3f <free+0x3f>
    p->s.size += bp->s.size;
 a79:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 a7c:	89 15 70 10 00 00    	mov    %edx,0x1070
    p->s.size += bp->s.size;
 a82:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 a85:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 a88:	89 0a                	mov    %ecx,(%edx)
}
 a8a:	5b                   	pop    %ebx
 a8b:	5e                   	pop    %esi
 a8c:	5f                   	pop    %edi
 a8d:	5d                   	pop    %ebp
 a8e:	c3                   	ret    
 a8f:	90                   	nop

00000a90 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a90:	55                   	push   %ebp
 a91:	89 e5                	mov    %esp,%ebp
 a93:	57                   	push   %edi
 a94:	56                   	push   %esi
 a95:	53                   	push   %ebx
 a96:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a99:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 a9c:	8b 3d 70 10 00 00    	mov    0x1070,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 aa2:	8d 70 07             	lea    0x7(%eax),%esi
 aa5:	c1 ee 03             	shr    $0x3,%esi
 aa8:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 aab:	85 ff                	test   %edi,%edi
 aad:	0f 84 9d 00 00 00    	je     b50 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ab3:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 ab5:	8b 4a 04             	mov    0x4(%edx),%ecx
 ab8:	39 f1                	cmp    %esi,%ecx
 aba:	73 6a                	jae    b26 <malloc+0x96>
 abc:	bb 00 10 00 00       	mov    $0x1000,%ebx
 ac1:	39 de                	cmp    %ebx,%esi
 ac3:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 ac6:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 acd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 ad0:	eb 17                	jmp    ae9 <malloc+0x59>
 ad2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ad8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 ada:	8b 48 04             	mov    0x4(%eax),%ecx
 add:	39 f1                	cmp    %esi,%ecx
 adf:	73 4f                	jae    b30 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 ae1:	8b 3d 70 10 00 00    	mov    0x1070,%edi
 ae7:	89 c2                	mov    %eax,%edx
 ae9:	39 d7                	cmp    %edx,%edi
 aeb:	75 eb                	jne    ad8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 aed:	83 ec 0c             	sub    $0xc,%esp
 af0:	ff 75 e4             	push   -0x1c(%ebp)
 af3:	e8 83 fc ff ff       	call   77b <sbrk>
  if(p == (char*)-1)
 af8:	83 c4 10             	add    $0x10,%esp
 afb:	83 f8 ff             	cmp    $0xffffffff,%eax
 afe:	74 1c                	je     b1c <malloc+0x8c>
  hp->s.size = nu;
 b00:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 b03:	83 ec 0c             	sub    $0xc,%esp
 b06:	83 c0 08             	add    $0x8,%eax
 b09:	50                   	push   %eax
 b0a:	e8 f1 fe ff ff       	call   a00 <free>
  return freep;
 b0f:	8b 15 70 10 00 00    	mov    0x1070,%edx
      if((p = morecore(nunits)) == 0)
 b15:	83 c4 10             	add    $0x10,%esp
 b18:	85 d2                	test   %edx,%edx
 b1a:	75 bc                	jne    ad8 <malloc+0x48>
        return 0;
  }
}
 b1c:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 b1f:	31 c0                	xor    %eax,%eax
}
 b21:	5b                   	pop    %ebx
 b22:	5e                   	pop    %esi
 b23:	5f                   	pop    %edi
 b24:	5d                   	pop    %ebp
 b25:	c3                   	ret    
    if(p->s.size >= nunits){
 b26:	89 d0                	mov    %edx,%eax
 b28:	89 fa                	mov    %edi,%edx
 b2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 b30:	39 ce                	cmp    %ecx,%esi
 b32:	74 4c                	je     b80 <malloc+0xf0>
        p->s.size -= nunits;
 b34:	29 f1                	sub    %esi,%ecx
 b36:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 b39:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 b3c:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 b3f:	89 15 70 10 00 00    	mov    %edx,0x1070
}
 b45:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 b48:	83 c0 08             	add    $0x8,%eax
}
 b4b:	5b                   	pop    %ebx
 b4c:	5e                   	pop    %esi
 b4d:	5f                   	pop    %edi
 b4e:	5d                   	pop    %ebp
 b4f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 b50:	c7 05 70 10 00 00 74 	movl   $0x1074,0x1070
 b57:	10 00 00 
    base.s.size = 0;
 b5a:	bf 74 10 00 00       	mov    $0x1074,%edi
    base.s.ptr = freep = prevp = &base;
 b5f:	c7 05 74 10 00 00 74 	movl   $0x1074,0x1074
 b66:	10 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b69:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 b6b:	c7 05 78 10 00 00 00 	movl   $0x0,0x1078
 b72:	00 00 00 
    if(p->s.size >= nunits){
 b75:	e9 42 ff ff ff       	jmp    abc <malloc+0x2c>
 b7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 b80:	8b 08                	mov    (%eax),%ecx
 b82:	89 0a                	mov    %ecx,(%edx)
 b84:	eb b9                	jmp    b3f <malloc+0xaf>
