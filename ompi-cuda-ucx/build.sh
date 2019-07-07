export CC=`basename $CC`
export CXX=`basename $CXX`
export LIBRARY_PATH=$PREFIX/lib

#export LDFLAGS="$LDFLAGS -L/usr/lib/x86_64-linux-gnu"

pushd ucx && \
    ./contrib/configure-release --prefix=$PREFIX \
                                --disable-numa \
                                --with-cuda=/usr/local/cuda && \
    make -j${CPU_COUNT} && \
    make install && \
    popd && \
    pushd ompi && \
    ./configure --prefix=$PREFIX \
                --disable-dependency-tracking \
                --disable-mpi-fortran \
                --disable-wrapper-rpath \
                --disable-wrapper-runpath \
                --with-cuda \
                --with-sge \
                --with-ucx=$PREFIX \
                --with-wrapper-cflags="-I$PREFIX/include" \
                --with-wrapper-cxxflags="-I$PREFIX/include" \
                --with-wrapper-ldflags="-L$PREFIX/lib -Wl,-rpath,$PREFIX/lib" && \
    make -j${CPU_COUNT} all && \
    make install && \
    popd
