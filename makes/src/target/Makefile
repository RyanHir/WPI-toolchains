.PHONY: all libcxx cmake-toolchain
all: libcxx cmake-toolchain

libcxx: libcxx-build
libcxx-build:
	cd ${BUILD_DIR}; bash ${ROOT_DIR}/makes/src/target/libcxx.sh

cmake-toolchain:
	cd ${BUILD_DIR}; bash ${ROOT_DIR}/makes/src/target/cmake-toolchain.sh
