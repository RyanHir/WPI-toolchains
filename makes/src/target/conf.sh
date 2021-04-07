#! /usr/bin/env bash

set -e

rm -rf "${BUILD_DIR}/conf-install"
mkdir -p "${BUILD_DIR}/conf-install/${WPIPREFIX}/bin"
pushd "${BUILD_DIR}/conf-install/${WPIPREFIX}/bin"
cat << EOF > ${TARGET_TUPLE}.cfg
--target=${TARGET_TUPLE}
-mcpu=${TARGET_CPU}
-mfpu=${TARGET_FPU}
-mfloat-abi=${TARGET_FLOAT}
-fuse-ld=lld

-stdlib=libc++
-nostdinc++

EOF
popd
