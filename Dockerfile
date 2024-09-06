FROM ubuntu:24.04

# Instale as dependências necessárias
RUN apt-get update && \
    apt-get install -y \
    cmake \
    ninja-build \
    g++ \
    libnng-dev \
    libssl-dev \
    libnsl-dev \
    build-essential \
    libc6-dev \
    libc-dev \
    libpthread-stubs0-dev \
    git \
    && apt-get clean

# Clone e instale o Microsoft msquic (descomentado se necessário)
RUN git clone https://github.com/microsoft/msquic.git && \
    cd msquic && \
    git submodule update --init --recursive && \
    mkdir build && cd build && \
    cmake .. && \
    make && \
    make install

# Clone e instale o nanomsg NNG (descomentado se necessário)
RUN git clone https://github.com/nanomsg/nng.git && \
    cd nng && \
    mkdir build && cd build && \
    cmake .. && \
    make && \
    make install

# Copie o código fonte para o container
COPY . /NanoSDK

# Defina o diretório de trabalho
# WORKDIR /NanoSDK/demo/quic_mqtt/build
WORKDIR /NanoSDK/demo/quic_mqtt/build

# Comando padrão para rodar o cliente
CMD ["./quic_client"]