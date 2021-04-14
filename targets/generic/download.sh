#! /usr/bin/env bash

source "$(dirname "$0")/version.env" || exit
source "${SCRIPT_DIR}/downloads_tools.sh" || exit

package-debian g/gcc-8/libgcc1_${Va_LIBGCC}_${TARGET_PORT}.deb
package-debian g/gcc-8/libgcc-8-dev_${Va_LIBGCC}_${TARGET_PORT}.deb
package-debian g/gcc-8/libatomic1_${Va_LIBGCC}_${TARGET_PORT}.deb
package-debian g/gcc-8/libatomic1-dbg_${Va_LIBGCC}_${TARGET_PORT}.deb
package-debian g/gcc-8/libstdc++6_${Va_LIBGCC}_${TARGET_PORT}.deb
package-debian g/gcc-8/libstdc++-8-dev_${Va_LIBGCC}_${TARGET_PORT}.deb
package-debian g/gcc-8/libgomp1_${Va_LIBGCC}_${TARGET_PORT}.deb
package-debian g/gcc-8/libasan5_${Va_LIBGCC}_${TARGET_PORT}.deb
package-debian g/gcc-8/libubsan1_${Va_LIBGCC}_${TARGET_PORT}.deb
package-debian g/glibc/libc6_${Va_LIBC}_${TARGET_PORT}.deb
package-debian g/glibc/libc6-dev_${Va_LIBC}_${TARGET_PORT}.deb
package-debian l/linux/linux-libc-dev_${Va_LINUX}_${TARGET_PORT}.deb


if [ "$TARGET_PORT" != "armhf" ]; then
    package-debian g/gcc-8/libtsan0_${Va_LIBGCC}_${TARGET_PORT}.deb
    package-debian g/gcc-8/liblsan0_${Va_LIBGCC}_${TARGET_PORT}.deb
    package-debian g/gcc-8/libitm1_${Va_LIBGCC}_${TARGET_PORT}.deb
fi
