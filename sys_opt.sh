#!/bin/sh
# **************************************************
# Description  : optimize system
# Build        : 2022-04-05 16:32
# Author       : Kung
# System       : CentOS 7.6
# Version      : 1.1
#              :     
# *************************************************
export PATH=$PATH
. /etc/init.d/functions

if [ "$UID" != "0" ]
 then
	echo "Please run the script by root"	
	exit 1
fi


function adduser(){
	if [ `grep -w asuka /etc/passwd|wc -l` -lt 1 ]
	 then
		useradd asuka
		echo 123456| passwd --stdin asuka
		cp /etc/sudoers /etc/sudoers.ori
		echo "asuka ALL=(ALL) NOPASSWD:ALL" >>/etc/sudoers
		visudo -c &>/dev/null	
	fi
}

function charset(){
	cp /etc/sysconfig/il8n /etc/sysconfig/il8n.ori
	echo 'LANG=C' > /etc/sysconfig/il8n
	source /etc/sysconfig/il8n
}

function time_sync(){
	cron=/var/spool/cron/root
	if [ `grep -w "ntpdate" $cron|wc -l` -lt 1 ]
	 then
		echo '#time sync by Kung' >>$cron
		echo '*/5 * * * * /usr/sbin/ntpdate time.stdtime.gov.tw>/dev/null 2>&1' >>$cron
		crontabl -l 
	fi
}

function open_file(){
	if [ `grep 65535 /etc/security/limits.conf|wc -l` -lt 1 ]
	 then
		echo '* - nofile 65535 '>>/etc/security/limits.conf
	fi
}

function set_kernel(){
	if [ `grep kernel_flag /etc/sysctl.conf|wc -l` -lt 1 ]
	 then
		cat >> /etc/sysctl.conf<<EOF
		net.ipv4.tcp_fin_timeout = 2
		net.ipv4.tcp_tw_reuse = 1
		net.ipv4.tcp_syncookies = 1
		net.ipv4.tcp_keepalive_time = 600
		net.ipv4.ip_local_port_range = 4000 65000
		net.ipv4.tcp_max_syn_backlog = 16384
		net.ipv4.tcp_max_tw_buckets = 36000
		net.ipv4.route.gc_timeout = 100
		net.ipv4.tcp_syn_retries = 1
		net.ipv4.tcp_synack_retries = 1
		net.core.somaxconn = 16384
		net.core.netdev_max_backlog = 16384
		net.ipv4.tcp_max_orphans = 16384
		net.nf_conntrack_max = 25000000
		net.netfilter.nf_conntrack_max = 25000000	
		net.netfilter.nf_conntrack_tcp_timeout_established = 180
		net.netfilter.nf_conntrack_tcp_timeout_time_wait = 120
		net.netfilter.nf_conntrack_tcp_timeout_close_wait = 60
		net.netfilter.nf_conntrack_tcp_timeout_fin_wait = 120
EOF
		sysctl -p

	fi
function init_ssh(){
	cp /etc/ssh/sshd_config /etc/ssh/sshd_config.`date +"%Y-%m-%d"`
	sed -i 's%#PermitRootLogin yes%PermitRootLogin no%' /etc/ssh/sshd_config
	sed -i 's%#PermitEmptyPasswords no%PermitEmptyPasswords no%' /etc/ssh/sshd_config
	sed -i 's%#UseDNS yes%UseDNS no%' /etc/ssh/sshd_config
	/etc/init.d/sshd reload &>/dev/null	
}

main(){
	init_ssh
	set_kernel
	ope_file
	time_sync
	charset
	adduser
}
