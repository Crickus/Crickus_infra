#!/bin/bash
set -e

# Install Puma 
cd /home/appuser
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install


