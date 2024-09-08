#!/bin/bash

# Invoca os scripts de instalação
source pre-config.sh
source packages.sh
source post-config.sh

# Reboota o sistema
reboot