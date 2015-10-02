#!/bin/bash
# Peter Senna Tschudin <peter.senna@gmail.com>
# The first argument should be an filename found at:
#    https://github.com/petersenna/rc.git
# All other arguments, but the first are passed to spatch

CORE_CNT=$(nproc)
COCCI_DIR=/cocci
COCCI_FILE=useme.cocci
SRC_DIR=/linuxes/$(ls /linuxes)

if [ "$#" -lt 1 ];then
	echo First argument: URL to the .cocci file for curl
	echo All other arguments will be passed to spatch
	exit 1
fi
COCCI_URL=$1

# $COCCI_DIR and $COCCI_FILE
mkdir $COCCI_DIR
cd $COCCI_DIR
curl $COCCI_URL > $COCCI_FILE
if [ $? -ne 0 ];then
	echo Error downloading the semantic patch from:
	echo $COCCI_URL
	exit 1
fi

cd $SRC_DIR
# ${@:2} mean all but the first
spatch -j $CORE_CNT $COCCI_DIR/$COCCI_FILE -dir . ${@:2}
