.PHONY: all llvm wrapper unify-install
all: llvm wrapper unify-install

HOST_BUILD_DIR=${ROOT_DIR}/build/${WPITARGET}/
export

prep_dir:
	mkdir -p "${HOST_BUILD_DIR}"

llvm: prep_dir
	cd ${HOST_BUILD_DIR}; bash ${ROOT_DIR}/makes/src/host/llvm.sh

wrapper: prep_dir
	cd ${HOST_BUILD_DIR}; bash ${ROOT_DIR}/makes/src/host/wrapper.sh

unify-install:
ifneq (${WPITARGET},Windows)
	cd ${HOST_BUILD_DIR}/llvm-install; rsync -a ./$(WPIPREFIX)/ "/usr/"
	cd ${HOST_BUILD_DIR}/wrapper-install; rsync -a ./$(WPIPREFIX)/ "/usr/"
endif
