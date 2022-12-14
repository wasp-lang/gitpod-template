FROM ubuntu:jammy

ENV WASP_TELEMETRY_CONTEXT=gitpod
RUN apt-get update && apt-get install -yq \
    git \
    git-lfs \
    sudo \
    curl

# Create the gitpod user. UID must be 33333.
RUN useradd -l -u 33333 -G sudo -md /home/gitpod -s /bin/bash -p gitpod gitpod

USER gitpod
ENV NODE_VERSION=18.12.0
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
ENV NVM_DIR=/home/gitpod/.nvm
RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}
ENV PATH="/home/gitpod/.nvm/versions/node/v${NODE_VERSION}/bin:${PATH}"

USER gitpod
RUN printf 'export PATH="%s:$PATH"\n' "$HOME/.local/bin" >> $HOME/.bashrc && exit

RUN mkdir -p $HOME/.bashrc.d/ && curl -sSL https://get.wasp-lang.dev/installer.sh | sh 
RUN printf 'export WASP_TELEMETRY_USER_ID="%s"\n' "$GITPOD_WORKSPACE_ID" >> $HOME/.bashrc && exit
