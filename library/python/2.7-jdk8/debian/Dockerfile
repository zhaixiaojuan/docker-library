FROM lcr.loongnix.cn/library/openjdk:8-sid

LABEL maintainer="yangzewei@loongson.cn"

# ensure local python is preferred over distribution python
ENV PATH /usr/local/bin:$PATH

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8

# runtime dependencies
RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates \
		netbase \
	; \
	rm -rf /var/lib/apt/lists/*

ENV PYTHON_VERSION 2.7.10

RUN set -eux; \
	\
	savedAptMark="$(apt-mark showmanual)"; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		dpkg-dev \
		gcc \
		gnupg dirmngr \
		libbluetooth-dev \
		libbz2-dev \
		libc6-dev \
		libexpat1-dev \
		libffi-dev \
		libgdbm-dev \
		liblzma-dev \
		libncursesw5-dev \
		libreadline-dev \
		libsqlite3-dev \
		libssl-dev \
		make \
		tk-dev \
		uuid-dev \
		wget \
		xz-utils \
		zlib1g-dev \
	; \
	wget -O python.tar.xz "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz"; \
	mkdir -p /usr/src/python; \
	tar --extract --directory /usr/src/python --strip-components=1 --file python.tar.xz; \
	rm python.tar.xz; \
	\
	cd /usr/src/python; \
# update config.sub && config.guess
	wget -O ./config.sub "git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.sub;hb=HEAD"; \
	wget -O ./config.guess "git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD"; \
	gnuArch="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)"; \
	./configure \
		--build="$gnuArch" \
		--with-ssl	\
		--with-system-ffi \
		--enable-shared \
		--with-ensurepip=upgrade \
		--with-system-expat \
	; \
	nproc="$(nproc)"; \
	make -j "$nproc" \
		LDFLAGS="-Wl,--strip-all" \

# setting PROFILE_TASK makes "--enable-optimizations" reasonable: https://bugs.python.org/issue36044 / https://github.com/docker-library/python/issues/160#issuecomment-509426916
		PROFILE_TASK='-m test.regrtest --pgo \
			test_array \
			test_base64 \
			test_binascii \
			test_binhex \
			test_binop \
			test_bytes \
			test_c_locale_coercion \
			test_class \
			test_cmath \
			test_codecs \
			test_compile \
			test_complex \
			test_csv \
			test_decimal \
			test_dict \
			test_float \
			test_fstring \
			test_hashlib \
			test_io \
			test_iter \
			test_json \
			test_long \
			test_math \
			test_memoryview \
			test_pickle \
			test_re \
			test_set \
			test_slice \
			test_struct \
			test_threading \
			test_time \
			test_traceback \
			test_unicode \
		' \
	; \
	make install; \
	\
	cd /; \
	rm -rf /usr/src/python; \
	\
	find /usr/local -depth \
		\( \
			\( -type d -a \( -name test -o -name tests -o -name idle_test \) \) \
			-o \( -type f -a \( -name '*.pyc' -o -name '*.pyo' -o -name 'libpython*.a' \) \) \
			-o \( -type f -a -name 'wininst-*.exe' \) \
		\) -exec rm -rf '{}' + \
	; \
	\
	ldconfig; \
	\
	find /usr/local -type f -executable -not \( -name '*tkinter*' \) -exec ldd '{}' ';' \
		| awk '/=>/ { print $(NF-1) }' \
		| sort -u \
		| xargs -r dpkg-query --search \
		| cut -d: -f1 \
		| sort -u \
	; \
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
	apt-get clean; \
	rm -rf /var/lib/apt/lists/* /var/cache/apt/* /tmp/*; \
	\
	python2 --version

# make some useful symlinks that are expected to exist ("/usr/local/bin/python" and friends)
#RUN set -eux; \
#	for src in idle pydoc python2 python2-config; do \
#		dst="$(echo "$src" | tr -d 2)"; \
#		[ -s "/usr/local/bin/$src" ]; \
#		[ ! -e "/usr/local/bin/$dst" ]; \
#		ln -svT "$src" "/usr/local/bin/$dst"; \
#	done

# if this is called "PIP_VERSION", pip explodes with "ValueError: invalid truth value '<VERSION>'"
# https://github.com/pypa/get-pip
ENV PYTHON_GET_PIP_URL https://bootstrap.pypa.io/pip/2.7/get-pip.py

WORKDIR /build
RUN wget https://files.pythonhosted.org/packages/24/49/7f567b628e14ee004938eec256cffeae7097db9e28576911ae7b84d2ff07/setuptools-41.1.0.post1.tar.gz && \
    tar -zxvf setuptools-41.1.0.post1.tar.gz && \
    cd setuptools-41.1.0.post1/ && python setup.py install && \
    wget https://files.pythonhosted.org/packages/aa/1a/62fb0b95b1572c76dbc3cc31124a8b6866cbe9139eb7659ac7349457cf7c/pip-19.2.2.tar.gz && \
    tar -zxvf pip-19.2.2.tar.gz && cd pip-19.2.2/ && python setup.py install && \
    rm -rf /build

CMD ["python2"]

