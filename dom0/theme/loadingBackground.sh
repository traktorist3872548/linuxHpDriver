#!/bin/bash
update-alternatives --config default.plymouth
update-initramfs -u -k all
rm /usr/share/plymouth/themes/mint-logo/logo.png
cp ./logo.png /usr/share/plymouth/themes/mint-logo/ 

