FROM debian:bullseye-slim

ENV CC="clang" \
  CFLAGS="-ggdb3 -gdwarf-4 -DZEND_RC_DEBUG=1"

ENV PHPIZE_DEPS \
  autoconf \
  dpkg-dev \
  file \
  g++ \
  gcc \
  libc-dev \
  make \
  pkg-config \
  re2c

WORKDIR /usr/src

RUN apt-get update \
  && apt-get -y --no-install-recommends install \
    ca-certificates \
    build-essential \
    automake \
    bison \
    clang \
    llvm \
    gdb \
    git \
    valgrind \
    libtool-bin \
    libreadline-dev \
    $PHPIZE_DEPS \
  && echo 'set auto-load safe-path /' > /root/.gdbinit \
  && echo '* soft core unlimited' >> /etc/security/limits.conf \
  && apt-get clean

RUN git clone --depth=1 https://github.com/php/php-src.git

WORKDIR /usr/src/php-src

RUN ./buildconf -f \
  && ./configure \
    --disable-all \
    --disable-opcache \
    --enable-debug \
    --with-valgrind \
  && make -j$(nproc) \
  && make install \
  && ldconfig \
  && php --version
