# Common Ambient Variables:
#   CURRENT_BUILDTREES_DIR    = ${VCPKG_ROOT_DIR}\buildtrees\${PORT}
#   CURRENT_PACKAGES_DIR      = ${VCPKG_ROOT_DIR}\packages\${PORT}_${TARGET_TRIPLET}
#   CURRENT_PORT_DIR          = ${VCPKG_ROOT_DIR}\ports\${PORT}
#   PORT                      = current port name (zlib, etc)
#   TARGET_TRIPLET            = current triplet (x86-windows, x64-windows-static, etc)
#   VCPKG_CRT_LINKAGE         = C runtime linkage type (static, dynamic)
#   VCPKG_LIBRARY_LINKAGE     = target library linkage type (static, dynamic)
#   VCPKG_ROOT_DIR            = <C:\path\to\current\vcpkg>
#   VCPKG_TARGET_ARCHITECTURE = target architecture (x64, x86, arm)
#
include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO jmcnamara/libxlsxwriter
    REF RELEASE_0.7.7
    SHA512 ab20b3178701ea0146ac7e26956e064694e1abf81af64090b9a8c4f32ff97fb7c16eb86e24c955d16a155fb69f23193ff331306ab902dec1a244c91258d9524f
    #HEAD_REF master
)

# set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/libxlsxwriter-RELEASE_0.7.7)
# vcpkg_download_distfile(ARCHIVE
    # URLS "https://github.com/jmcnamara/libxlsxwriter/archive/RELEASE_0.7.7.zip"
    # FILENAME "libxlsxwriter-0.7.7.zip"
    # SHA512 5655d61d67fd50ef522a6eff4f36cdf50177efa5f2d0c56b1df5721225e83c88331fa1d45e731599b3b8140d4088ee303a8b652482a9e089082267612250a831
# )

#vcpkg_extract_source_archive(${ARCHIVE})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    # OPTIONS -DUSE_THIS_IN_ALL_BUILDS=1 -DUSE_THIS_TOO=2
    # OPTIONS_RELEASE -DOPTIMIZE=1
    # OPTIONS_DEBUG -DDEBUGGABLE=1
)

vcpkg_install_cmake()

#vcpkg_fixup_cmake_targets()

# Handle copyright

file(INSTALL ${SOURCE_PATH}/License.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/libxlsxwriter RENAME copyright)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

vcpkg_copy_pdbs()