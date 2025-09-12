#!/usr/bin/env bash
set -e

echo "🚀 Criando pastas de ferramentas..."
mkdir -p ~/tools/{nodejs,java,bin}

# -----------------------------
# Python + pip
# -----------------------------
echo "🐍 Verificando Python 3..."
if ! command -v python3 &>/dev/null; then
    echo "⚠️ Python3 não encontrado. Instale manualmente o binário."
else
    echo "✅ Python3 encontrado."
fi

echo "📥 Instalando pip via get-pip.py..."
curl -O https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py --user
export PATH=$HOME/.local/bin:$PATH
grep -qxF 'export PATH=$HOME/.local/bin:$PATH' ~/.bashrc || echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc

echo "📦 Instalando Ansible Core 2.17.0..."
python3 -m pip install --user ansible-core==2.17.0

# -----------------------------
# jq
# -----------------------------
echo "📥 Instalando jq 1.6..."
curl -L -o ~/tools/bin/jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
chmod +x ~/tools/bin/jq

# -----------------------------
# dos2unix
# -----------------------------
echo "📥 Instalando dos2unix 7.4.2..."
curl -L -o ~/tools/bin/dos2unix https://github.com/dos2unix/dos2unix/releases/download/v7.4.2/dos2unix-7.4.2-linux-x86_64
chmod +x ~/tools/bin/dos2unix

# -----------------------------
# zip
# -----------------------------
echo "📥 Instalando zip 3.0..."
curl -L -o ~/tools/bin/zip https://downloads.sourceforge.net/infozip/zip30.tar.gz
tar -xzvf ~/tools/bin/zip -C ~/tools/bin || true
chmod +x ~/tools/bin/zip

# -----------------------------
# MinIO client
# -----------------------------
echo "📥 Instalando MinIO client (mc)..."
curl -k -o ~/tools/bin/mc https://artifactory.prz.ics.eu-west-1.aws.gts/artifactory/gdp_nextgen_devops_ics/MINIO/mc
chmod +x ~/tools/bin/mc

# -----------------------------
# Cloud Foundry CLI
# -----------------------------
echo "☁️ Instalando Cloud Foundry CLI (cf 8.0.0)..."
curl -L https://artifactory.prz.ics.eu-west-1.aws.gts/artifactory/gdp_nextgen_devops_ics/cloudfoundry/cf8-cli_8.0.0_linux_x86-64.tgz | tar -zx -C ~/tools/bin

# -----------------------------
# Node.js + npm
# -----------------------------
echo "🟢 Instalando Node.js 18.14.0 + npm 9.3.1..."
curl -L https://artifactory.prz.ics.eu-west-1.aws.gts/artifactory/gdp_nextgen_devops_ics/node-v18.14.0-linux-x64.tar.gz | tar -zx -C ~/tools/nodejs

# -----------------------------
# Java 17
# -----------------------------
echo "☕ Instalando Java 17 (jdk-17.0.6)..."
curl -k -L https://artifactory.prz.ics.eu-west-1.aws.gts/artifactory/gdp_nextgen_devops_ics/bin/jdk-17.0.6_linux-x64_bin.tar.gz | tar -zx -C ~/tools/java

# -----------------------------
# kubectl
# -----------------------------
echo "📦 Instalando kubectl v1.32.1..."
curl -LO "https://dl.k8s.io/release/v1.32.1/bin/linux/amd64/kubectl"
chmod +x kubectl
mv kubectl ~/tools/bin/

# -----------------------------
# yq
# -----------------------------
echo "📦 Instalando yq..."
curl -L https://github.com/mikefarah/yq/releases/download/v4.45.1/yq_linux_amd64 -o ~/tools/bin/yq
chmod +x ~/tools/bin/yq

# -----------------------------
# Configuração PATH
# -----------------------------
echo "⚙️ Configurando PATH e variáveis de ambiente no ~/.bashrc..."
grep -qxF 'export PATH=$HOME/tools/bin:$PATH' ~/.bashrc || echo 'export PATH=$HOME/tools/bin:$PATH' >> ~/.bashrc
grep -qxF 'export PATH=$HOME/tools/nodejs/node-v18.14.0-linux-x64/bin:$PATH' ~/.bashrc || echo 'export PATH=$HOME/tools/nodejs/node-v18.14.0-linux-x64/bin:$PATH' >> ~/.bashrc
grep -qxF 'export JAVA_HOME=$HOME/tools/java/jdk-17.0.6' ~/.bashrc || echo 'export JAVA_HOME=$HOME/tools/java/jdk-17.0.6' >> ~/.bashrc
grep -qxF 'export PATH=$JAVA_HOME/bin:$PATH' ~/.bashrc || echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.bashrc

echo "✅ Instalação concluída. Abra um novo terminal ou execute 'source ~/.bashrc' para atualizar o PATH."
