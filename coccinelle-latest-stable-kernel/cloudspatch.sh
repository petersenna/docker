#!/bin/bash
# Peter Senna Tschudin <peter.senna@gmail.com>

COCCI_DIR=/cocci/rc
SRC_DIR=/linuxes/$(ls /linuxes)
CORE_CNT=$(nproc)

# Creates $COCCI_DIR
mkdir /cocci
cd /cocci
git clone https://github.com/petersenna/rc.git

cd $SRC_DIR

# If user specify a .cocci file as argument use it, otherwise use latest.cocci
echo $1|grep \.cocci$ &> /dev/null
if [[ $? -eq 0 ]];then
	spatch -j $CORE_CNT $COCCI_DIR/$1 -dir .
else
	spatch -j $CORE_CNT $COCCI_DIR/latest.cocci -dir .
fi
