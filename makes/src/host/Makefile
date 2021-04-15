.PHONY: all llvm wrapper unify-install
all: llvm wrapper unify-install

export

prep_dir:
	mkdir -p "${BUILD_HOST_DIR}"

llvm: prep_dir
	cd ${BUILD_HOST_DIR}; bash ${ROOT_DIR}/makes/src/host/llvm.sh

wrapper: prep_dir
	cd ${BUILD_HOST_DIR}; bash ${ROOT_DIR}/makes/src/host/wrapper.sh

unify-install:
ifneq (${WPITARGET},Windows)
	cd ${BUILD_HOST_DIR}/llvm-install; rsync -a ./$(WPIPREFIX)/ "/usr/"
	cd ${BUILD_HOST_DIR}/wrapper-install; rsync -a ./$(WPIPREFIX)/ "/usr/"
endif
