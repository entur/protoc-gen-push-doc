FROM debian:jessie-slim

WORKDIR /

# Install protoc-gen-doc
ADD https://github.com/google/protobuf/releases/download/v3.6.1/protoc-3.6.1-linux-x86_64.zip ./
RUN apt-get -q -y update && \
    apt-get -q -y install unzip && \
    unzip protoc-3.6.1-linux-x86_64.zip -d ./usr/local && \
    rm protoc-3.6.1-linux-x86_64.zip && \
    apt-get remove --purge -y unzip && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

ADD tools/protoc-gen-doc /usr/local/bin/

# Install git to pushback from Circle CI
RUN apt-get update -q -y && \ 
    apt-get -q -y install git

CMD ["/bin/bash"]
