FROM ubuntu:26.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# 1. Install system prerequisites (curl & ca-certificates are required)
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    git \
    && rm -rf /var/lib/apt/lists/*

ENV WORKSPACE="/workspace"
ENV HOME="$WORKSPACE/.gemini-cfg"
WORKDIR $WORKSPACE
ENV PATH="/root/.local/bin:${PATH}"
RUN curl -fsSL https://antigravity.google/cli/install.sh | bash

CMD [ "agy" ]
