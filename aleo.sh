#!/bin/bash
Workspace=/root/aleo-prover
SnarkOSDir=/root/aleo

# 安装依赖以及snarkos
install_snarkos(){
	mkdir ${SnarkOSDir}
	cd ${SnarkOSDir}	

	echo "开始安装rust"
	sudo curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh  -s -- -y
	source $HOME/.cargo/env
	echo "rust安装成功!"

        echo "打开防火墙4133、4140和3033端口"
        sudo ufw allow 4133
        sudo ufw allow 3033
        sudo ufw allow 4140
        echo "防火墙设置完毕"

	echo "开始下载aleo代码"
	git clone https://github.com/AleoHQ/snarkOS.git --depth 1 ${SnarkOSDir} 
	if [ -f ${SnarkOSDir}/build_ubuntu.sh ]
        then
               	echo "aleo代码下载完成!" 
        else
                echo "aleo代码下载失败，请确认服务器已安装好git后重新再试。可尝试手动执行 apt install git" && exit 1
        fi

	echo "开始安装依赖项"
	bash ${SnarkOSDir}/build_ubuntu.sh
	echo "依赖项安装完成！"

	echo "开始编译snarkos"
	cargo install --path ${SnarkOSDir}

	# cpu优化代码
	mkdir ${Workspace}
	cd ${Workspace}
        echo "下载并编译HarukaMa/aleo-prover优化后代码"
        git clone https://github.com/HarukaMa/aleo-prover.git --depth 1 ${Workspace}
	cargo build --release
        #cargo install --path ${Workspace}
        echo "cpu prover编译完成！"
}

read -e -p " 请输入数字 [1-6]:" num
case "$num" in
1)
	install_snarkos
    	;;
*)
    echo
    echo -e "请输入正确的数字!"
    ;;
esac