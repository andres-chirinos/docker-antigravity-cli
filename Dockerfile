FROM ubuntu:26.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install system prerequisites (curl & ca-certificates are required)
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install with a throwaway HOME, then relocate the binary out of the mount path
RUN HOME=/tmp/build sh -c 'curl -fsSL https://antigravity.google/cli/install.sh | bash' \
    && cp -a /tmp/build/.local/bin/. /usr/local/bin/ \
    && rm -rf /tmp/build

ENV WORKSPACE="/workspace"
ENV HOME="$WORKSPACE/.gemini-cfg"
WORKDIR $WORKSPACE
RUN mkdir -p $HOME

CMD [ "agy" ]
