ARG VERSION="2.320.0"

FROM ghcr.io/actions/actions-runner:${VERSION}

# Tools that are useful during Github action runs
ARG TOOLS="bzip2 unzip git coreutils psmisc jq curl xz-utils"
ENV WORKDIR="/home/runner"
ARG USER="runner"

USER root

RUN apt-get update && \
	apt-get install -y ${TOOLS} && \
	rm -rf /var/cache/apt/archives /var/lib/apt/lists/*

ADD entrypoint.sh /home/runner/
RUN chmod +x /home/runner/entrypoint.sh

USER ${USER}
ENV USER=${USER}
WORKDIR ${WORKDIR}

ENTRYPOINT [ "/home/runner/entrypoint.sh" ]
