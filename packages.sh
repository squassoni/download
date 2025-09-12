#!/bin/bash
set -e

TOOLS_DIR=$HOME/tools
BIN_DIR=$TOOLS_DIR/bin
mkdir -p $BIN_DIR

echo "==== Preparando pip para Python 3.9 ===="
curl -sS https://bootstrap.pypa.io/pip/3.9/get-pip.py -o get-pip.py
python3 get-pip.py --user || true
rm get-pip.py
export PATH=$HOME/.local/bin:$PATH
echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc

echo "==== Instalando Python 3.10.12 localmente ===="
cd $HOME
curl -O https://www.python.org/ftp/python/3.10.12/Python-3.10.12.tgz
tar -xzf Python-3.10.12.tgz
cd Python-3.10.12
./configure --prefix=$TOOLS_DIR/python310 --enable-optimizations
make -j$(nproc)
make install
cd ..
rm -rf Python-3.10.12 Python-3.10.12.tgz

echo 'export PATH=$HOME/tools/python310/bin:$PATH' >> ~/.bashrc
export PATH=$HOME/tools/python310/bin:$PATH

echo "==== Instalando pip no Python 3.10 ===="
python3.10 -m ensurepip --upgrade
python3.10 -m pip install --upgrade pip

echo "==== Instalando dos2unix ===="
curl -L https://waterlan.home.xs4all.nl/dos2unix/dos2unix-7.4.2.tar.gz -o dos2unix.tar.gz
tar -xzf dos2unix.tar.gz
cd dos2unix-7.4.2
make
cp dos2unix $BIN_DIR/
cd ..
rm -rf dos2unix-7.4.2 dos2unix.tar.gz

echo "==== Instalando zip ===="
curl -L https://downloads.sourceforge.net/infozip/zip30.tar.gz -o zip.tar.gz
tar -xzf zip.tar.gz
cd zip30
make -f unix/Makefile generic_gcc
cp zip $BIN_DIR/
cd ..
rm -rf zip30 zip.tar.gz

echo "==== Instalando jq ===="
curl -L https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 -o $BIN_DIR/jq
chmod +x $BIN_DIR/jq

echo "==== Instalando mc (MinIO Client) ===="
curl -L https://dl.min.io/client/mc/release/linux-amd64/mc -o $BIN_DIR/mc
chmod +x $BIN_DIR/mc

echo "==== Instalando Cloud Foundry CLI (cf) ===="
curl -L https://packages.cloudfoundry.org/stable?release=linux64-binary&source=github -o cf-cli.tgz
tar -xzf cf-cli.tgz
mv cf8 cf $BIN_DIR/
rm -rf cf-cli.tgz

echo "==== Instalando Node.js 18.14.0 + npm ===="
curl -L https://nodejs.org/dist/v18.14.0/node-v18.14.0-linux-x64.tar.gz -o node.tar.gz
tar -xzf node.tar.gz -C $TOOLS_DIR
echo "export PATH=\$PATH:$TOOLS_DIR/node-v18.14.0-linux-x64/bin" >> ~/.bashrc
rm node.tar.gz

echo "==== Instalando Java 17 (17.0.6) ===="
curl -L https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.tar.gz -o java.tar.gz
mkdir -p $TOOLS_DIR/java-17
tar -xzf java.tar.gz -C $TOOLS_DIR/java-17 --strip-components=1
echo "export JAVA_HOME=$TOOLS_DIR/java-17" >> ~/.bashrc
echo "export PATH=\$PATH:\$JAVA_HOME/bin" >> ~/.bashrc
rm java.tar.gz

echo "==== Instalando Ansible (via pip no Python 3.10) ===="
python3.10 -m pip install --user ansible-core==2.17.0

echo "==== Instalando kubectl v1.32.1 ===="
curl -LO "https://dl.k8s.io/release/v1.32.1/bin/linux/amd64/kubectl"
chmod +x kubectl
mv kubectl $BIN_DIR/

echo "==== Instalando yq ===="
curl -L https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -o $BIN_DIR/yq
chmod +x $BIN_DIR/yq

echo "==== Finalizado! ===="
echo "Reinicie a sessão ou rode: source ~/.bashrc"
