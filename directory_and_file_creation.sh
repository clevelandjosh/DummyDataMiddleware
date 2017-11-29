#!/bin/bash

cd /tmp
mkdir /tmp/alice
chown alice:alice /tmp/alice
cd /tmp/alice
mkdir  not_ww_dir_without_sticky  not_ww_dir_with_sticky  ww_dir_without_sticky  ww_dir_with_sticky
  for i in $(ls -d */)
   do
    touch $i/not_ww_file_without_sticky
    touch $i/not_ww_file_with_sticky
    touch $i/ww_file_without_sticky
    touch $i/ww_file_with_sticky
chown -R alice:alice /tmp/alice/*dir_with*
  done
chmod 755 /tmp/alice/not_ww_dir_with*
chmod 777 /tmp/alice/ww_dir_with*
chmod +t /tmp/alice/*dir_with_sticky
chmod 777 /tmp/alice/*/ww_file_with*
chmod 755 /tmp/alice/*/not_ww_file_with*
chmod +t /tmp/alice/*/*file_with_sticky

cd /tmp
mkdir /tmp/root
cd /tmp/root
mkdir  not_ww_dir_without_sticky  not_ww_dir_with_sticky  ww_dir_without_sticky  ww_dir_with_sticky
  for i in $(ls -d */)
   do
    touch $i/not_ww_file_without_sticky
    touch $i/not_ww_file_with_sticky
    touch $i/ww_file_without_sticky
    touch $i/ww_file_with_sticky
  done
chmod 755 /tmp/root/not_ww_dir_with*
chmod 777 /tmp/root/ww_dir_with*
chmod +t /tmp/root/*dir_with_sticky
chmod 777 /tmp/root/*/ww_file_with*
chmod 755 /tmp/root/*/not_ww_file_with*
chmod +t /tmp/root/*/*file_with_sticky
