#!/bin/bash
# Peter Senna Tschudin <peter.senna@gmail.com>

CORE_CNT=$(nproc)
GIT_DIR=/linux
COCCI_DIR=/cocci
COCCI_FILE=useme.cocci

if [ "$#" -lt 2 ];then
	echo First argument: URL to the .cocci file for curl
	echo Second argument: string for git checkout from these remotes:
	cd $GIT_DIR; git branch -a
	echo All other arguments will be passed to spatch
	exit 1
fi

COCCI_URL=$1
GIT_TAG=$2

# $COCCI_DIR and $COCCI_FILE
mkdir $COCCI_DIR
cd $COCCI_DIR
curl $COCCI_URL > $COCCI_FILE
if [ $? -ne 0 ];then
	echo Error downloading the semantic patch from:
	echo $COCCI_URL
	exit 1
fi

# GIT
cd $GIT_DIR
git remote update
git checkout $GIT_TAG
if [ $? -ne 0 ];then
	echo Git error for checking out: $GIT_TAG
	exit 1
fi

cd $GIT_DIR
spatch -j $CORE_CNT $COCCI_DIR/$COCCI_FILE -dir . ${@:3}
