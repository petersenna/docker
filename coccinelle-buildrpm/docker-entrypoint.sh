#!/bin/bash

rpmdev-setuptree

# Clone Fedora's repository for Coccinelle package for getting the .spec file
cd /tmp
git clone http://pkgs.fedoraproject.org/git/coccinelle.git
cp /tmp/coccinelle/coccinelle.spec /root/rpmbuild/SPECS
rm -rf /tmp/coccinelle

# What is the coccinelle version inside the .spec file?
VER=$(cat /root/rpmbuild/SPECS/coccinelle.spec|grep Version:|head -n 1|tr -s " "|cut -d " " -f 2)

# Download the correct version of the source code of Coccinelle
cd /root/rpmbuild/SOURCES
curl http://coccinelle.lip6.fr/distrib/coccinelle-$VER.tgz > coccinelle-$VER.tgz

# Build the binary RPMS
cd /root/rpmbuild/SPECS
rpmbuild -bb coccinelle.spec

# show some results to the user
echo "/root/rpmbuild/RPMS/x86_64/"
ls /root/rpmbuild/RPMS/x86_64/
