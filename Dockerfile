FROM python:3.7-slim

ENV DEBIAN_FRONTEND=noninteractive
RUN BUILDPKGS="build-essential zlib1g-dev git" && \
    apt-get update && \
    apt-get install -y --no-install-recommends apt-utils debconf locales && dpkg-reconfigure locales && \
    apt-get install -y --no-install-recommends $BUILDPKGS

RUN pip install snaptools==1.4.8

RUN apt-get -y update && \
    apt-get -y --no-install-recommends install \
        # Need to run ps
        procps \
        less && \
    rm -rf /var/cache/apt/* && \
    rm -rf /var/lib/apt/lists/*

