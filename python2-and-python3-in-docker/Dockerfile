# Starts with python:3.14.7-bookworm and then installs most of python:2.7.15 on top
# to allows us to choose Python versions at runtime via: python2, python3, pip2, pip3, etc.
FROM python:3.14.7-bookworm

ENV GPG_KEY=C01E1CAD5EA2C4F0B8E3571504C367C218ADD4FF
ENV PYTHON_VERSION=2.7.15

# if this is called "PIP_VERSION", pip explodes with "ValueError: invalid truth value '<VERSION>'"
ENV PYTHON_PIP_VERSION=18.1

RUN set -ex \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends \
		gnupg \
		wget \
		tar \
		xz-utils \
		ca-certificates \
	\
	&& wget -O python.tar.xz "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz" \
	&& wget -O python.tar.xz.asc "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz.asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --keyserver keyserver.ubuntu.com --recv-keys "$GPG_KEY" \
	&& gpg --batch --verify python.tar.xz.asc python.tar.xz \
	&& rm -r "$GNUPGHOME" python.tar.xz.asc \
	&& mkdir -p /usr/src/python \
	&& tar -xJC /usr/src/python --strip-components=1 -f python.tar.xz \
	&& rm python.tar.xz \
	\
	&& apt-get install -y --no-install-recommends \
		bzip2 \
		gcc \
		libbz2-dev \
		libgdbm-dev \
		libc6-dev \
		libncurses5-dev \
		libreadline-dev \
		libsqlite3-dev \
		libssl-dev \
		libffi-dev \
		tcl-dev \
		tk-dev \
		zlib1g-dev \
		make \
	\
	&& cd /usr/src/python \
	&& CFLAGS="-std=c11" ./configure \
		--enable-shared \
		--enable-unicode=ucs4 \
	&& make -j$(getconf _NPROCESSORS_ONLN) \
	&& make install \
	&& ldconfig \
	\
	&& wget -O /tmp/get-pip.py 'https://bootstrap.pypa.io/pip/2.7/get-pip.py' \
	&& python2 /tmp/get-pip.py "pip==$PYTHON_PIP_VERSION" \
	&& rm /tmp/get-pip.py \
	\
	&& find /usr/local -depth \
		\( \
			\( -type d -a -name test -o -name tests \) \
			-o \
			\( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
		\) -exec rm -rf '{}' + \
	&& apt-get purge -y --auto-remove \
		gcc \
		libbz2-dev \
		libgdbm-dev \
		libc6-dev \
		libncurses5-dev \
		libreadline-dev \
		libsqlite3-dev \
		libssl-dev \
		libffi-dev \
		tcl-dev \
		tk-dev \
		zlib1g-dev \
		make \
	&& apt-get clean \
	&& rm -rf /usr/src/python ~/.cache /var/lib/apt/lists/*

RUN ls -Fla /usr/local/bin/p* \
    && which python  && python -V \
    && which python2 && python2 -V \
    && which python3 && python3 -V \
    && which pip     && pip -V \
    && which pip2    && pip2 -V \
    && which pip3    && pip3 -V

CMD ["python2"]
