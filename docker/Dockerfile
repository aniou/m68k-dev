ARG UbuntuVersion=22.04
FROM ubuntu:$UbuntuVersion as tools-build

RUN apt update && apt install -y wget build-essential file flex libz-dev libzstd-dev

# binutils download
WORKDIR /src
ARG BinutilsVersion=2.41
RUN wget https://ftp.gnu.org/gnu/binutils/binutils-$BinutilsVersion.tar.xz 
RUN tar xf binutils-$BinutilsVersion.tar.xz 

# binutils build
WORKDIR /src/binutils-$BinutilsVersion
RUN ./configure --target=m68k-elf 
RUN make 
RUN make install

# gcc download
WORKDIR /src
ARG Gcc12Version=12.3.0
RUN wget https://gcc.gnu.org/pub/gcc/releases/gcc-$Gcc12Version/gcc-$Gcc12Version.tar.gz
RUN tar xf gcc-$Gcc12Version.tar.gz
RUN cd /src/gcc-$Gcc12Version && ./contrib/download_prerequisites

# Build x86_64-gcc-12
WORKDIR /src
RUN /src/gcc-$Gcc12Version/configure \
    --target=m68k-elf \
    --enable-languages=c \
    --disable-bootstrap \
    --disable-libssp \
    --disable-debug \
    --disable-dependency-tracking \
    --disable-silent-rules \
    --disable-nls
RUN make all-gcc all-target-libgcc
RUN make install-gcc install-target-libgcc

ARG UbuntuVersion=22.04
FROM ubuntu:$UbuntuVersion as tools-prod
WORKDIR /
COPY --from=tools-build /usr/local /usr/local
RUN apt update && \
    apt -y install libc6-dev-m68k-cross elvis-tiny make build-essential byacc && \
    update-alternatives --set yacc /usr/bin/byacc
#USER 1000:1000
CMD bash
# eof
