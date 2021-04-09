.PHONY: all llvm lld clang unify-install
all: llvm lld clang unify-install

HOST_BUILD_DIR=${ROOT_DIR}/build/${WPITARGET}/
export

prep_dir:
	mkdir -p "${HOST_BUILD_DIR}"

llvm: prep_dir
	cd ${HOST_BUILD_DIR}; bash ${ROOT_DIR}/makes/src/host/llvm.sh

lld: prep_dir
	# cd ${HOST_BUILD_DIR}; bash ${ROOT_DIR}/makes/src/host/lld.sh

clang: prep_dir
	# cd ${HOST_BUILD_DIR}; bash ${ROOT_DIR}/makes/src/host/clang.sh

unify-install:
ifneq (${WPITARGET},Windows)
	cd ${HOST_BUILD_DIR}/llvm-install; rsync -a ./$(WPIPREFIX)/ "/usr/"
	# cd ${HOST_BUILD_DIR}/lld-install; rsync -a ./$(WPIPREFIX)/ "/usr/"
	# cd ${HOST_BUILD_DIR}/clang-install; rsync -a ./$(WPIPREFIX)/ "/usr/"
endif
