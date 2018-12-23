FROM ubuntu:latest
MAINTAINER Konrad Klimaszewski <graag666@gmail.com>

RUN apt-get -y update \
 && apt-get -y install build-essential libcurl4-openssl-dev libboost-regex-dev \
    libjsoncpp-dev liboauth-dev librhash-dev libtinyxml2-dev libhtmlcxx-dev \
    libboost-system-dev libboost-filesystem-dev libboost-program-options-dev \
    libboost-date-time-dev libboost-iostreams-dev help2man cmake libssl-dev \
    pkg-config git man vim gosu \
 && cd /opt \
 && git clone https://github.com/Sude-/lgogdownloader.git \
 && cd /opt/lgogdownloader \
 && git checkout 9bd416e \
 && mkdir build \
 && cd build \
 && cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release \
 && make \
 && make install \
 && cd \
 && apt-get -y remove build-essential libcurl4-openssl-dev libboost-regex-dev \
    libjsoncpp-dev liboauth-dev librhash-dev libtinyxml2-dev libhtmlcxx-dev \
    libboost-system-dev libboost-filesystem-dev libboost-program-options-dev \
    libboost-date-time-dev libboost-iostreams-dev help2man cmake libssl-dev \
    pkg-config git man \
 && apt-get -y autoremove \
 && apt-get -y install libboost-regex1.65.1 libjsoncpp1 liboauth0 librhash0 \
    libtinyxml2-6 libhtmlcxx3v5 libboost-system1.65.1 libboost-filesystem1.65.1 \
    libboost-program-options1.65.1 libboost-date-time1.65.1 libboost-iostreams1.65.1 \
    libcurl4 \
 && rm -rf /opt/lgogdownloader \
 && rm -rf /var/lib/apt/lists/*

VOLUME ["/home/user/.cache/lgogdownloader", "/home/user/.config/lgogdownloader", "/home/user/GOG"]
WORKDIR "/home/user/GOG"

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
