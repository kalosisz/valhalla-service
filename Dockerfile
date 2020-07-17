FROM ubuntu:18.04

# Set docker specific settings
ENV TERM xterm

ARG DEBIAN_FRONTEND="noninteractive"

WORKDIR /valhalla/
ENV SCRIPTS_DIR "/valhalla/scripts"

# Copy all necessary build scripts
COPY scripts/ ${SCRIPTS_DIR}

# Install deps
RUN /bin/bash ${SCRIPTS_DIR}/install_shared_deps.sh

# Set language
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Build Primeserver
ARG PRIMESERVER_RELEASE=0.6.6
RUN /bin/bash ${SCRIPTS_DIR}/build_prime_server.sh

# Build Valhalla
ARG VALHALLA_RELEASE=3.0.9
RUN /bin/bash ${SCRIPTS_DIR}/build_valhalla.sh

# # Set default number of threads and expose the necessary port
ENV N_THREADS 1
EXPOSE 8002
CMD ["/bin/bash", "-c", "${SCRIPTS_DIR}/entrypoint.sh"]
