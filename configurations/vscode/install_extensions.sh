#!/bin/bash

RESTORE='\033[0m'
RED='\033[00;31m'
GREEN='\033[00;32m'
YELLOW='\033[00;33m'

echo -e "${GREEN}Installing VS Code extensions${RESTORE}"

while IFS= read -r extension; do
    sudo -u $USER code --install-extension $extension
done < extensions.txt