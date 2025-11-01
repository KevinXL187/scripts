#!/bin/sh

SRC_DIR="/home/xinghai/Downloads/"
DEST_DIR="/mnt/shared/Downloads/"

rsync -avz --progress $SRC_DIR $DEST_DIR && rm -r $SRC_DIR/*

# Notification
kdialog --msgbox "File transfer between Downloads folder completed!"
