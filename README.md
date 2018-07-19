a JavaCPP build
===

see https://github.com/bytedeco/javacpp-presets/wiki/Create-New-Presets


### configuration

- `JAVACPP_DIR`; (default `/tmp/javacpp`)
- `JAVACPP_PRESETS_DIR`; (default `/tmp/javacpp-presets`)
- `JAVACPP_REPO`; (default `https://github.com/bytedeco/javacpp`)
- `JAVACPP_PRESETS_REPO`; (default `https://github.com/bytedeco/javacpp-presets`)
- `JAVACPP_VER`; (default `1.4.1`)
- `PIGPIO_REPO`; (default `https://github.com/joan2937/pigpio`)

example of configuration to use alternative repos, local clones in this case

```
JAVACPP_VER=1.4.1 \
JAVACPP_REPO=file:///dev/code/community/javacpp \
JAVACPP_PRESETS_REPO=file:///dev/code/community/javacpp-presets \
PIGPIO_REPO=/dev/code/community/pigpio \
./build.sh clean
```

### ubuntu cross compilation

Packages

- `libc6-dev-armhf-cross`
- `gcc-arm-linux-gnueabihf`
- `linux-libc-dev-armhf-cross`

Exports

- `GCC_ARM_PREFIX=arm-linux-gnueabihf-`
