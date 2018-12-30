#安装编译环境依赖包
yum install -y gcc gcc-c++ autoconf make automake wget

#安装Git编译过程需要的依赖关系库
yum install -y perl curl-devel expat-devel gettext-devel openssl-devel zlib-devel
yum install -y cpio texinfo sgml2xml openjade perl-ExtUtils-MakeMaker

#支持更多文档格式（如 doc, html, info）
yum install -y asciidoc xmlto docbook2x

#解决执行make all doc info时报:/bin/sh: line 1: docbook2x-texi: command not found
ln -s /usr/bin/db2x_docbook2texi /usr/bin/docbook2x-texi

#下载git源码包，以git-2.20.1为例
wget https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.20.1.tar.gz

#编译安装git
tar -zxvf git-2.20.1.tar.gz
cd git-2.20.1 && make configure && ./configure --prefix=/usr/local/git
make all doc info
make install install-doc install-html install-info

#配置系统环境
cat >> /etc/profile << EOF
export GIT_HOME=/usr/local/git
export PATH=${GIT_HOME}/bin:${PATH}
EOF
source /etc/profile

#配置git命令补全
wget -P /home https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
echo 'source "/home/git-completion.bash"' >> $HOME/.bashrc
source $HOME/.bashrc

#查看git版本
git –version
