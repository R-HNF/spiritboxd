FROM ubuntu:20.04

SHELL [ "/bin/bash", "-c" ]

# Docker CLI
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
        apt-transport-https \
        ca-certificates \
        software-properties-common \
        curl \
        gnupg \
        lsb-release \
    && bash -c "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -" \
    && add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) \
        stable" \
    && apt-get update && apt-get install -y \
        docker-ce-cli

RUN curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose \
    && mkdir -p /etc/bash_completion.d \
    && curl -L "https://raw.githubusercontent.com/docker/compose/$(/usr/local/bin/docker-compose version --short)/contrib/completion/bash/docker-compose" > /etc/bash_completion.d/docker-compose

# Locales
RUN apt-get install -y \
    # --no-install-recommends \
        fontconfig \
        locales \
        fonts-ipafont \
        fonts-ipaexfont \
        fonts-powerline \
    && fc-cache -f \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
	# && rm -rf /var/lib/apt/lists/* \
ENV LANG en_US.utf8

# Google Cloud SDK
RUN bash -c "echo 'deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main' | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list" \
    && bash -c "curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -" \
    && apt-get update && apt-get install -y \
        google-cloud-sdk

# AWS CLI v2
RUN apt install -y zip \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm -rf ./aws awscliv2.zip

# kubecolor
RUN apt install wget \
    && bash -c "wget -O - 'https://github.com/dty1er/kubecolor/releases/download/v0.0.20/kubecolor_0.0.20_Linux_arm64.tar.gz' | tar zxvf -" \
    && mv kubecolor /usr/local/bin \
    && rm README.md LICENSE

# Basic Apps
RUN apt-get install -y \
        bash-completion \
        sudo \
        vim \
        tmux \
        git \
        kubectl \
        keychain \
        bat \
        httpie \
        iputils-ping \
        net-tools \
        jq \
        nkf \
        htop \
        ncdu

# User
ARG USERNAME=user
ARG GROUPNAME=group
ARG PASSWORD=password
ARG UID=1000
ARG GID=1000

RUN groupadd -g $GID $GROUPNAME \
    && groupadd docker \
    && useradd -m -s /bin/bash -u $UID -g $GID -G sudo,docker $USERNAME \
    && echo $USERNAME:$PASSWORD | chpasswd \
    && echo "$USERNAME   ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

COPY ./spiritboxd/ /home/$USERNAME/spiritboxd/

RUN chown -R $USERNAME:$GROUPNAME /home/$USERNAME/ \
    && touch /home/$USERNAME/.sudo_as_admin_successful
USER $USERNAME
WORKDIR /home/$USERNAME/

ENV TERM xterm-256color

CMD ["/usr/bin/tmux"]
