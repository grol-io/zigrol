
all: small-go small-tinygo small-zig small-c small-syscall-zig small-syscall-c sizes

sizes:
	ls -lh

small-go:
	CGO_ENABLED=0 time go build -trimpath -ldflags="-s -w" -o small-go small.go
	ls -l $@
	strip $(STRIPFLAGS) $@
	ls -l $@
	-./$@

small-tinygo:
	CGO_ENABLED=0 time tinygo build -o small-tinygo small.go
	ls -l $@
	strip $(STRIPFLAGS) $@
	ls -l $@
	-./$@

small-syscall-zig: small-syscall.zig
	time zig build-exe -O ReleaseSmall --name $@ $<
	ls -l $@
	strip $(STRIPFLAGS) $@
	ls -l $@
	-./$@

small-zig: small.zig
	time zig build-exe -O ReleaseSmall --name $@ $<
	ls -l $@
	strip $(STRIPFLAGS) $@
	ls -l $@
	-./$@

GCCFLAGS:= -fno-ident -Os -s -static -fno-asynchronous-unwind-tables
STRIPFLAGS:= -s --remove-section=.note.gnu.gold-version --remove-section=.comment --remove-section=.note --remove-section=.note.GNU-stack --remove-section=.note.gnu.build-id --remove-section=.note.ABI-tag


small-c: small.c Makefile
	# sudo apt install dietlibc-dev
	time diet gcc $(GCCFLAGS) -o $@ $<
	ls -l $@
	strip $(STRIPFLAGS) $@
	ls -l $@

small-syscall-c: small-syscall.c Makefile
	time gcc -nostartfiles $(GCCFLAGS) -o $@ $<
	ls -l $@
	strip $(STRIPFLAGS) $@
	ls -l $@

small-syscall-asm: small-syscall-asm-arm64.c Makefile
	time gcc -nostdlib -nostartfiles $(GCCFLAGS) -o $@ $<
	ls -l $@
	strip $(STRIPFLAGS) $@
	ls -l $@


clean:
	rm -f small-go small-tinygo small-zig small-c small-syscall-c small-syzcall-sig
