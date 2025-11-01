#!/bin/bash
cd /run/media/liveuser/fedora/root/.snapshots

for i in $(seq 1 126); do
    sudo btrfs subvolume delete "$i/snapshot"
    sudo rm -rf "$i"
done
