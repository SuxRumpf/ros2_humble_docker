# Use the official Ubuntu 22.04 LTS image as a base
FROM ubuntu:22.04

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update the package list and install any necessary packages
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
	sudo \
    build-essential \
    curl \
    wget \
    git \
    nautilus \
    neovim \
    python3.10 \
    python3.10-venv \
    python3.10-dev \
    python3.10-distutils \
    libxkbcommon-x11-0 \
    qtbase5-dev \
    qtchooser \
    qt5-qmake \
    qtbase5-dev-tools  \
    && apt-get clean

# Set Python 3.10 as the default python3
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1
RUN DEBIAN_FRONTEND=noninteractive TZ=Europe/Berlin apt-get -y install tzdata

# Optionally set up a virtual environment
# RUN python3 -m venv /opt/ros2-python3.10-env

# check for UTF-8
RUN locale 
RUN sudo apt update && sudo apt install locales 
RUN sudo locale-gen en_US en_US.UTF-8 
RUN sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
RUN export LANG=en_US.UTF-8 

RUN locale  # verify settings
	
RUN sudo apt update && sudo apt install -y curl 
RUN sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

RUN sudo apt update && sudo apt upgrade
RUN sudo apt install -y ros-humble-desktop ros-dev-tools

# Set the default command to run when starting the container
CMD ["/bin/bash"]

