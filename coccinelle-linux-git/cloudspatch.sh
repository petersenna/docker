#!/bin/bash
# Peter Senna Tschudin <peter.senna@gmail.com>

if [ "$#" -lt 2 ];then
	clear
	echo First argument: URL to the .cocci file
	echo Second argument: string to git checkout from linux, linux-next, and staging
	echo All other arguments will be passed to spatch
	exit 1
fi

CORE_CNT=$(nproc)
GIT_DIR=/linux
COCCI_DIR=/cocci
COCCI_FILE=useme.cocci

COCCI_URL=$1
GIT_TAG=$2

# Creates $COCCI_DIR
mkdir $COCCI_DIR
cd $COCCI_DIR
curl $COCCI_URL > $COCCI_FILE
if [ $? -ne 0 ];then
	echo I could not download the semantic patch with curl.
	echo Are you sure you gave me a valid URL?
	exit 1
fi

cd $GIT_DIR
git remote update
git checkout $GIT_TAG
if [ $? -ne 0 ];then
	echo Git did not like your string for checking out...
	exit 1
fi

cd $GIT_DIR
spatch -j $CORE_CNT $COCCI_DIR/$COCCI_FILE -dir . ${@:3}

