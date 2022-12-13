#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#
FROM ghcr.io/oanhnn/php:8.2-zts-alpine AS builder

ARG NGINX_UNIT_VERSION=1.28.0

RUN set -ex ;\
    apk add --update --no-cache --virtual .build-deps \
        ca-certificates \
        mercurial \
        build-base \
        openssl-dev \
        pcre2-dev \
    ;\
    mkdir -p /usr/lib/unit/modules /usr/lib/unit/debug-modules ;\
    hg clone https://hg.nginx.org/unit ;\
    cd unit ;\
    hg up $NGINX_UNIT_VERSION ;\
    NCPU="$(getconf _NPROCESSORS_ONLN)" ;\
#     CC_OPT="-fstack-protector-strong -fpic -fpie -O2 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64" ;\
#     LD_OPT="-Wl,-O1 -pie" ; \
    CONFIGURE_ARGS="--prefix=/usr \
                --state=/var/lib/unit \
                --control=unix:/var/run/control.unit.sock \
                --pid=/var/run/unit.pid \
                --log=/var/log/unit.log \
                --user=www-data \
                --group=www-data \
                --openssl \
                --libdir=/usr/lib" \
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
        | awk 'gsub("/usr/lib/","",$1)>0{print "so:" $1}' \
        | sort -u \
    > /requirements.txt


FROM ghcr.io/oanhnn/php:8.2-zts-alpine

COPY docker-entrypoint.sh /usr/local/bin/
COPY --from=builder /usr/sbin/unitd /usr/sbin/unitd
COPY --from=builder /usr/sbin/unitd-debug /usr/sbin/unitd-debug
COPY --from=builder /usr/lib/unit/ /usr/lib/unit/
COPY --from=builder /requirements.txt /requirements.txt

# Alpine's version of ldconfig requires you to specify the target folder or library as an argument.
RUN ldconfig /

RUN set -x ;\
    mkdir -p /var/lib/unit/ ;\
    mkdir /docker-entrypoint.d/ ;\
    apk add --update --no-cache --virtual .unitd-run-deps \
        curl \
        $(cat /requirements.txt) \
    ;\
    rm -f /requirements.txt ;\
    ln -sf /dev/stdout /var/log/unit.log ;

STOPSIGNAL SIGTERM

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

CMD ["unitd", "--no-daemon", "--control", "unix:/var/run/control.unit.sock"]
