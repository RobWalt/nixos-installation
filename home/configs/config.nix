{ pkgs, ... } :
'' 
[target.x86_64-unknown-linux-gnu]
linker = "${pkgs.clang}/bin/clang"
rustflags = ["-C", "link-arg=-fuse-ld=${pkgs.mold}/bin/ld.mold"]
''
