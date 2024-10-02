
all: small-go small-tinygo small-zig small-c sizes

sizes:
	ls -lh small-go small-tinygo small-zig small-c

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

small-zig:
	time zig build-exe -O ReleaseSmall --name small-zig small.zig
	ls -l $@
	strip $(STRIPFLAGS) $@
	ls -l $@
	-./$@

GCCFLAGS:= -fno-ident -Os -s -static -fno-asynchronous-unwind-tables
STRIPFLAGS:= -s --remove-section=.note.gnu.gold-version --remove-section=.comment --remove-section=.note --remove-section=.note.GNU-stack --remove-section=.note.gnu.build-id --remove-section=.note.ABI-tag

# sudo apt install dietlibc-dev

small-c: small.c Makefile
	time diet gcc $(GCCFLAGS) -o $@ $<
	ls -l $@
	strip $(STRIPFLAGS) $@
	ls -l $@

clean:
	rm -f small-go small-tinygo small-zig small-c
