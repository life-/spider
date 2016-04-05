#!/bin/bash

#-----------------------------------------------------------------
#   Desc: install nodejs script
#   Date: 2014-12-01
#   Author: elmer
#-----------------------------------------------------------------

#link=${1:-"http://nodejs.org/dist/v0.10.32/node-v0.10.32.tar.gz"}
link=${1:-"http://nodejs.org/dist/v0.12.4/node-v0.12.4.tar.gz"}
file=`basename ${link##*/} .tar.gz`
target=${file%%-*}

PWD=$(cd `dirname $0`;pwd)

function install() {
    export FLOCK
    export LINK=g++
    #./configure --prefix=/usr/local/$file --gdb --dest-os=linux && make && sudo make install
    ./configure --prefix=/usr/local/$file --gdb --dest-cpu=x64 --dest-os=linux && make && sudo make install
}

which $target 2>/dev/null && (printf "$target has already been installed.\n"; exit 0)

#cd $PWD/../packages
[ ! -d $file -a ! -f $file.tar.gz ] && wget $link
[ ! -d $file ] && tar zxf $file.tar.gz
[ -d $file ] && cd  $file && install


#sudo alternatives --install /usr/local/bin/node node /usr/local/$file/bin/node 10
#sudo alternatives --install /usr/local/bin/npm npm /usr/local/$file/bin/npm 10

sed -i '/NODE_PATH/d' ~/.bashrc && echo "export NODE_PATH=/usr/local/$file/lib/node_modules/" >> ~/.bashrc
source ~/.bashrc
                                                                                                               
