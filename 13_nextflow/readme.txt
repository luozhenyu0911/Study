1.1 部署java环境

wget -c https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.tar.gz
tar zxf jdk-17_linux-x64_bin.tar.gz
export JAVA_HOME=/data/nextflow/jdk-17.0.7
export PATH=$PATH:$JAVA_HOME/bin
java -version

1.2 安装nextflow

wget -qO- https://get.nextflow.io | bash
export PATH="$PATH:/PATH/nextflow"

1.3 run
nextflow run tutorial.nf 
