{ pkgs, ... }:
'' 
[alias]
b = "build"
c = "check"
t = "test"
r = "run"
rr = "run --release"
nxt = "nextest run"

[target.x86_64-unknown-linux-gnu]
linker = "${pkgs.clang}/bin/clang"
rustflags = ["-C", "link-arg=-fuse-ld=${pkgs.mold}/bin/ld.mold"]

[target.wasm32-unknown-unknown]
runner = "wasm-server-runner"
''
