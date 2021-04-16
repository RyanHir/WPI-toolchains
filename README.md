# W.P.I. Toolchains

## Vocabulary
 * Host: The system in which code is compiled on
 * Target: The system in which the compiled code runs on 

## Supported Hosts
| Architecture | OS | Minimum Release |
| - | - | - |
| x86_64 | Linux | glibc 2.23 and Linux 4.4 |
| x86_64 | Windows | Windows 7 |
| i686 | Windows | Windows 7 |
| arm64 | Windows | Windows 10 |
| Universal | macOS | macOS 10.9 |

## Supported Targets

| Architecture | System | Tuple | Minimum Release |
| - | - | - | - |
| ARMv7 (softfp) | N.I. Linux (RoboRIO) | arm-nilrt-linux-gnueabi | Latest Image |
| ARMv6z | Raspberry Pi zero/one | arm-rasbi-linux-gnueabihf | glibc 2.24 and Linux 4.9 |
| ARMv7 | Generic | arm-linux-gnueabihf | glibc 2.27 and Linux 4.15 |
| ARMv8 (64bit) | Generic | aarch64-linux-gnu | glibc 2.27 and Linux 4.15 |

## Resources
 * [How to cross compile with LLVM based tools](https://archive.fosdem.org/2018/schedule/event/crosscompile/attachments/slides/2107/export/events/attachments/crosscompile/slides/2107/How_to_cross_compile_with_LLVM_based_tools.pdf)
   * Shows the different tools a LLVM toolchain contains and their function
 * [Linaro GCC toolchains](https://releases.linaro.org/components/toolchain/binaries/)
   * Good examples of (generic) ARM toolchains