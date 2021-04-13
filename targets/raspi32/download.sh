#! /usr/bin/env bash

source "$(dirname "$0")/version.env" || exit
source "${SCRIPT_DIR}/downloads_tools.sh" || exit

package-debian g/gcc-6/libgcc1_${Va_LIBGCC}_${TARGET_PORT}.deb
package-debian g/gcc-6/libgcc-6-dev_${Va_LIBGCC}_${TARGET_PORT}.deb
package-debian g/gcc-6/libatomic1_${Va_LIBGCC}_${TARGET_PORT}.deb
package-debian g/gcc-6/libatomic1-dbg_${Va_LIBGCC}_${TARGET_PORT}.deb
package-debian g/gcc-6/libstdc++6_${Va_LIBGCC}_${TARGET_PORT}.deb
package-debian g/gcc-6/libstdc++-6-dev_${Va_LIBGCC}_${TARGET_PORT}.deb
package-debian g/gcc-6/libasan5_${Va_LIBGCC}_${TARGET_PORT}.deb
package-debian g/gcc-6/liblsan0_${Va_LIBGCC}_${TARGET_PORT}.deb
package-debian g/gcc-6/libtsan0_${Va_LIBGCC}_${TARGET_PORT}.deb
package-debian g/gcc-6/libgomp1_${Va_LIBGCC}_${TARGET_PORT}.deb
package-debian g/gcc-6/libubsan1_${Va_LIBGCC}_${TARGET_PORT}.deb
package-debian g/gcc-6/libitm1_${Va_LIBGCC}_${TARGET_PORT}.deb
package-debian g/glibc/libc6_${Va_LIBC}_${TARGET_PORT}.deb
package-debian g/glibc/libc6-dev_${Va_LIBC}_${TARGET_PORT}.deb
package-debian l/linux-4.9/linux-libc-dev_${Va_LINUX}_${TARGET_PORT}.deb
