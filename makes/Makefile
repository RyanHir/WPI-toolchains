include $(ROOT_DIR)/consts.env
include $(ROOT_DIR)/targets/${TOOLCHAIN_NAME}/version.env
include $(ROOT_DIR)/targets/${TOOLCHAIN_NAME}/version.${TARGET_PORT}.env

build-host: llvm-host
build-target: sysroot llvm-target

sysroot: cmake-toolchain
	cd ${BUILD_DIR}; rm -rf sysroot-*
	cd ${BUILD_DIR}/; tar xf ${DOWNLOAD_DIR}/sysroot-libc-linux.tar.bz2
	cd ${BUILD_DIR}/; mkdir -p sysroot-install/
	cd ${BUILD_DIR}/; mv sysroot-libc-linux/ sysroot-install/$(TARGET_TUPLE)

llvm-host:
	${MAKE} -C ${ROOT_DIR}/makes/src/host
llvm-target:
	${MAKE} -C ${ROOT_DIR}/makes/src/target

tree:
	cd ${BUILD_DIR}; bash ${ROOT_DIR}/makes/src/tree

TREEIN_DIRECTORY=${BUILD_DIR}/tree-install/frc$(V_YEAR)/
TREEOUT_TEMPLATE=$(TARGET_PORT)-${TOOLCHAIN_NAME}-$(V_YEAR)-$(WPITARGET)-Toolchain-$(V_GCC)
tarpkg:
	cd ${TREEIN_DIRECTORY}; tar czf ${M}/$(TREEOUT_TEMPLATE).tar.gz .
	cd ${TREEIN_DIRECTORY}; du -h ${M}/$(TREEOUT_TEMPLATE).tar.gz

zippkg:
	cd ${TREEIN_DIRECTORY}; zip -r $(M)/$(TREEOUT_TEMPLATE).zip .
	cd ${TREEIN_DIRECTORY}; du -h $(M)/$(TREEOUT_TEMPLATE).zip

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
