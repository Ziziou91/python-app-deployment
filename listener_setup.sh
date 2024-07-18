#!/bin/bash


# Update
echo =======UPDATING=======
sudo apt update -y && sudo apt upgrade -y

# Install pip
echo =======INSTALLING PIP=======
sudo apt install python3-pip -y

# Install flask
echo =======INSTALLING FLASK=======
pip install Flask --break-system-packages

# clone app from github
echo cloning app from github
git clone https://github.com/Ziziou91/python-app-deployment.git

cd python-app-deployment

python3 main.py