# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.166.1/containers/go/.devcontainer/base.Dockerfile

# [Choice] Go version: 1, 1.16, 1.15
ARG VARIANT="1"
FROM mcr.microsoft.com/vscode/devcontainers/go:0-${VARIANT}

# [Option] Install Node.js
ARG INSTALL_NODE="true"
ARG NODE_VERSION="lts/*"
RUN if [ "${INSTALL_NODE}" = "true" ]; then su vscode -c "umask 0002 && . /usr/local/share/nvm/nvm.sh && nvm install ${NODE_VERSION} 2>&1"; fi

# [Optional] Uncomment this section to install additional OS packages.
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends <your-package-list-here>



# Note: Latest version of kubectl may be found at:
# https://github.com/kubernetes/kubernetes/releases
ENV KUBE_LATEST_VERSION="v1.20.2"



#### PACKAGES# configure apt and install packages
RUN  apk add --no-cache  curl dialog ca-certificates 2>&1 \
  # verify process tools, lsb-release installed (common in install instructions for CLIs)
  && apk add --no-cache iproute2 procps  make   gnupg  \
  # tools
  && apk add --no-cache sudo unzip wget vim  git bash bash-completion sudo build-base \
  # install kubectl
  && wget -q https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
  && chmod +x /usr/local/bin/kubectl  \
  # install goß
  && wget https://dl.google.com/go/go1.16.3.linux-amd64.tar.gz  \
  && rm -rf /usr/local/go && tar -C /usr/local -xzf go1.16.3.linux-amd64.tar.gz     \
  # install operator-sdk
  && export ARCH=$(case $(uname -m) in x86_64) echo -n amd64 ;; aarch64) echo -n arm64 ;; *) echo -n $(uname -m) ;; esac)  \
  && export OS=$(uname | awk '{print tolower($0)}')                                                                     \
  && export OPERATOR_SDK_DL_URL=https://github.com/operator-framework/operator-sdk/releases/download/v1.6.2  \
  && curl -LO ${OPERATOR_SDK_DL_URL}/operator-sdk_${OS}_${ARCH}  \
  && chmod +x operator-sdk_${OS}_${ARCH} && mv operator-sdk_${OS}_${ARCH} /usr/local/bin/operator-sdk


# [Optional] Uncomment the next line to use go get to install anything else you need
# RUN go get -x <your-dependency-or-tool>

# [Optional] Uncomment this line to install global node packages.
# RUN su vscode -c "source /usr/local/share/nvm/nvm.sh && npm install -g <your-package-here>" 2>&1