.PHONY: all llvm lld clang unify-install
all: llvm lld clang unify-install

llvm: llvm-build llvm-install
lld: lld-build lld-install
clang: clang-build clang-install

HOST_BUILD_DIR=${ROOT_DIR}/build/${WPITARGET}/
export

prep_dir:
	mkdir -p "${HOST_BUILD_DIR}"

llvm-build: prep_dir
	cd ${HOST_BUILD_DIR}; bash ${ROOT_DIR}/makes/src/host/llvm.sh
llvm-install: llvm-build
	# cd ${HOST_BUILD_DIR}/llvm-install; rsync -a ./$(WPIPREFIX)/ "/usr/"
	# cd ${HOST_BUILD_DIR}/llvm-install; rsync -a ./$(WPIPREFIX)/ "/${WPIPREFIX}/"

lld-build: prep_dir
	cd ${HOST_BUILD_DIR}; bash ${ROOT_DIR}/makes/src/host/lld.sh
lld-install: lld-build
	# cd ${HOST_BUILD_DIR}/lld-install; rsync -a ./$(WPIPREFIX)/ "/usr/"
	# cd ${HOST_BUILD_DIR}/lld-install; rsync -a ./$(WPIPREFIX)/ "/${WPIPREFIX}/"

clang-build: prep_dir
	cd ${HOST_BUILD_DIR}; bash ${ROOT_DIR}/makes/src/host/clang.sh
clang-install: clang-build
	# cd ${HOST_BUILD_DIR}/clang-install; rsync -a ./$(WPIPREFIX)/ "/usr/"
	# cd ${HOST_BUILD_DIR}/clang-install; rsync -a ./$(WPIPREFIX)/ "/${WPIPREFIX}/"

unify-install:
	rm -rf ${HOST_BUILD_DIR}/unify-install
	mkdir ${HOST_BUILD_DIR}/unify-install
	cd ${HOST_BUILD_DIR}/llvm-install; rsync -a ./$(WPIPREFIX)/ "/usr/"
	cd ${HOST_BUILD_DIR}/lld-install; rsync -a ./$(WPIPREFIX)/ "/usr/"
	cd ${HOST_BUILD_DIR}/clang-install; rsync -a ./$(WPIPREFIX)/ "/usr/"
