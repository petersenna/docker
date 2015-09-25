#!/bin/bash
# This script expects a version as argument. Currently the version is something
# like 1.0.2
#
# Peter Senna Tschudin <peter.senna@gmail.com>

if [[ "$#" -lt 1 ]];then
	echo You should give me the last version of Coccinelle you have.
	echo Try none if you have none
	exit 1
fi
USER_VER=$1

# Clone Fedora's repository for Coccinelle package for getting the .spec file
echo Clonning http://pkgs.fedoraproject.org/git/coccinelle.git
cd /tmp
git clone http://pkgs.fedoraproject.org/git/coccinelle.git
RET=$?
if [[ $RET -ne 0 ]];then
	echo git clone failed with error $RET
	exit $RET
fi

# What is the coccinelle version inside the .spec file?
VER=$(cat /tmp/coccinelle/coccinelle.spec|grep Version:|head -n 1|tr -s " "|cut -d " " -f 2)
echo If we continue Coccinelle $VER will be compiled

if [[ "$VER" == "$1" ]];then
	echo Continuing would compile the same version. Aborting...
	exit 0
fi

# Remove /root/rpmbuild before continuing
rm -rf /root/rpmbuild
rpmdev-setuptree
cp /tmp/coccinelle/coccinelle.spec /root/rpmbuild/SPECS

# Remove the git repository. It is not needed anymore
rm -rf /tmp/coccinelle

# Download the correct version of the source code of Coccinelle
echo Downloading http://coccinelle.lip6.fr/distrib/coccinelle-$VER.tgz
cd /root/rpmbuild/SOURCES
curl http://coccinelle.lip6.fr/distrib/coccinelle-$VER.tgz > coccinelle-$VER.tgz
RET=$?
if [[ $RET -ne 0 ]];then
	echo curl failed with error $RET
	exit $RET
fi

# Build the binary RPMS
echo Calling rpmbuild
cd /root/rpmbuild/SPECS
rpmbuild --quiet -bb coccinelle.spec
RET=$?
if [[ $RET -ne 0 ]];then
	echo rpmbuild failed with error $RET
	exit $RET
fi

# show some results to the user
echo "/root/rpmbuild/RPMS/x86_64/"
ls /root/rpmbuild/RPMS/x86_64/
