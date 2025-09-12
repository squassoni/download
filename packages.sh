#!/bin/bash

set -e

echo "🔧 Iniciando instalação de ferramentas..."

# Diretórios de destino
mkdir -p ~/tools/nodejs
mkdir -p ~/tools/java-17

# 1. Instalar mc
echo "📦 Instalando mc..."
curl -k -o mc https://artifactory.prz.ics.eu-west-1.aws.gts/artifactory/gdp_nextgen_devops_ics/MINIO/mc
chmod 755 mc
sudo mv mc /usr/local/bin/

# 2. Instalar cf CLI
echo "📦 Instalando cf CLI..."
curl -L https://artifactory.prz.ics.eu-west-1.aws.gts/artifactory/gdp_nextgen_devops_ics/cloudfoundry/cf8-cli_8.0.0_linux_x86-64.tgz | tar -zx
sudo mv cf8 /usr/local/bin/
sudo mv cf /usr/local/bin/

# 3. Instalar Node.js e npm
echo "📦 Instalando Node.js..."
curl -L https://artifactory.prz.ics.eu-west-1.aws.gts/artifactory/gdp_nextgen_devops_ics/node-v18.14.0-linux-x64.tar.gz | tar -zx -C ~/tools/nodejs
echo 'export PATH=$PATH:~/tools/nodejs/node-v18.14.0-linux-x64/bin' >> ~/.bashrc

# 4. Instalar Java 17
echo "📦 Instalando Java 17..."
curl -k -L https://artifactory.prz.ics.eu-west-1.aws.gts/artifactory/gdp_nextgen_devops_ics/bin/jdk-17.0.6_linux-x64_bin.tar.gz | tar -zx -C ~/tools/java-17
echo 'export JAVA_HOME=~/tools/java-17/jdk-17.0.6' >> ~/.bashrc
echo 'export PATH=$PATH:$JAVA_HOME/bin' >> ~/.bashrc

# 5. Instalar kubectl
echo "📦 Instalando kubectl..."
curl -LO "https://dl.k8s.io/release/v1.32.1/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

# 6. Instalar yq
echo "📦 Instalando yq..."
curl -L https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -o yq
chmod +x yq
sudo mv yq /usr/local/bin/

echo "✅ Instalação concluída. Execute 'source ~/.bashrc' para aplicar as variáveis de ambiente."
