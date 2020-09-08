FROM quay.io/pypa/manylinux2014_x86_64



RUN yum install -y munge mariadb-devel wget curl libcurl libcurl-devel lz4-devel

ENV SLURM_VERSION="20.02.4"

RUN mkdir -p /srv/out &&  mkdir -p /srv/tar-out && \
    ln -s /opt/_internal/cpython-3.9.0b5/bin/python3 /usr/bin/python3 && \
    wget https://download.schedmd.com/slurm/slurm-$SLURM_VERSION.tar.bz2 && \
    tar -xvjf slurm-$SLURM_VERSION.tar.bz2 && \
    cd slurm-$SLURM_VERSION && \
    ./configure \
          --prefix=/srv/out \
          --with-libcurl \
          --with-munge=/usr/lib64 && \
      make -j$(nproc) && \
      make install && \
      tar -czvf /srv/tar-out/slurm.tar.gz /srv/out/*


