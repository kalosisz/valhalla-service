#!/usr/bin/env bash
set -e

apt-get update && apt-get update --fix-missing

# valhalla requirements
apt-get install --no-install-recommends -y \
  apt-utils cmake make curl wget unzip jq ca-certificates \
  gnupg2 parallel spatialite-bin libtool \
  pkg-config g++ gcc zlib1g-dev libsqlite3-mod-spatialite libgeos-dev \
  libgeos++-dev=3.6.2-1build2 libprotobuf-dev \
  protobuf-compiler libboost-all-dev libsqlite3-dev \
  libspatialite-dev liblua5.3-dev lua5.3

# prime_server requirements
apt-get install --no-install-recommends -y \
  autoconf automake locales \
  lcov libcurl4-openssl-dev git-core libzmq3-dev libczmq-dev

locale-gen en_US.UTF-8

# set paths to fix the libspatialite error
ln -s /usr/lib/x86_64-linux-gnu/mod_spatialite.so /usr/lib/mod_spatialite

apt-get autoclean -y
rm -rf /var/lib/apt/lists/*
