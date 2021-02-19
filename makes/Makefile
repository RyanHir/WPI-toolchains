include ${ROOT_DIR}/consts.env
include ${ROOT_DIR}/targets/${TOOLCHAIN_NAME}/version.env

all: clean test-cc sysroot binutils gcc gdb tree tarpkg

sysroot:
	cd ${M}; rm -rf sysroot-*
	cd ${M}; mkdir sysroot-libc-linux
	cd ${M}/sysroot-libc-linux; tar xf ${REPACK_DIR}/libc6-frc$(V_YEAR)-armel-cross_$(Va_LIBC).orig.tar.bz2
	cd ${M}/sysroot-libc-linux; tar xf ${REPACK_DIR}/linux-libc-dev-frc$(V_YEAR)-armel-cross_$(Va_LINUX).orig.tar.bz2
	cd ${M}/sysroot-libc-linux; tar xf ${REPACK_DIR}/libgcc1-frc$(V_YEAR)-armel-cross_$(Va_LIBGCC).orig.tar.bz2
	cd ${M}/sysroot-libc-linux; tar xf ${REPACK_DIR}/libstdc++6-frc$(V_YEAR)-armel-cross_$(Va_LIBSTDCPP).orig.tar.bz2
	cd ${M}; ${ROOT_DIR}/makes/src/sysroot

binutils:
	cd ${M}; tar xf ${DOWNLOAD_DIR}/binutils-$(V_BINUTILS).tar.bz2
	cd ${M}; V_YEAR=$(V_YEAR) V_BINUTILS=$(V_BINUTILS) ${ROOT_DIR}/makes/src/binutils

gdb:
	cd ${M}; tar xf ${PROJ_DIR}/gdb-$(V_GDB).tar.gz
	cd ${M}; V_YEAR=$(V_YEAR) V_GDB=$(V_GDB) ${ROOT_DIR}/src/gdb

gcc:
	@# gcc does its own extraction
	cd ${M}; ${ROOT_DIR}/src/gcc

tree:
	cd ${M}; V_YEAR=$(V_YEAR) V_GCC=$(V_GCC) ${ROOT_DIR}/src/tree

tarpkg:
	cd ${M}; mkdir -p frc$(V_YEAR)
	cd ${M}; mkdir -p frc$(V_YEAR)/roborio
	cd ${M}; cp -R tree-install/usr/local/* frc$(V_YEAR)/roborio/
	cd ${M}; tar czf FRC-$(V_YEAR)-$(FRCTARGET)-Toolchain-$(V_GCC).tar.gz frc$(V_YEAR)

clean:
	cd ${M}; rm -rf binutils* roborio* sysroot* gcc* tree-install gdb* *-Toolchain-*.tar.gz