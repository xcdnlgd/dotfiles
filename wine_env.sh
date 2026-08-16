#!/bin/bash

set -ex

winetricks --force -q \
    dxvk \
    vkd3d \
    vcrun2005 \
    vcrun2008 \
    vcrun2010 \
    vcrun2012 \
    vcrun2013 \
    vcrun2022 \
    dotnet48 \
    dotnet6 \
    dotnet7 \
    dotnet8 \
    dotnet9 \
    dotnetdesktop6 \
    dotnetdesktop7 \
    dotnetdesktop8 \
    dotnetdesktop9 \
    win10
