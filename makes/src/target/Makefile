.PHONY: all libcxx conf
all: libcxx conf

libcxx: libcxx-build
libcxx-build:
	cd ${BUILD_DIR}; bash ${ROOT_DIR}/makes/src/target/libcxx.sh

conf: conf-build
conf-build:
	cd ${BUILD_DIR}; bash ${ROOT_DIR}/makes/src/target/conf.sh
