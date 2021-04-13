# W.P.I. Toolchains

## Vocabulary
 * Host: The system in which code is compiled on
 * Target: The system in which the compiled code runs on 

## Supported Hosts
| Architecture | OS | Requirments |
| - | - | - |
| x86_64 | Linux | glibc 2.23 >= |
| x86_64 | MacOS | 10.10 >= |
| x86_64 | Windows | 7 >= |
| i686 | Windows | 7 >= |
| arm64 | Windows | 10 >= |
| Sysroot Only | - | - |

### Using Compatability Layers
  * Use x86_64 macOS builds for macOS on Apple Silicon

## Supported Targets

| Architecture | Operating System | Tuple |
| - | - | - |
| ARMv7 (softfp) | N.I. Linux (RoboRIO) | arm-nilrt-linux-gnueabi |
| ARMv6z | RPiOS 32bit | arm-rasbi-linux-gnueabihf |
| ARMv7 | Debian/Ubuntu | arm-linux-gnueabihf |
| ARMv8 (64bit) | Debian/Ubuntu/RPiOS 64bit | aarch64-linux-gnu |
-----

## Resources
 * [How to cross compile with LLVM based tools](https://archive.fosdem.org/2018/schedule/event/crosscompile/attachments/slides/2107/export/events/attachments/crosscompile/slides/2107/How_to_cross_compile_with_LLVM_based_tools.pdf)
   * Shows the different tools a LLVM toolchain contains and their function
 * [Linaro GCC toolchains](https://releases.linaro.org/components/toolchain/binaries/)
   * Good examples of (generic) ARM toolchains