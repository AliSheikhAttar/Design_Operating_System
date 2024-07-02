
_diskwriteL:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
    // Close the file
    close(fd);
    printf(1, "Successfully wrote to %s\n", filename); // Debugging print
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
  11:	83 ec 28             	sub    $0x28,%esp
  14:	8b 01                	mov    (%ecx),%eax
  16:	8b 51 04             	mov    0x4(%ecx),%edx
    if (argc < 2) {
  19:	83 f8 01             	cmp    $0x1,%eax
  1c:	7e 3a                	jle    58 <main+0x58>
        // Print usage message to stderr (fd 2)
        printf(2, "Usage: create_files <text> [start_index]\n");
        exit();
    }

    char *text = argv[1];
  1e:	8b 72 04             	mov    0x4(%edx),%esi
    int start_index = 1;
  21:	bb 01 00 00 00       	mov    $0x1,%ebx

    if (argc == 3) {
  26:	83 f8 03             	cmp    $0x3,%eax
  29:	74 40                	je     6b <main+0x6b>
  2b:	8d 7d d4             	lea    -0x2c(%ebp),%edi
  2e:	66 90                	xchg   %ax,%ax
        start_index = atoi(argv[2]);
    }

    for (int i = start_index; i <= 100; i++) {
        char filename[20]; // Sufficient buffer size for "fileX.txt" where X is up to 100
        create_filename("file", i, filename);
  30:	83 ec 04             	sub    $0x4,%esp
  33:	57                   	push   %edi
  34:	53                   	push   %ebx
    for (int i = start_index; i <= 100; i++) {
  35:	83 c3 01             	add    $0x1,%ebx
        create_filename("file", i, filename);
  38:	68 54 0a 00 00       	push   $0xa54
  3d:	e8 de 00 00 00       	call   120 <create_filename>

        // Write to the file directly
        write_to_file(filename, text);
  42:	58                   	pop    %eax
  43:	5a                   	pop    %edx
  44:	56                   	push   %esi
  45:	57                   	push   %edi
  46:	e8 15 02 00 00       	call   260 <write_to_file>
    for (int i = start_index; i <= 100; i++) {
  4b:	83 c4 10             	add    $0x10,%esp
  4e:	83 fb 65             	cmp    $0x65,%ebx
  51:	75 dd                	jne    30 <main+0x30>
    }

    exit();
  53:	e8 1b 05 00 00       	call   573 <exit>
        printf(2, "Usage: create_files <text> [start_index]\n");
  58:	51                   	push   %ecx
  59:	51                   	push   %ecx
  5a:	68 5c 0a 00 00       	push   $0xa5c
  5f:	6a 02                	push   $0x2
  61:	e8 7a 06 00 00       	call   6e0 <printf>
        exit();
  66:	e8 08 05 00 00       	call   573 <exit>
        start_index = atoi(argv[2]);
  6b:	83 ec 0c             	sub    $0xc,%esp
  6e:	ff 72 08             	push   0x8(%edx)
  71:	e8 8a 04 00 00       	call   500 <atoi>
    for (int i = start_index; i <= 100; i++) {
  76:	83 c4 10             	add    $0x10,%esp
        start_index = atoi(argv[2]);
  79:	89 c3                	mov    %eax,%ebx
    for (int i = start_index; i <= 100; i++) {
  7b:	83 f8 64             	cmp    $0x64,%eax
  7e:	7e ab                	jle    2b <main+0x2b>
  80:	eb d1                	jmp    53 <main+0x53>
  82:	66 90                	xchg   %ax,%ax
  84:	66 90                	xchg   %ax,%ax
  86:	66 90                	xchg   %ax,%ax
  88:	66 90                	xchg   %ax,%ax
  8a:	66 90                	xchg   %ax,%ax
  8c:	66 90                	xchg   %ax,%ax
  8e:	66 90                	xchg   %ax,%ax

00000090 <int_to_str>:
void int_to_str(int n, char *str) {
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	57                   	push   %edi
  94:	8b 4d 08             	mov    0x8(%ebp),%ecx
  97:	56                   	push   %esi
  98:	53                   	push   %ebx
    if (n == 0) {
  99:	85 c9                	test   %ecx,%ecx
  9b:	74 63                	je     100 <int_to_str+0x70>
    while (temp_n > 0) {
  9d:	89 ca                	mov    %ecx,%edx
    int len = 0;
  9f:	be 00 00 00 00       	mov    $0x0,%esi
    while (temp_n > 0) {
  a4:	7e 6a                	jle    110 <int_to_str+0x80>
  a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ad:	8d 76 00             	lea    0x0(%esi),%esi
        temp_n /= 10;
  b0:	b8 cd cc cc cc       	mov    $0xcccccccd,%eax
  b5:	89 d7                	mov    %edx,%edi
  b7:	89 f3                	mov    %esi,%ebx
        len++;
  b9:	83 c6 01             	add    $0x1,%esi
        temp_n /= 10;
  bc:	f7 e2                	mul    %edx
  be:	c1 ea 03             	shr    $0x3,%edx
    while (temp_n > 0) {
  c1:	83 ff 09             	cmp    $0x9,%edi
  c4:	7f ea                	jg     b0 <int_to_str+0x20>
    str[len] = '\0';
  c6:	8b 45 0c             	mov    0xc(%ebp),%eax
  c9:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
    while (n > 0) {
  cd:	01 c3                	add    %eax,%ebx
        str[--len] = (n % 10) + '0';
  cf:	be cd cc cc cc       	mov    $0xcccccccd,%esi
  d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  d8:	89 c8                	mov    %ecx,%eax
    while (n > 0) {
  da:	83 eb 01             	sub    $0x1,%ebx
        str[--len] = (n % 10) + '0';
  dd:	f7 e6                	mul    %esi
  df:	89 c8                	mov    %ecx,%eax
  e1:	c1 ea 03             	shr    $0x3,%edx
  e4:	8d 3c 92             	lea    (%edx,%edx,4),%edi
  e7:	01 ff                	add    %edi,%edi
  e9:	29 f8                	sub    %edi,%eax
  eb:	83 c0 30             	add    $0x30,%eax
  ee:	88 43 01             	mov    %al,0x1(%ebx)
        n /= 10;
  f1:	89 c8                	mov    %ecx,%eax
  f3:	89 d1                	mov    %edx,%ecx
    while (n > 0) {
  f5:	83 f8 09             	cmp    $0x9,%eax
  f8:	7f de                	jg     d8 <int_to_str+0x48>
}
  fa:	5b                   	pop    %ebx
  fb:	5e                   	pop    %esi
  fc:	5f                   	pop    %edi
  fd:	5d                   	pop    %ebp
  fe:	c3                   	ret    
  ff:	90                   	nop
        str[0] = '0';
 100:	8b 45 0c             	mov    0xc(%ebp),%eax
 103:	ba 30 00 00 00       	mov    $0x30,%edx
 108:	66 89 10             	mov    %dx,(%eax)
}
 10b:	5b                   	pop    %ebx
 10c:	5e                   	pop    %esi
 10d:	5f                   	pop    %edi
 10e:	5d                   	pop    %ebp
 10f:	c3                   	ret    
    str[len] = '\0';
 110:	8b 45 0c             	mov    0xc(%ebp),%eax
 113:	c6 00 00             	movb   $0x0,(%eax)
    while (n > 0) {
 116:	eb e2                	jmp    fa <int_to_str+0x6a>
 118:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 11f:	90                   	nop

00000120 <create_filename>:
void create_filename(char *base, int num, char *filename) {
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	57                   	push   %edi
 124:	56                   	push   %esi
 125:	53                   	push   %ebx
 126:	83 ec 1c             	sub    $0x1c,%esp
 129:	8b 75 08             	mov    0x8(%ebp),%esi
 12c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    while (base[i] != '\0') {
 12f:	0f b6 06             	movzbl (%esi),%eax
 132:	84 c0                	test   %al,%al
 134:	0f 84 06 01 00 00    	je     240 <create_filename+0x120>
    int i = 0;
 13a:	8b 7d 10             	mov    0x10(%ebp),%edi
 13d:	31 c9                	xor    %ecx,%ecx
 13f:	90                   	nop
        filename[i] = base[i];
 140:	88 04 0f             	mov    %al,(%edi,%ecx,1)
        i++;
 143:	89 ca                	mov    %ecx,%edx
 145:	83 c1 01             	add    $0x1,%ecx
    while (base[i] != '\0') {
 148:	0f b6 04 0e          	movzbl (%esi,%ecx,1),%eax
 14c:	84 c0                	test   %al,%al
 14e:	75 f0                	jne    140 <create_filename+0x20>
    filename[i++] = '.';
 150:	8b 45 10             	mov    0x10(%ebp),%eax
 153:	01 c8                	add    %ecx,%eax
 155:	89 45 e0             	mov    %eax,-0x20(%ebp)
 158:	8d 42 02             	lea    0x2(%edx),%eax
 15b:	89 45 dc             	mov    %eax,-0x24(%ebp)
    if (n == 0) {
 15e:	85 db                	test   %ebx,%ebx
 160:	0f 84 ca 00 00 00    	je     230 <create_filename+0x110>
    while (temp_n > 0) {
 166:	89 da                	mov    %ebx,%edx
    int len = 0;
 168:	be 00 00 00 00       	mov    $0x0,%esi
    while (temp_n > 0) {
 16d:	0f 8e 95 00 00 00    	jle    208 <create_filename+0xe8>
 173:	89 4d d8             	mov    %ecx,-0x28(%ebp)
 176:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 17d:	8d 76 00             	lea    0x0(%esi),%esi
        temp_n /= 10;
 180:	b8 cd cc cc cc       	mov    $0xcccccccd,%eax
 185:	89 d1                	mov    %edx,%ecx
 187:	89 f7                	mov    %esi,%edi
        len++;
 189:	83 c6 01             	add    $0x1,%esi
        temp_n /= 10;
 18c:	f7 e2                	mul    %edx
 18e:	c1 ea 03             	shr    $0x3,%edx
    while (temp_n > 0) {
 191:	83 f9 09             	cmp    $0x9,%ecx
 194:	7f ea                	jg     180 <create_filename+0x60>
    str[len] = '\0';
 196:	c6 44 35 ea 00       	movb   $0x0,-0x16(%ebp,%esi,1)
 19b:	8b 4d d8             	mov    -0x28(%ebp),%ecx
    while (n > 0) {
 19e:	8d 75 ea             	lea    -0x16(%ebp),%esi
 1a1:	01 fe                	add    %edi,%esi
 1a3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1a7:	90                   	nop
        str[--len] = (n % 10) + '0';
 1a8:	b8 cd cc cc cc       	mov    $0xcccccccd,%eax
    while (n > 0) {
 1ad:	83 ee 01             	sub    $0x1,%esi
        str[--len] = (n % 10) + '0';
 1b0:	f7 e3                	mul    %ebx
 1b2:	89 d8                	mov    %ebx,%eax
 1b4:	c1 ea 03             	shr    $0x3,%edx
 1b7:	8d 3c 92             	lea    (%edx,%edx,4),%edi
 1ba:	01 ff                	add    %edi,%edi
 1bc:	29 f8                	sub    %edi,%eax
 1be:	83 c0 30             	add    $0x30,%eax
 1c1:	88 46 01             	mov    %al,0x1(%esi)
        n /= 10;
 1c4:	89 d8                	mov    %ebx,%eax
 1c6:	89 d3                	mov    %edx,%ebx
    while (n > 0) {
 1c8:	83 f8 09             	cmp    $0x9,%eax
 1cb:	7f db                	jg     1a8 <create_filename+0x88>
    while (num_str[j] != '\0') {
 1cd:	0f b6 55 ea          	movzbl -0x16(%ebp),%edx
 1d1:	8d 5d ea             	lea    -0x16(%ebp),%ebx
 1d4:	0f b6 45 eb          	movzbl -0x15(%ebp),%eax
 1d8:	8b 75 10             	mov    0x10(%ebp),%esi
 1db:	29 cb                	sub    %ecx,%ebx
 1dd:	84 d2                	test   %dl,%dl
 1df:	75 0e                	jne    1ef <create_filename+0xcf>
 1e1:	eb 25                	jmp    208 <create_filename+0xe8>
 1e3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1e7:	90                   	nop
 1e8:	89 c2                	mov    %eax,%edx
 1ea:	0f b6 44 19 01       	movzbl 0x1(%ecx,%ebx,1),%eax
        filename[i++] = num_str[j++];
 1ef:	83 c1 01             	add    $0x1,%ecx
 1f2:	88 54 0e ff          	mov    %dl,-0x1(%esi,%ecx,1)
    while (num_str[j] != '\0') {
 1f6:	84 c0                	test   %al,%al
 1f8:	75 ee                	jne    1e8 <create_filename+0xc8>
    filename[i++] = '.';
 1fa:	8b 45 10             	mov    0x10(%ebp),%eax
 1fd:	01 c8                	add    %ecx,%eax
 1ff:	89 45 e0             	mov    %eax,-0x20(%ebp)
 202:	8d 41 01             	lea    0x1(%ecx),%eax
 205:	89 45 dc             	mov    %eax,-0x24(%ebp)
 208:	8b 45 e0             	mov    -0x20(%ebp),%eax
    filename[i++] = 't';
 20b:	8b 7d dc             	mov    -0x24(%ebp),%edi
    filename[i++] = '.';
 20e:	c6 00 2e             	movb   $0x2e,(%eax)
    filename[i++] = 't';
 211:	8b 45 10             	mov    0x10(%ebp),%eax
 214:	c6 04 38 74          	movb   $0x74,(%eax,%edi,1)
    filename[i++] = 'x';
 218:	c6 44 08 02 78       	movb   $0x78,0x2(%eax,%ecx,1)
    filename[i++] = 't';
 21d:	c6 44 08 03 74       	movb   $0x74,0x3(%eax,%ecx,1)
    filename[i] = '\0'; // Null-terminate the string
 222:	c6 44 08 04 00       	movb   $0x0,0x4(%eax,%ecx,1)
}
 227:	83 c4 1c             	add    $0x1c,%esp
 22a:	5b                   	pop    %ebx
 22b:	5e                   	pop    %esi
 22c:	5f                   	pop    %edi
 22d:	5d                   	pop    %ebp
 22e:	c3                   	ret    
 22f:	90                   	nop
        filename[i++] = num_str[j++];
 230:	8b 45 10             	mov    0x10(%ebp),%eax
 233:	83 c1 01             	add    $0x1,%ecx
 236:	c6 44 08 ff 30       	movb   $0x30,-0x1(%eax,%ecx,1)
    while (num_str[j] != '\0') {
 23b:	eb bd                	jmp    1fa <create_filename+0xda>
 23d:	8d 76 00             	lea    0x0(%esi),%esi
    while (base[i] != '\0') {
 240:	8b 45 10             	mov    0x10(%ebp),%eax
 243:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
    int i = 0;
 24a:	31 c9                	xor    %ecx,%ecx
    while (base[i] != '\0') {
 24c:	89 45 e0             	mov    %eax,-0x20(%ebp)
 24f:	e9 0a ff ff ff       	jmp    15e <create_filename+0x3e>
 254:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 25b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 25f:	90                   	nop

00000260 <write_to_file>:
void write_to_file(char *filename, char *text) {
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	57                   	push   %edi
 264:	56                   	push   %esi
 265:	53                   	push   %ebx
 266:	83 ec 28             	sub    $0x28,%esp
 269:	8b 55 0c             	mov    0xc(%ebp),%edx
 26c:	8b 7d 08             	mov    0x8(%ebp),%edi
    int n = strlen(text);
 26f:	52                   	push   %edx
 270:	89 55 e4             	mov    %edx,-0x1c(%ebp)
 273:	e8 38 01 00 00       	call   3b0 <strlen>
 278:	89 c6                	mov    %eax,%esi
    fd = open(filename, O_WRONLY | O_CREATE);
 27a:	58                   	pop    %eax
 27b:	5a                   	pop    %edx
 27c:	68 01 02 00 00       	push   $0x201
 281:	57                   	push   %edi
 282:	e8 2c 03 00 00       	call   5b3 <open>
    if (fd < 0) {
 287:	83 c4 10             	add    $0x10,%esp
 28a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 28d:	85 c0                	test   %eax,%eax
 28f:	78 67                	js     2f8 <write_to_file+0x98>
    if (write(fd, text, n) != n) {
 291:	83 ec 04             	sub    $0x4,%esp
 294:	89 c3                	mov    %eax,%ebx
 296:	56                   	push   %esi
 297:	52                   	push   %edx
 298:	50                   	push   %eax
 299:	e8 f5 02 00 00       	call   593 <write>
 29e:	83 c4 10             	add    $0x10,%esp
 2a1:	39 f0                	cmp    %esi,%eax
 2a3:	75 2b                	jne    2d0 <write_to_file+0x70>
    close(fd);
 2a5:	83 ec 0c             	sub    $0xc,%esp
 2a8:	53                   	push   %ebx
 2a9:	e8 ed 02 00 00       	call   59b <close>
    printf(1, "Successfully wrote to %s\n", filename); // Debugging print
 2ae:	83 c4 0c             	add    $0xc,%esp
 2b1:	57                   	push   %edi
 2b2:	68 3a 0a 00 00       	push   $0xa3a
 2b7:	6a 01                	push   $0x1
 2b9:	e8 22 04 00 00       	call   6e0 <printf>
 2be:	83 c4 10             	add    $0x10,%esp
}
 2c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2c4:	5b                   	pop    %ebx
 2c5:	5e                   	pop    %esi
 2c6:	5f                   	pop    %edi
 2c7:	5d                   	pop    %ebp
 2c8:	c3                   	ret    
 2c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printf(2, "Error: write error for %s\n", filename);
 2d0:	83 ec 04             	sub    $0x4,%esp
 2d3:	57                   	push   %edi
 2d4:	68 1f 0a 00 00       	push   $0xa1f
 2d9:	6a 02                	push   $0x2
 2db:	e8 00 04 00 00       	call   6e0 <printf>
        close(fd);
 2e0:	89 5d 08             	mov    %ebx,0x8(%ebp)
 2e3:	83 c4 10             	add    $0x10,%esp
}
 2e6:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2e9:	5b                   	pop    %ebx
 2ea:	5e                   	pop    %esi
 2eb:	5f                   	pop    %edi
 2ec:	5d                   	pop    %ebp
        close(fd);
 2ed:	e9 a9 02 00 00       	jmp    59b <close>
 2f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printf(2, "Error: cannot open %s\n", filename);
 2f8:	83 ec 04             	sub    $0x4,%esp
 2fb:	57                   	push   %edi
 2fc:	68 08 0a 00 00       	push   $0xa08
 301:	6a 02                	push   $0x2
 303:	e8 d8 03 00 00       	call   6e0 <printf>
        return;
 308:	83 c4 10             	add    $0x10,%esp
}
 30b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 30e:	5b                   	pop    %ebx
 30f:	5e                   	pop    %esi
 310:	5f                   	pop    %edi
 311:	5d                   	pop    %ebp
 312:	c3                   	ret    
 313:	66 90                	xchg   %ax,%ax
 315:	66 90                	xchg   %ax,%ax
 317:	66 90                	xchg   %ax,%ax
 319:	66 90                	xchg   %ax,%ax
 31b:	66 90                	xchg   %ax,%ax
 31d:	66 90                	xchg   %ax,%ax
 31f:	90                   	nop

00000320 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 320:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 321:	31 c0                	xor    %eax,%eax
{
 323:	89 e5                	mov    %esp,%ebp
 325:	53                   	push   %ebx
 326:	8b 4d 08             	mov    0x8(%ebp),%ecx
 329:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 32c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 330:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 334:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 337:	83 c0 01             	add    $0x1,%eax
 33a:	84 d2                	test   %dl,%dl
 33c:	75 f2                	jne    330 <strcpy+0x10>
    ;
  return os;
}
 33e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 341:	89 c8                	mov    %ecx,%eax
 343:	c9                   	leave  
 344:	c3                   	ret    
 345:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 34c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000350 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	53                   	push   %ebx
 354:	8b 55 08             	mov    0x8(%ebp),%edx
 357:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 35a:	0f b6 02             	movzbl (%edx),%eax
 35d:	84 c0                	test   %al,%al
 35f:	75 17                	jne    378 <strcmp+0x28>
 361:	eb 3a                	jmp    39d <strcmp+0x4d>
 363:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 367:	90                   	nop
 368:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 36c:	83 c2 01             	add    $0x1,%edx
 36f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 372:	84 c0                	test   %al,%al
 374:	74 1a                	je     390 <strcmp+0x40>
    p++, q++;
 376:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
 378:	0f b6 19             	movzbl (%ecx),%ebx
 37b:	38 c3                	cmp    %al,%bl
 37d:	74 e9                	je     368 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 37f:	29 d8                	sub    %ebx,%eax
}
 381:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 384:	c9                   	leave  
 385:	c3                   	ret    
 386:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 38d:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 390:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 394:	31 c0                	xor    %eax,%eax
 396:	29 d8                	sub    %ebx,%eax
}
 398:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 39b:	c9                   	leave  
 39c:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
 39d:	0f b6 19             	movzbl (%ecx),%ebx
 3a0:	31 c0                	xor    %eax,%eax
 3a2:	eb db                	jmp    37f <strcmp+0x2f>
 3a4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3af:	90                   	nop

000003b0 <strlen>:

uint
strlen(const char *s)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 3b6:	80 3a 00             	cmpb   $0x0,(%edx)
 3b9:	74 15                	je     3d0 <strlen+0x20>
 3bb:	31 c0                	xor    %eax,%eax
 3bd:	8d 76 00             	lea    0x0(%esi),%esi
 3c0:	83 c0 01             	add    $0x1,%eax
 3c3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 3c7:	89 c1                	mov    %eax,%ecx
 3c9:	75 f5                	jne    3c0 <strlen+0x10>
    ;
  return n;
}
 3cb:	89 c8                	mov    %ecx,%eax
 3cd:	5d                   	pop    %ebp
 3ce:	c3                   	ret    
 3cf:	90                   	nop
  for(n = 0; s[n]; n++)
 3d0:	31 c9                	xor    %ecx,%ecx
}
 3d2:	5d                   	pop    %ebp
 3d3:	89 c8                	mov    %ecx,%eax
 3d5:	c3                   	ret    
 3d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3dd:	8d 76 00             	lea    0x0(%esi),%esi

000003e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	57                   	push   %edi
 3e4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 3e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3ea:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ed:	89 d7                	mov    %edx,%edi
 3ef:	fc                   	cld    
 3f0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 3f2:	8b 7d fc             	mov    -0x4(%ebp),%edi
 3f5:	89 d0                	mov    %edx,%eax
 3f7:	c9                   	leave  
 3f8:	c3                   	ret    
 3f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000400 <strchr>:

char*
strchr(const char *s, char c)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	8b 45 08             	mov    0x8(%ebp),%eax
 406:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 40a:	0f b6 10             	movzbl (%eax),%edx
 40d:	84 d2                	test   %dl,%dl
 40f:	75 12                	jne    423 <strchr+0x23>
 411:	eb 1d                	jmp    430 <strchr+0x30>
 413:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 417:	90                   	nop
 418:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 41c:	83 c0 01             	add    $0x1,%eax
 41f:	84 d2                	test   %dl,%dl
 421:	74 0d                	je     430 <strchr+0x30>
    if(*s == c)
 423:	38 d1                	cmp    %dl,%cl
 425:	75 f1                	jne    418 <strchr+0x18>
      return (char*)s;
  return 0;
}
 427:	5d                   	pop    %ebp
 428:	c3                   	ret    
 429:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 430:	31 c0                	xor    %eax,%eax
}
 432:	5d                   	pop    %ebp
 433:	c3                   	ret    
 434:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 43b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 43f:	90                   	nop

00000440 <gets>:

char*
gets(char *buf, int max)
{
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	57                   	push   %edi
 444:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 445:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 448:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 449:	31 db                	xor    %ebx,%ebx
{
 44b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 44e:	eb 27                	jmp    477 <gets+0x37>
    cc = read(0, &c, 1);
 450:	83 ec 04             	sub    $0x4,%esp
 453:	6a 01                	push   $0x1
 455:	57                   	push   %edi
 456:	6a 00                	push   $0x0
 458:	e8 2e 01 00 00       	call   58b <read>
    if(cc < 1)
 45d:	83 c4 10             	add    $0x10,%esp
 460:	85 c0                	test   %eax,%eax
 462:	7e 1d                	jle    481 <gets+0x41>
      break;
    buf[i++] = c;
 464:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 468:	8b 55 08             	mov    0x8(%ebp),%edx
 46b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 46f:	3c 0a                	cmp    $0xa,%al
 471:	74 1d                	je     490 <gets+0x50>
 473:	3c 0d                	cmp    $0xd,%al
 475:	74 19                	je     490 <gets+0x50>
  for(i=0; i+1 < max; ){
 477:	89 de                	mov    %ebx,%esi
 479:	83 c3 01             	add    $0x1,%ebx
 47c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 47f:	7c cf                	jl     450 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 481:	8b 45 08             	mov    0x8(%ebp),%eax
 484:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 488:	8d 65 f4             	lea    -0xc(%ebp),%esp
 48b:	5b                   	pop    %ebx
 48c:	5e                   	pop    %esi
 48d:	5f                   	pop    %edi
 48e:	5d                   	pop    %ebp
 48f:	c3                   	ret    
  buf[i] = '\0';
 490:	8b 45 08             	mov    0x8(%ebp),%eax
 493:	89 de                	mov    %ebx,%esi
 495:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 499:	8d 65 f4             	lea    -0xc(%ebp),%esp
 49c:	5b                   	pop    %ebx
 49d:	5e                   	pop    %esi
 49e:	5f                   	pop    %edi
 49f:	5d                   	pop    %ebp
 4a0:	c3                   	ret    
 4a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4af:	90                   	nop

000004b0 <stat>:

int
stat(const char *n, struct stat *st)
{
 4b0:	55                   	push   %ebp
 4b1:	89 e5                	mov    %esp,%ebp
 4b3:	56                   	push   %esi
 4b4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4b5:	83 ec 08             	sub    $0x8,%esp
 4b8:	6a 00                	push   $0x0
 4ba:	ff 75 08             	push   0x8(%ebp)
 4bd:	e8 f1 00 00 00       	call   5b3 <open>
  if(fd < 0)
 4c2:	83 c4 10             	add    $0x10,%esp
 4c5:	85 c0                	test   %eax,%eax
 4c7:	78 27                	js     4f0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 4c9:	83 ec 08             	sub    $0x8,%esp
 4cc:	ff 75 0c             	push   0xc(%ebp)
 4cf:	89 c3                	mov    %eax,%ebx
 4d1:	50                   	push   %eax
 4d2:	e8 f4 00 00 00       	call   5cb <fstat>
  close(fd);
 4d7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 4da:	89 c6                	mov    %eax,%esi
  close(fd);
 4dc:	e8 ba 00 00 00       	call   59b <close>
  return r;
 4e1:	83 c4 10             	add    $0x10,%esp
}
 4e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 4e7:	89 f0                	mov    %esi,%eax
 4e9:	5b                   	pop    %ebx
 4ea:	5e                   	pop    %esi
 4eb:	5d                   	pop    %ebp
 4ec:	c3                   	ret    
 4ed:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 4f0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 4f5:	eb ed                	jmp    4e4 <stat+0x34>
 4f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4fe:	66 90                	xchg   %ax,%ax

00000500 <atoi>:

int
atoi(const char *s)
{
 500:	55                   	push   %ebp
 501:	89 e5                	mov    %esp,%ebp
 503:	53                   	push   %ebx
 504:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 507:	0f be 02             	movsbl (%edx),%eax
 50a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 50d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 510:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 515:	77 1e                	ja     535 <atoi+0x35>
 517:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 51e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 520:	83 c2 01             	add    $0x1,%edx
 523:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 526:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 52a:	0f be 02             	movsbl (%edx),%eax
 52d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 530:	80 fb 09             	cmp    $0x9,%bl
 533:	76 eb                	jbe    520 <atoi+0x20>
  return n;
}
 535:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 538:	89 c8                	mov    %ecx,%eax
 53a:	c9                   	leave  
 53b:	c3                   	ret    
 53c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000540 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 540:	55                   	push   %ebp
 541:	89 e5                	mov    %esp,%ebp
 543:	57                   	push   %edi
 544:	8b 45 10             	mov    0x10(%ebp),%eax
 547:	8b 55 08             	mov    0x8(%ebp),%edx
 54a:	56                   	push   %esi
 54b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 54e:	85 c0                	test   %eax,%eax
 550:	7e 13                	jle    565 <memmove+0x25>
 552:	01 d0                	add    %edx,%eax
  dst = vdst;
 554:	89 d7                	mov    %edx,%edi
 556:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 55d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 560:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 561:	39 f8                	cmp    %edi,%eax
 563:	75 fb                	jne    560 <memmove+0x20>
  return vdst;
}
 565:	5e                   	pop    %esi
 566:	89 d0                	mov    %edx,%eax
 568:	5f                   	pop    %edi
 569:	5d                   	pop    %ebp
 56a:	c3                   	ret    

0000056b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 56b:	b8 01 00 00 00       	mov    $0x1,%eax
 570:	cd 40                	int    $0x40
 572:	c3                   	ret    

00000573 <exit>:
SYSCALL(exit)
 573:	b8 02 00 00 00       	mov    $0x2,%eax
 578:	cd 40                	int    $0x40
 57a:	c3                   	ret    

0000057b <wait>:
SYSCALL(wait)
 57b:	b8 03 00 00 00       	mov    $0x3,%eax
 580:	cd 40                	int    $0x40
 582:	c3                   	ret    

00000583 <pipe>:
SYSCALL(pipe)
 583:	b8 04 00 00 00       	mov    $0x4,%eax
 588:	cd 40                	int    $0x40
 58a:	c3                   	ret    

0000058b <read>:
SYSCALL(read)
 58b:	b8 05 00 00 00       	mov    $0x5,%eax
 590:	cd 40                	int    $0x40
 592:	c3                   	ret    

00000593 <write>:
SYSCALL(write)
 593:	b8 10 00 00 00       	mov    $0x10,%eax
 598:	cd 40                	int    $0x40
 59a:	c3                   	ret    

0000059b <close>:
SYSCALL(close)
 59b:	b8 15 00 00 00       	mov    $0x15,%eax
 5a0:	cd 40                	int    $0x40
 5a2:	c3                   	ret    

000005a3 <kill>:
SYSCALL(kill)
 5a3:	b8 06 00 00 00       	mov    $0x6,%eax
 5a8:	cd 40                	int    $0x40
 5aa:	c3                   	ret    

000005ab <exec>:
SYSCALL(exec)
 5ab:	b8 07 00 00 00       	mov    $0x7,%eax
 5b0:	cd 40                	int    $0x40
 5b2:	c3                   	ret    

000005b3 <open>:
SYSCALL(open)
 5b3:	b8 0f 00 00 00       	mov    $0xf,%eax
 5b8:	cd 40                	int    $0x40
 5ba:	c3                   	ret    

000005bb <mknod>:
SYSCALL(mknod)
 5bb:	b8 11 00 00 00       	mov    $0x11,%eax
 5c0:	cd 40                	int    $0x40
 5c2:	c3                   	ret    

000005c3 <unlink>:
SYSCALL(unlink)
 5c3:	b8 12 00 00 00       	mov    $0x12,%eax
 5c8:	cd 40                	int    $0x40
 5ca:	c3                   	ret    

000005cb <fstat>:
SYSCALL(fstat)
 5cb:	b8 08 00 00 00       	mov    $0x8,%eax
 5d0:	cd 40                	int    $0x40
 5d2:	c3                   	ret    

000005d3 <link>:
SYSCALL(link)
 5d3:	b8 13 00 00 00       	mov    $0x13,%eax
 5d8:	cd 40                	int    $0x40
 5da:	c3                   	ret    

000005db <mkdir>:
SYSCALL(mkdir)
 5db:	b8 14 00 00 00       	mov    $0x14,%eax
 5e0:	cd 40                	int    $0x40
 5e2:	c3                   	ret    

000005e3 <chdir>:
SYSCALL(chdir)
 5e3:	b8 09 00 00 00       	mov    $0x9,%eax
 5e8:	cd 40                	int    $0x40
 5ea:	c3                   	ret    

000005eb <dup>:
SYSCALL(dup)
 5eb:	b8 0a 00 00 00       	mov    $0xa,%eax
 5f0:	cd 40                	int    $0x40
 5f2:	c3                   	ret    

000005f3 <getpid>:
SYSCALL(getpid)
 5f3:	b8 0b 00 00 00       	mov    $0xb,%eax
 5f8:	cd 40                	int    $0x40
 5fa:	c3                   	ret    

000005fb <sbrk>:
SYSCALL(sbrk)
 5fb:	b8 0c 00 00 00       	mov    $0xc,%eax
 600:	cd 40                	int    $0x40
 602:	c3                   	ret    

00000603 <sleep>:
SYSCALL(sleep)
 603:	b8 0d 00 00 00       	mov    $0xd,%eax
 608:	cd 40                	int    $0x40
 60a:	c3                   	ret    

0000060b <uptime>:
SYSCALL(uptime)
 60b:	b8 0e 00 00 00       	mov    $0xe,%eax
 610:	cd 40                	int    $0x40
 612:	c3                   	ret    

00000613 <ps>:
SYSCALL(ps)
 613:	b8 16 00 00 00       	mov    $0x16,%eax
 618:	cd 40                	int    $0x40
 61a:	c3                   	ret    

0000061b <sys_ps>:

// usys.S
.globl sys_ps
sys_ps:
    movl SYS_ps, %eax
 61b:	a1 16 00 00 00       	mov    0x16,%eax
    int $64
 620:	cd 40                	int    $0x40
    ret
 622:	c3                   	ret    
 623:	66 90                	xchg   %ax,%ax
 625:	66 90                	xchg   %ax,%ax
 627:	66 90                	xchg   %ax,%ax
 629:	66 90                	xchg   %ax,%ax
 62b:	66 90                	xchg   %ax,%ax
 62d:	66 90                	xchg   %ax,%ax
 62f:	90                   	nop

00000630 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 630:	55                   	push   %ebp
 631:	89 e5                	mov    %esp,%ebp
 633:	57                   	push   %edi
 634:	56                   	push   %esi
 635:	53                   	push   %ebx
 636:	83 ec 3c             	sub    $0x3c,%esp
 639:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 63c:	89 d1                	mov    %edx,%ecx
{
 63e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 641:	85 d2                	test   %edx,%edx
 643:	0f 89 7f 00 00 00    	jns    6c8 <printint+0x98>
 649:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 64d:	74 79                	je     6c8 <printint+0x98>
    neg = 1;
 64f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 656:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 658:	31 db                	xor    %ebx,%ebx
 65a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 65d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 660:	89 c8                	mov    %ecx,%eax
 662:	31 d2                	xor    %edx,%edx
 664:	89 cf                	mov    %ecx,%edi
 666:	f7 75 c4             	divl   -0x3c(%ebp)
 669:	0f b6 92 e8 0a 00 00 	movzbl 0xae8(%edx),%edx
 670:	89 45 c0             	mov    %eax,-0x40(%ebp)
 673:	89 d8                	mov    %ebx,%eax
 675:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 678:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 67b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 67e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 681:	76 dd                	jbe    660 <printint+0x30>
  if(neg)
 683:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 686:	85 c9                	test   %ecx,%ecx
 688:	74 0c                	je     696 <printint+0x66>
    buf[i++] = '-';
 68a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 68f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 691:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 696:	8b 7d b8             	mov    -0x48(%ebp),%edi
 699:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 69d:	eb 07                	jmp    6a6 <printint+0x76>
 69f:	90                   	nop
    putc(fd, buf[i]);
 6a0:	0f b6 13             	movzbl (%ebx),%edx
 6a3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 6a6:	83 ec 04             	sub    $0x4,%esp
 6a9:	88 55 d7             	mov    %dl,-0x29(%ebp)
 6ac:	6a 01                	push   $0x1
 6ae:	56                   	push   %esi
 6af:	57                   	push   %edi
 6b0:	e8 de fe ff ff       	call   593 <write>
  while(--i >= 0)
 6b5:	83 c4 10             	add    $0x10,%esp
 6b8:	39 de                	cmp    %ebx,%esi
 6ba:	75 e4                	jne    6a0 <printint+0x70>
}
 6bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6bf:	5b                   	pop    %ebx
 6c0:	5e                   	pop    %esi
 6c1:	5f                   	pop    %edi
 6c2:	5d                   	pop    %ebp
 6c3:	c3                   	ret    
 6c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 6c8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 6cf:	eb 87                	jmp    658 <printint+0x28>
 6d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6df:	90                   	nop

000006e0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 6e0:	55                   	push   %ebp
 6e1:	89 e5                	mov    %esp,%ebp
 6e3:	57                   	push   %edi
 6e4:	56                   	push   %esi
 6e5:	53                   	push   %ebx
 6e6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6e9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 6ec:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 6ef:	0f b6 13             	movzbl (%ebx),%edx
 6f2:	84 d2                	test   %dl,%dl
 6f4:	74 6a                	je     760 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
 6f6:	8d 45 10             	lea    0x10(%ebp),%eax
 6f9:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 6fc:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 6ff:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
 701:	89 45 d0             	mov    %eax,-0x30(%ebp)
 704:	eb 36                	jmp    73c <printf+0x5c>
 706:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 70d:	8d 76 00             	lea    0x0(%esi),%esi
 710:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 713:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
 718:	83 f8 25             	cmp    $0x25,%eax
 71b:	74 15                	je     732 <printf+0x52>
  write(fd, &c, 1);
 71d:	83 ec 04             	sub    $0x4,%esp
 720:	88 55 e7             	mov    %dl,-0x19(%ebp)
 723:	6a 01                	push   $0x1
 725:	57                   	push   %edi
 726:	56                   	push   %esi
 727:	e8 67 fe ff ff       	call   593 <write>
 72c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
 72f:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 732:	0f b6 13             	movzbl (%ebx),%edx
 735:	83 c3 01             	add    $0x1,%ebx
 738:	84 d2                	test   %dl,%dl
 73a:	74 24                	je     760 <printf+0x80>
    c = fmt[i] & 0xff;
 73c:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 73f:	85 c9                	test   %ecx,%ecx
 741:	74 cd                	je     710 <printf+0x30>
      }
    } else if(state == '%'){
 743:	83 f9 25             	cmp    $0x25,%ecx
 746:	75 ea                	jne    732 <printf+0x52>
      if(c == 'd'){
 748:	83 f8 25             	cmp    $0x25,%eax
 74b:	0f 84 07 01 00 00    	je     858 <printf+0x178>
 751:	83 e8 63             	sub    $0x63,%eax
 754:	83 f8 15             	cmp    $0x15,%eax
 757:	77 17                	ja     770 <printf+0x90>
 759:	ff 24 85 90 0a 00 00 	jmp    *0xa90(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 760:	8d 65 f4             	lea    -0xc(%ebp),%esp
 763:	5b                   	pop    %ebx
 764:	5e                   	pop    %esi
 765:	5f                   	pop    %edi
 766:	5d                   	pop    %ebp
 767:	c3                   	ret    
 768:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 76f:	90                   	nop
  write(fd, &c, 1);
 770:	83 ec 04             	sub    $0x4,%esp
 773:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 776:	6a 01                	push   $0x1
 778:	57                   	push   %edi
 779:	56                   	push   %esi
 77a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 77e:	e8 10 fe ff ff       	call   593 <write>
        putc(fd, c);
 783:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 787:	83 c4 0c             	add    $0xc,%esp
 78a:	88 55 e7             	mov    %dl,-0x19(%ebp)
 78d:	6a 01                	push   $0x1
 78f:	57                   	push   %edi
 790:	56                   	push   %esi
 791:	e8 fd fd ff ff       	call   593 <write>
        putc(fd, c);
 796:	83 c4 10             	add    $0x10,%esp
      state = 0;
 799:	31 c9                	xor    %ecx,%ecx
 79b:	eb 95                	jmp    732 <printf+0x52>
 79d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 7a0:	83 ec 0c             	sub    $0xc,%esp
 7a3:	b9 10 00 00 00       	mov    $0x10,%ecx
 7a8:	6a 00                	push   $0x0
 7aa:	8b 45 d0             	mov    -0x30(%ebp),%eax
 7ad:	8b 10                	mov    (%eax),%edx
 7af:	89 f0                	mov    %esi,%eax
 7b1:	e8 7a fe ff ff       	call   630 <printint>
        ap++;
 7b6:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 7ba:	83 c4 10             	add    $0x10,%esp
      state = 0;
 7bd:	31 c9                	xor    %ecx,%ecx
 7bf:	e9 6e ff ff ff       	jmp    732 <printf+0x52>
 7c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 7c8:	8b 45 d0             	mov    -0x30(%ebp),%eax
 7cb:	8b 10                	mov    (%eax),%edx
        ap++;
 7cd:	83 c0 04             	add    $0x4,%eax
 7d0:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 7d3:	85 d2                	test   %edx,%edx
 7d5:	0f 84 8d 00 00 00    	je     868 <printf+0x188>
        while(*s != 0){
 7db:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
 7de:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
 7e0:	84 c0                	test   %al,%al
 7e2:	0f 84 4a ff ff ff    	je     732 <printf+0x52>
 7e8:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 7eb:	89 d3                	mov    %edx,%ebx
 7ed:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 7f0:	83 ec 04             	sub    $0x4,%esp
          s++;
 7f3:	83 c3 01             	add    $0x1,%ebx
 7f6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 7f9:	6a 01                	push   $0x1
 7fb:	57                   	push   %edi
 7fc:	56                   	push   %esi
 7fd:	e8 91 fd ff ff       	call   593 <write>
        while(*s != 0){
 802:	0f b6 03             	movzbl (%ebx),%eax
 805:	83 c4 10             	add    $0x10,%esp
 808:	84 c0                	test   %al,%al
 80a:	75 e4                	jne    7f0 <printf+0x110>
      state = 0;
 80c:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 80f:	31 c9                	xor    %ecx,%ecx
 811:	e9 1c ff ff ff       	jmp    732 <printf+0x52>
 816:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 81d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 820:	83 ec 0c             	sub    $0xc,%esp
 823:	b9 0a 00 00 00       	mov    $0xa,%ecx
 828:	6a 01                	push   $0x1
 82a:	e9 7b ff ff ff       	jmp    7aa <printf+0xca>
 82f:	90                   	nop
        putc(fd, *ap);
 830:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
 833:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 836:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 838:	6a 01                	push   $0x1
 83a:	57                   	push   %edi
 83b:	56                   	push   %esi
        putc(fd, *ap);
 83c:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 83f:	e8 4f fd ff ff       	call   593 <write>
        ap++;
 844:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 848:	83 c4 10             	add    $0x10,%esp
      state = 0;
 84b:	31 c9                	xor    %ecx,%ecx
 84d:	e9 e0 fe ff ff       	jmp    732 <printf+0x52>
 852:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
 858:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 85b:	83 ec 04             	sub    $0x4,%esp
 85e:	e9 2a ff ff ff       	jmp    78d <printf+0xad>
 863:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 867:	90                   	nop
          s = "(null)";
 868:	ba 86 0a 00 00       	mov    $0xa86,%edx
        while(*s != 0){
 86d:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 870:	b8 28 00 00 00       	mov    $0x28,%eax
 875:	89 d3                	mov    %edx,%ebx
 877:	e9 74 ff ff ff       	jmp    7f0 <printf+0x110>
 87c:	66 90                	xchg   %ax,%ax
 87e:	66 90                	xchg   %ax,%ax

00000880 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 880:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 881:	a1 54 0e 00 00       	mov    0xe54,%eax
{
 886:	89 e5                	mov    %esp,%ebp
 888:	57                   	push   %edi
 889:	56                   	push   %esi
 88a:	53                   	push   %ebx
 88b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 88e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 891:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 898:	89 c2                	mov    %eax,%edx
 89a:	8b 00                	mov    (%eax),%eax
 89c:	39 ca                	cmp    %ecx,%edx
 89e:	73 30                	jae    8d0 <free+0x50>
 8a0:	39 c1                	cmp    %eax,%ecx
 8a2:	72 04                	jb     8a8 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8a4:	39 c2                	cmp    %eax,%edx
 8a6:	72 f0                	jb     898 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 8a8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 8ab:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 8ae:	39 f8                	cmp    %edi,%eax
 8b0:	74 30                	je     8e2 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 8b2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 8b5:	8b 42 04             	mov    0x4(%edx),%eax
 8b8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 8bb:	39 f1                	cmp    %esi,%ecx
 8bd:	74 3a                	je     8f9 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 8bf:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 8c1:	5b                   	pop    %ebx
  freep = p;
 8c2:	89 15 54 0e 00 00    	mov    %edx,0xe54
}
 8c8:	5e                   	pop    %esi
 8c9:	5f                   	pop    %edi
 8ca:	5d                   	pop    %ebp
 8cb:	c3                   	ret    
 8cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8d0:	39 c2                	cmp    %eax,%edx
 8d2:	72 c4                	jb     898 <free+0x18>
 8d4:	39 c1                	cmp    %eax,%ecx
 8d6:	73 c0                	jae    898 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
 8d8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 8db:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 8de:	39 f8                	cmp    %edi,%eax
 8e0:	75 d0                	jne    8b2 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
 8e2:	03 70 04             	add    0x4(%eax),%esi
 8e5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 8e8:	8b 02                	mov    (%edx),%eax
 8ea:	8b 00                	mov    (%eax),%eax
 8ec:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 8ef:	8b 42 04             	mov    0x4(%edx),%eax
 8f2:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 8f5:	39 f1                	cmp    %esi,%ecx
 8f7:	75 c6                	jne    8bf <free+0x3f>
    p->s.size += bp->s.size;
 8f9:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 8fc:	89 15 54 0e 00 00    	mov    %edx,0xe54
    p->s.size += bp->s.size;
 902:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 905:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 908:	89 0a                	mov    %ecx,(%edx)
}
 90a:	5b                   	pop    %ebx
 90b:	5e                   	pop    %esi
 90c:	5f                   	pop    %edi
 90d:	5d                   	pop    %ebp
 90e:	c3                   	ret    
 90f:	90                   	nop

00000910 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 910:	55                   	push   %ebp
 911:	89 e5                	mov    %esp,%ebp
 913:	57                   	push   %edi
 914:	56                   	push   %esi
 915:	53                   	push   %ebx
 916:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 919:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 91c:	8b 3d 54 0e 00 00    	mov    0xe54,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 922:	8d 70 07             	lea    0x7(%eax),%esi
 925:	c1 ee 03             	shr    $0x3,%esi
 928:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 92b:	85 ff                	test   %edi,%edi
 92d:	0f 84 9d 00 00 00    	je     9d0 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 933:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 935:	8b 4a 04             	mov    0x4(%edx),%ecx
 938:	39 f1                	cmp    %esi,%ecx
 93a:	73 6a                	jae    9a6 <malloc+0x96>
 93c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 941:	39 de                	cmp    %ebx,%esi
 943:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 946:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 94d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 950:	eb 17                	jmp    969 <malloc+0x59>
 952:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 958:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 95a:	8b 48 04             	mov    0x4(%eax),%ecx
 95d:	39 f1                	cmp    %esi,%ecx
 95f:	73 4f                	jae    9b0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 961:	8b 3d 54 0e 00 00    	mov    0xe54,%edi
 967:	89 c2                	mov    %eax,%edx
 969:	39 d7                	cmp    %edx,%edi
 96b:	75 eb                	jne    958 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 96d:	83 ec 0c             	sub    $0xc,%esp
 970:	ff 75 e4             	push   -0x1c(%ebp)
 973:	e8 83 fc ff ff       	call   5fb <sbrk>
  if(p == (char*)-1)
 978:	83 c4 10             	add    $0x10,%esp
 97b:	83 f8 ff             	cmp    $0xffffffff,%eax
 97e:	74 1c                	je     99c <malloc+0x8c>
  hp->s.size = nu;
 980:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 983:	83 ec 0c             	sub    $0xc,%esp
 986:	83 c0 08             	add    $0x8,%eax
 989:	50                   	push   %eax
 98a:	e8 f1 fe ff ff       	call   880 <free>
  return freep;
 98f:	8b 15 54 0e 00 00    	mov    0xe54,%edx
      if((p = morecore(nunits)) == 0)
 995:	83 c4 10             	add    $0x10,%esp
 998:	85 d2                	test   %edx,%edx
 99a:	75 bc                	jne    958 <malloc+0x48>
        return 0;
  }
}
 99c:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 99f:	31 c0                	xor    %eax,%eax
}
 9a1:	5b                   	pop    %ebx
 9a2:	5e                   	pop    %esi
 9a3:	5f                   	pop    %edi
 9a4:	5d                   	pop    %ebp
 9a5:	c3                   	ret    
    if(p->s.size >= nunits){
 9a6:	89 d0                	mov    %edx,%eax
 9a8:	89 fa                	mov    %edi,%edx
 9aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 9b0:	39 ce                	cmp    %ecx,%esi
 9b2:	74 4c                	je     a00 <malloc+0xf0>
        p->s.size -= nunits;
 9b4:	29 f1                	sub    %esi,%ecx
 9b6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 9b9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 9bc:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 9bf:	89 15 54 0e 00 00    	mov    %edx,0xe54
}
 9c5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 9c8:	83 c0 08             	add    $0x8,%eax
}
 9cb:	5b                   	pop    %ebx
 9cc:	5e                   	pop    %esi
 9cd:	5f                   	pop    %edi
 9ce:	5d                   	pop    %ebp
 9cf:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 9d0:	c7 05 54 0e 00 00 58 	movl   $0xe58,0xe54
 9d7:	0e 00 00 
    base.s.size = 0;
 9da:	bf 58 0e 00 00       	mov    $0xe58,%edi
    base.s.ptr = freep = prevp = &base;
 9df:	c7 05 58 0e 00 00 58 	movl   $0xe58,0xe58
 9e6:	0e 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9e9:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 9eb:	c7 05 5c 0e 00 00 00 	movl   $0x0,0xe5c
 9f2:	00 00 00 
    if(p->s.size >= nunits){
 9f5:	e9 42 ff ff ff       	jmp    93c <malloc+0x2c>
 9fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 a00:	8b 08                	mov    (%eax),%ecx
 a02:	89 0a                	mov    %ecx,(%edx)
 a04:	eb b9                	jmp    9bf <malloc+0xaf>
