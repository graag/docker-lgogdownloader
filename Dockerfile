FROM ubuntu:latest
MAINTAINER Konrad Klimaszewski <graag666@gmail.com>

RUN apt-get -y update \
 && apt-get -y install build-essential libcurl4-openssl-dev libboost-regex-dev \
    libjsoncpp-dev liboauth-dev librhash-dev libtinyxml2-dev libhtmlcxx-dev \
    libboost-system-dev libboost-filesystem-dev libboost-program-options-dev \
    libboost-date-time-dev libboost-iostreams-dev help2man cmake libssl-dev \
    pkg-config git man vim gosu \
 && rm -rf /var/lib/apt/lists/*

RUN cd /opt \
 && git clone https://github.com/Sude-/lgogdownloader.git \
 && cd /opt/lgogdownloader \
 && mkdir build \
 && cd build \
 && cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release \
 && make \
 && make install \
 && cd .. \
 && rm -rf build

VOLUME ["/home/user/.cache/lgogdownloader", "/home/user/.config/lgogdownloader", "/home/user/GOG"]
WORKDIR "/home/user/GOG"

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
