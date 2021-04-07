.PHONY: all llvm lld clang
all: llvm lld clang

llvm: llvm-build llvm-install
lld: lld-build lld-install
clang: clang-build clang-install

llvm-build:
	cd ${BUILD_DIR}; bash ${ROOT_DIR}/makes/src/host/llvm.sh
llvm-install: llvm-build
	cd ${BUILD_DIR}; rsync -a ${BUILD_DIR}/llvm-install/$(WPIPREFIX)/ "/usr/"
	cd ${BUILD_DIR}; rsync -a ${BUILD_DIR}/llvm-install/$(WPIPREFIX)/ "/${WPIPREFIX}/"

lld-build:
	cd ${BUILD_DIR}; bash ${ROOT_DIR}/makes/src/host/lld.sh
lld-install: lld-build
	cd ${BUILD_DIR}; rsync -a ${BUILD_DIR}/lld-install/$(WPIPREFIX)/ "/usr/"
	cd ${BUILD_DIR}; rsync -a ${BUILD_DIR}/lld-install/$(WPIPREFIX)/ "/${WPIPREFIX}/"

clang-build:
	cd ${BUILD_DIR}; bash ${ROOT_DIR}/makes/src/host/clang.sh
clang-install: clang-install
	cd ${BUILD_DIR}; rsync -a ${BUILD_DIR}/clang-install/$(WPIPREFIX)/ "/usr/"
	cd ${BUILD_DIR}; rsync -a ${BUILD_DIR}/clang-install/$(WPIPREFIX)/ "/${WPIPREFIX}/"
