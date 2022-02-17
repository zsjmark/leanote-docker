FROM debian:bullseye-slim

RUN set -eux; \
    #
	# 国内源
    sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list; \
	sed -i 's/security.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list; \
	#
	#
	apt-get update; \
	apt-get install -y  --no-install-recommends\		
		wget \
        vim \
        wkhtmltopdf \
	; \
	rm -rf /var/lib/apt/lists/*
ADD mongodb-database-tools-debian10-x86_64-100.5.2.tgz /opt
RUN cd /opt/mongodb-database-tools-debian10-x86_64-100.5.2; \
    cp bin/* /usr/local/bin/ -rf
   # wget "$MONGODB_DATABASE_TOOLS" ; \
   # tar zxvf $MONGODB_DATABASE_TOOLS

ADD leanote-linux-amd64-v2.6.1.bin.tar.gz /
RUN ls -alh /leanote; \
    chmod +x /leanote/bin/run.sh
VOLUME /leanote/files
VOLUME /leanote/public/upload
ENTRYPOINT ["/leanote/bin/run.sh"]
#ENTRYPOINT ["/bin/bash"]
