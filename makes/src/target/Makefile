.PHONY: all libcxx conf cmake-toolchain
all: libcxx conf cmake-toolchain

libcxx: libcxx-build
libcxx-build:
	cd ${BUILD_DIR}; bash ${ROOT_DIR}/makes/src/target/libcxx.sh

conf: conf-build
conf-build:
	cd ${BUILD_DIR}; bash ${ROOT_DIR}/makes/src/target/conf.sh

cmake-toolchain:
	cd ${BUILD_DIR}; bash ${ROOT_DIR}/makes/src/cmake-toolchain.sh
