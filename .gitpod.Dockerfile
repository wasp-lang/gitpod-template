FROM ubuntu:jammy

RUN apt-get update && apt-get install -yq \
    git \
    git-lfs \
    sudo \
    curl

# Gitpod expects us to have gitpod user with UID 333333, so let's create one.
RUN useradd -l -u 33333 -G sudo -md /home/gitpod -s /bin/bash -p gitpod gitpod

# Set up node (specifically version that Wasp requires).
USER gitpod
ENV NODE_VERSION=18.12.0
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
ENV NVM_DIR=/home/gitpod/.nvm
RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION} \
		&& nvm use v${NODE_VERSION} \
		&& nvm alias default v${NODE_VERSION}	
ENV PATH="/home/gitpod/.nvm/versions/node/v${NODE_VERSION}/bin:${PATH}"

# RUN curl -sSL https://get.wasp-lang.dev/installer.sh | sh -s
# Wasp gets installed in $HOME/.local/bin, so we need to add it to PATH.
ENV PATH="/home/gitpod/.local/bin:${PATH}"
# Ensure Wasp's telemetry recognizes Wasp is running on Gitpod.
ENV WASP_TELEMETRY_CONTEXT=gitpod
ENV WASP_TELEMETRY_DISABLE=1

# GITPOD_WORKSPACE_ID is not available in the context of docker, so we don't try to expand it here.
RUN printf 'export WASP_TELEMETRY_USER_ID="${GITPOD_WORKSPACE_ID}"' >> $HOME/.bashrc
