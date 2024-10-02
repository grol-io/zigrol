static const char str[] = "Hello World!\n";

void _start() {
    // Perform the write syscall
    asm volatile (
        "mov x8, #64\n"        // SYS_write system call number (64 on ARM64)
        "mov x0, #1\n"         // File descriptor (stdout)
        "mov x1, %0\n"         // Pointer to the string
        "mov x2, %1\n"         // Length of the string
        "svc 0\n"              // Make the system call
        : // No output operands
        : "r"(str), "r"(sizeof(str) - 1)  // Input operands
        : "x0", "x1", "x2", "x8"  // Clobbered registers
    );

    // Perform the exit syscall
    asm volatile (
        "mov x8, #93\n"        // SYS_exit system call number (93 on ARM64)
        "mov x0, #42\n"        // Exit code
        "svc 0\n"              // Make the system call
        : // No output operands
        : // No input operands
        : "x0", "x8"  // Clobbered registers
    );
}
