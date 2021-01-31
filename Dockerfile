FROM isdnetworks/centos:8-ko
LABEL maintainer="is:-D Networks Docker Maintainers <jhcheong@isdnetworks.pe.kr>"

ADD omnicore-0.9.0-x86_64-linux-gnu.tar.gz /usr/local/
WORKDIR /usr/local/omnicore-0.9.0
RUN chown -R 0:0 . \
 && cp bin/* /usr/bin \
 && cp include/* /usr/include \
 && cp lib/libbitcoinconsensus.so.0.0.0 /usr/lib64 \
 && ln -s libbitcoinconsensus.so.0.0.0 /usr/lib64/libbitcoinconsensus.so.0 \
 && ln -s libbitcoinconsensus.so.0.0.0 /usr/lib64/libbitcoinconsensus.so \
 && ldconfig \
 && cp share/man/man1/* /usr/share/man/man1 \
 && cd .. \
 && rm -rf omnicore-0.9.0 \
 && useradd -m -s /bin/bash -u 1000 omnilayer

WORKDIR /home/omnilayer
USER omnilayer
RUN mkdir .bitcoin \
 && chmod 700 .bitcoin

VOLUME ["/home/omnilayer/.bitcoin"]

EXPOSE 8333/tcp 8333/udp 8332/tcp 18333/tcp 18333/udp 18332/tcp 18444/tcp 18444/udp 18443/tcp

CMD ["omnicored", "-printtoconsole", "-nodebuglogfile"]

