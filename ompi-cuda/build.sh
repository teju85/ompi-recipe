## Attempt at building openmpi directly from git
## Didn't work out because of a mysterious "cannot find configuration file..."
## error! :(
##
## Why build from git?
## Latest dev versions of openmpi have fixes bugs in ompi-server which haven't
## been backported to previous versions. Hence, to include these fixes, build from
## source directly from git has been preferred.
# tmpBuildInstall=`pwd`/tmp-build-install
# export PATH=$tmpBuildInstall/bin:$PATH
# export AUTOMAKE_JOBS=4
# tmpInstall=`pwd`/ompi/tmp-install
#
# function build() {
#     pushd $1 && \
#         ./configure --prefix=$tmpBuildInstall && \
#         make -j${CPU_COUNT} && \
#         make install && \
#         popd
# }
#
# function buildOmpi() {
#     pushd ompi && \
#         ./autogen.pl && \
#         ./configure --prefix=$tmpInstall \
#                     --disable-dependency-tracking \
#                     --with-cuda && \
#         make -j${CPU_COUNT} all && \
#         make install && \
#         popd
# }
#
# mkdir -p $tmpBuildInstall && \
#     mkdir -p $tmpInstall && \
#     build m4 && \
#     build autoconf && \
#     build automake && \
#     build libtool && \
#     build flex && \
#     buildOmpi && \
#     cp -r $tmpInstall/* $PREFIX

export CC=`basename $CC`
export CXX=`basename $CXX`
export LIBRARY_PATH=$PREFIX/lib

pushd ompi && \
    ./configure --prefix=$PREFIX \
                --disable-dependency-tracking \
                --disable-mpi-fortran \
                --disable-wrapper-rpath \
                --disable-wrapper-runpath \
                --with-cuda \
                --with-sge \
                --with-wrapper-cflags="-I$PREFIX/include" \
                --with-wrapper-cxxflags="-I$PREFIX/include" \
                --with-wrapper-ldflags="-L$PREFIX/lib -Wl,-rpath,$PREFIX/lib" && \
    make -j${CPU_COUNT} all && \
    make install && \
    popd
