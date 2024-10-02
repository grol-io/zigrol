
all: small-go small-tinygo small-zig sizes

sizes:
	ls -lh small-go small-tinygo small-zig

small-go:
	CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -o small-go small.go

small-tinygo:
	CGO_ENABLED=0 tinygo build -o small-tinygo small.go
	strip small-tinygo

small-zig:
	zig build-exe -O ReleaseSmall --name small-zig small.zig

clean:
	rm -f small-go small-tinygo small-zig
