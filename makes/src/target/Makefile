DOWNLOAD_DIR=${ROOT_DIR}/downloads/${TARGET_OS}-${TARGET_PORT}/
REPACK_DIR=${ROOT_DIR}/repack/${TARGET_OS}-${TARGET_PORT}/
BUILD_TARGET_DIR=${ROOT_DIR}/build/${TARGET_OS}-${TARGET_PORT}/${WPITARGET}/
TARGET_DIR=${ROOT_DIR}/targets/${TARGET_OS}
include ${TARGET_DIR}/version.env
include ${TARGET_DIR}/info.${TARGET_PORT}.env
export
.PHONY: all prep sysroot libcxx cmake-toolchain wrapper prep
all: libcxx cmake-toolchain wrapper pkg

prep:
	mkdir -p ${DOWNLOAD_DIR}
	mkdir -p ${BUILD_TARGET_DIR}
	cd ${DOWNLOAD_DIR}; bash ${TARGET_DIR}/download.sh
	cd ${DOWNLOAD_DIR}; bash ${TARGET_DIR}/repack.sh ${REPACK_DIR}

sysroot: prep cmake-toolchain
	cd ${BUILD_TARGET_DIR}; rm -rf sysroot-*
	cd ${BUILD_TARGET_DIR}; tar xf ${DOWNLOAD_DIR}/sysroot-libc-linux.tar.bz2
	cd ${BUILD_TARGET_DIR}; mkdir -p sysroot-install/
	cd ${BUILD_TARGET_DIR}; mv sysroot-libc-linux/ sysroot-install/$(TARGET_TUPLE)


libcxx: sysroot
	cd ${BUILD_TARGET_DIR}; bash ${ROOT_DIR}/makes/src/target/libcxx.sh

cmake-toolchain:
	cd ${BUILD_TARGET_DIR}; bash ${ROOT_DIR}/makes/src/target/cmake-toolchain.sh

wrapper:
	cd ${BUILD_TARGET_DIR}; bash ${ROOT_DIR}/makes/src/target/wrapper.sh

tree:
	cd ${BUILD_TARGET_DIR}; bash ${ROOT_DIR}/makes/src/target/tree.sh


TREEIN_DIRECTORY=${BUILD_TARGET_DIR}/tree-install/frc$(V_YEAR)/
TREEOUT_TEMPLATE=$(TARGET_PORT)-${TARGET_OS}-$(V_YEAR)-$(WPITARGET)-Toolchain-$(V_LLVM)
tarpkg:
	cd ${TREEIN_DIRECTORY}; tar czf ${BUILD_TARGET_DIR}/$(TREEOUT_TEMPLATE).tar.gz .
	cd ${TREEIN_DIRECTORY}; du -h ${BUILD_TARGET_DIR}/$(TREEOUT_TEMPLATE).tar.gz

zippkg:
	cd ${TREEIN_DIRECTORY}; zip -r $(BUILD_TARGET_DIR)/$(TREEOUT_TEMPLATE).zip .
	cd ${TREEIN_DIRECTORY}; du -h $(BUILD_TARGET_DIR)/$(TREEOUT_TEMPLATE).zip

pkg: tree
ifeq ($(WPITARGET), Windows)
	$(MAKE) zippkg
else
	$(MAKE) tarpkg
endif
print-treein:
	@echo ${TREEIN_DIRECTORY}

print-treeout:
	@echo $(TREEOUT_TEMPLATE)

print-pkg:
ifeq ($(WPITARGET), Windows)
	@echo $(TREEOUT_TEMPLATE).zip
else
	@echo $(TREEOUT_TEMPLATE).tar.gz
endif