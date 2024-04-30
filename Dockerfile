FROM ubuntu:20.04

ARG RUNNER_VERSION="2.316.0"

ENV DEBIAN_FRONTEND noninteractive

RUN apt update && apt upgrade -y

RUN apt-get install -y --no-install-recommends \
    gconf-service libasound2 libatk1.0-0 libc6 \
    libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 \
    libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 \
    libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 \
    libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 \
    libxi6 libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates \
    fonts-liberation libnss3 lsb-release xdg-utils wget libgbm-dev \
    sudo curl jq npm \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

RUN adduser --disabled-password --gecos '' docker && \
    adduser docker sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN mkdir -p /home/docker/actions-runner && \
    curl -O -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && \
    tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz -C /home/docker/actions-runner && \
    rm ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

RUN chown -R docker:docker /home/docker && \
    /home/docker/actions-runner/bin/installdependencies.sh

COPY start.sh /home/docker/start.sh

RUN chmod +x /home/docker/start.sh

USER docker

ENTRYPOINT ["/home/docker/start.sh"]
