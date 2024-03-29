#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#
FROM ghcr.io/oanhnn/php:8.3-cli AS builder

ARG NGINX_UNIT_VERSION=1.28.0

RUN set -ex ;\
    apt-get update ;\
    apt-get install --no-install-recommends --no-install-suggests -y \
        ca-certificates \
        mercurial \
        build-essential \
        libssl-dev \
        libpcre2-dev \
    ;\
    mkdir -p /usr/lib/unit/modules /usr/lib/unit/debug-modules ;\
    hg clone https://hg.nginx.org/unit ;\
    cd unit ;\
    hg up $NGINX_UNIT_VERSION ;\
    NCPU="$(getconf _NPROCESSORS_ONLN)" ;\
    DEB_HOST_MULTIARCH="$(dpkg-architecture -q DEB_HOST_MULTIARCH)" ;\
    CC_OPT="$(DEB_BUILD_MAINT_OPTIONS="hardening=+all,-pie" DEB_CFLAGS_MAINT_APPEND="-Wp,-D_FORTIFY_SOURCE=2 -fPIC" dpkg-buildflags --get CFLAGS)" ;\
    LD_OPT="$(DEB_BUILD_MAINT_OPTIONS="hardening=+all,-pie" DEB_LDFLAGS_MAINT_APPEND="-Wl,--as-needed -pie" dpkg-buildflags --get LDFLAGS)" ;\
    CONFIGURE_ARGS="--prefix=/usr \
        --state=/var/lib/unit \
        --control=unix:/var/run/control.unit.sock \
        --pid=/var/run/unit.pid \
        --log=/var/log/unit.log \
        --tmp=/var/tmp \
        --user=www-data \
        --group=www-data \
        --openssl \
        --libdir=/usr/lib/$DEB_HOST_MULTIARCH" \
    ;\
    ./configure $CONFIGURE_ARGS --cc-opt="$CC_OPT" --ld-opt="$LD_OPT" --modules=/usr/lib/unit/debug-modules --debug ;\
    make -j $NCPU unitd ;\
    install -pm755 build/unitd /usr/sbin/unitd-debug ;\
    make clean ;\
    ./configure $CONFIGURE_ARGS --cc-opt="$CC_OPT" --ld-opt="$LD_OPT" --modules=/usr/lib/unit/modules ;\
    make -j $NCPU unitd ;\
    install -pm755 build/unitd /usr/sbin/unitd ;\
    make clean ;\
    ./configure $CONFIGURE_ARGS --cc-opt="$CC_OPT" --modules=/usr/lib/unit/debug-modules --debug ;\
    ./configure php ;\
    make -j $NCPU php-install ;\
    make clean ;\
    ./configure $CONFIGURE_ARGS --cc-opt="$CC_OPT" --modules=/usr/lib/unit/modules ;\
    ./configure php ;\
    make -j $NCPU php-install ;\
    ldd /usr/sbin/unitd \
        | awk '/=>/{print $(NF-1)}' \
        | while read n; do dpkg-query -S $n; done \
        | sed 's/^\([^:]\+\):.*$/\1/' \
        | sort -u \
    > /requirements.txt


FROM ghcr.io/oanhnn/php:8.3-cli

COPY docker-entrypoint.sh /usr/local/bin/
COPY --from=builder /usr/sbin/unitd /usr/sbin/unitd
COPY --from=builder /usr/sbin/unitd-debug /usr/sbin/unitd-debug
COPY --from=builder /usr/lib/unit/ /usr/lib/unit/
COPY --from=builder /requirements.txt /requirements.txt

RUN ldconfig

RUN set -x ;\
    if [ -f "/tmp/libunit.a" ]; then \
        mv /tmp/libunit.a /usr/lib/$(dpkg-architecture -q DEB_HOST_MULTIARCH)/libunit.a; \
        rm -f /tmp/libunit.a; \
    fi ;\
    mkdir -p /var/lib/unit/ ;\
    mkdir /docker-entrypoint.d/ ;\
    apt update ;\
    apt install --no-install-recommends --no-install-suggests -y \
        curl \
        $(cat /requirements.txt) \
    ;\
    apt-get clean rm -rf /var/lib/apt/lists/* ;\
    rm -f /requirements.txt ;\
    ln -sf /dev/stdout /var/log/unit.log ;

STOPSIGNAL SIGTERM

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

CMD ["unitd", "--no-daemon", "--control", "unix:/var/run/control.unit.sock"]
