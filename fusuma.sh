#!/bin/bash

set -ex

sudo gpasswd -a $USER input

systemctl --user daemon-reload
systemctl --user enable --now fusuma.service
