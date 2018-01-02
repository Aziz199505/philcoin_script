#!/bin/bash


#Setting the up the variables
fstab=/etc/fstab




coinCommand="philscurrencyd"
github="https://github.com/philscurrency/philscurrency"
coinName="philscurrency"
fileConf="philscurrency.conf"

#Conf File
confPath=~/.$coinName/$fileConf
read -p "Enter rpc user at can be any random word: "  rpcuser
read -p "Enter rpc password at can be any random word: "  rpcpassword
rpcport="36002"
mnport="36003"
read -p "Paste masternode privet key: "  masternodeprivkey
read -p "Enter your server ip: "  masternodeaddr

apt-get update -y
DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade
apt-get install -y libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev libboost-all-dev unzip libminiupnpc-dev python-virtualenv

sudo apt-get install -y build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils


apt-get install -y software-properties-common && add-apt-repository -y ppa:bitcoin/bitcoin
apt-get update -y
apt-get install -y libdb4.8-dev libdb4.8++-dev
apt-get install -y git

if [ "$coinCommand" = "philscurrencyd" ]
then
	wget  https://github.com/philscurrency/philscurrency/releases/download/v1.2/philscurrency-1.0.0-linux64.tar.gz
	tar -zxvf philscurrency-1.0.0-linux64.tar.gz
	strip $coinCommand
	cp $coinCommand /usr/bin/
	cp philscurrency-cli /usr/bin/
	$coinCommand &
	sleep 5	
	philscurrency-cli stop
	sleep 5
	
	
	#To be continue on configuration
	rm -rf $confPath
	echo "rpcuser=$rpcuser" > $confPath
	echo "rpcpassword=$rpcpassword" >> $confPath
	echo "rpcallowip=127.0.0.1" >> $confPath
	echo "server=1" >> $confPath
	echo "listen=1" >> $confPath
	echo "daemon=1" >> $confPath
	echo "port=$mnport" >> $confPath
	echo "externalip=$masternodeaddr" >> $confPath
	echo "masternode=1" >> $confPath
	echo "maxconnections=24" >> $confPath
	echo "masternodeprivkey=$masternodeprivkey" >> $confPath
	echo "logtimestamps=1" >> $confPath
	echo "mnconflock=1" >> $confPath

	nohup $coinCommand &


fi

