FROM ubuntu:18.04
RUN apt-get update
RUN apt-get install -y \
        build-essential \
        git \
        libffi-dev \
        cmake \
        python3 \
        python3-dev \
        python3-pip \
        libpython3-dev \
        python3-distutils \
        devscripts \
        debhelper \
        rpm \
        libpcre3-dev \
        flex \
        bison \
        libcurl4-openssl-dev \
        libssh-dev \
        libxml2-dev \
        libxslt1-dev \
        swig \
        openssl \
        libssl-dev

WORKDIR /root
#RUN git clone -b devel https://github.com/CESNET/libyang
COPY libyang libyang
RUN mkdir -p libyang/build
WORKDIR libyang/build
RUN cmake -DGEN_LANGUAGE_BINDINGS=ON ..
RUN make
RUN make install

WORKDIR /root
#RUN git clone -b devel https://github.com/CESNET/libnetconf2
COPY libnetconf2 libnetconf2
RUN mkdir -p libnetconf2/build
WORKDIR libnetconf2/build
RUN cmake -DENABLE_PYTHON=ON ..
RUN make
RUN make install

WORKDIR /root
#RUN wget https://github.com/CESNET/Netopeer2GUI/releases/download/v0.2/ncgui.tgz
COPY ncgui.tgz .
RUN tar -xzvf ncgui.tgz
WORKDIR ncgui/backend
RUN pip3 install --upgrade pip virtualenv
RUN virtualenv venv
RUN . venv/bin/activate
RUN pip3 install -r requirements.txt

RUN ldconfig
