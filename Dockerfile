#!/usr/bin/env docker

# This is a template for a Dockerfile to build a docker image for your ROS package. 
# The main purpose of this file is to install dependencies for your package.

FROM ros:noetic-ros-base-focal        

ENV ROS_ROOT=/opt/ros/noetic        

# Set upp workspace
RUN mkdir -p /ws/src   

# Set noninteractive installation
ENV DEBIAN_FRONTEND=noninteractive

# Package apt dependencies
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y \
        nano \
        git \
        python3-catkin-tools \
        usbutils \
        wget \
        ros-noetic-camera-info-manager \
        ros-noetic-diagnostic-updater \
        ros-noetic-image-geometry \
        ros-noetic-roslint \
        ros-noetic-cv-bridge \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Download and install Basler Pylon SDK
RUN if [ "$(uname -m)" = "x86_64"]; then \
        wget https://www.baslerweb.com/fp-1636375002/media/downloads/software/pylon_software/pylon_6.3.0.23157-deb0_amd64.deb \
        && dpkg -i pylon_6.3.0.23157-deb0_amd64.deb \
        && rm -rf *tar.gz *.deb; \
    else \
        wget https://www.baslerweb.com/fp-1615275631/media/downloads/software/pylon_software/pylon_6.2.0.21487-deb0_arm64.deb \
        && dpkg -i pylon_6.2.0.21487-deb0_arm64.deb \
        && rm -rf *tar.gz *.deb; \
    fi

# Optional: Install additional dependencies with script
#COPY scripts/install.sh scripts/
#RUN chmod +x scripts/install.sh && bash .scripts/install.sh

WORKDIR /ws
