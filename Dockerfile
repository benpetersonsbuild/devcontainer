FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive
RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes

# hadolint ignore=DL3008
RUN apt-get update \
&& apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        jq \
        git \
        iputils-ping \
        libcurl4 \
        libicu60 \
        libunwind8 \
        netcat \
        libssl1.0 \
        python3 \
        python3-pip \
        unzip \
        ssh && \
apt-get clean && \
rm -rf /var/lib/apt/lists/*

#awscli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
unzip awscliv2.zip && \ 
./aws/install

RUN useradd -ms /bin/bash dev

USER dev

WORKDIR /home/dev

# install tfenv
# hadolint ignore=SC1091
RUN git clone https://github.com/tfutils/tfenv.git /home/dev/.tfenv && \
mkdir -p /home/dev/.local/bin/ && \
. /home/dev/.profile && \
ln -s /home/dev/.tfenv/bin/* /home/dev/.local/bin && \
tfenv install latest && \
tfenv use latest

COPY ./.bashrc /home/dev/.bashrc

COPY run_tests.sh /home/dev/run_tests.sh

ENTRYPOINT [ "/bin/bash" ]