#!/bin/bash
set -eux
export DEBIAN_FRONTEND=noninteractive

# 1. Update OS
apt-get update -y

# 2. Install base tools
apt-get install -y \
  openjdk-17-jdk \
  git \
  curl \
  unzip \
  ca-certificates \
  apt-transport-https \
  software-properties-common

# 3. Install Maven
apt-get install -y maven

# 4. Install Docker
curl -fsSL https://get.docker.com | sh
systemctl enable docker
systemctl start docker

# 5. Allow ubuntu user to run docker
usermod -aG docker ubuntu

# 6. Pull SonarQube
docker pull sonarqube:latest

# 7. Pull JFrog Artifactory OSS
docker pull releases-docker.jfrog.io/jfrog/artifactory-oss:latest

# 8. Create Docker volumes
docker volume create sonarqube_data
docker volume create artifactory_data

echo "CI/CD node ready. Configure Jenkins / pipelines manually."
