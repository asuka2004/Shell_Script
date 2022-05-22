#!/bin/bash
# Author      : Kung
# Build       : 2022-04-21 21:07
# Version     : V1.0
# Description : Optimization system           
# System      : CentOS 7.6 
			       
export PS4='++ ${LINENO}'  
export LANG=C
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions
Script_Path=/root/github
[ ! -d ${Script_Path} ] && mkdir -p ${Script_Path}
Log_Path=/root/tmp
[ ! -d ${Log_Path} ] && mkdir -p ${Log_Path}

if [ "$UID" != "0" ]
 then
	echo "Please run the script by root"	
	exit 1
fi


function adduser(){
	if [ `grep -w Kung /etc/passwd|wc -l` -lt 1 ]
	 then
		useradd Kung
		echo P@ssw0rd| passwd --stdin Kung
		cp /etc/sudoers /etc/sudoers.ori
		echo "Kung ALL=(ALL) NOPASSWD:ALL" >>/etc/sudoers
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

function disable_service(){
	systemctl list-unit-files | grep enable| egrep -v "sshd.service|cron.service|sysstat|rsyslog|NetworkManager.service|irqbalance.service" |awk '{print "systemctl disable",$1}'
}

function timezone(){
	cp /etc/locale.conf{,.ori}
	localectl set-locale LANG=C
	cat /etc/locale.conf
}

function correct_time(){
	ntpdate time.stdtime.gov.tw
	echo '#cron-id-001:time sync by Kung'>>/var/spool/cron/root
	echo "*/5 * * * * /usr/sbin/ntpdate time.stdtime.gov.tw > /dev/null 2>&1" >>/var/spool/cron/root
	crontab -l		
}

function command(){
	echo 'export TMOUT=300' >>/etc/profile
	echo 'export HISTSIZE=5' >> /etc/profile
	echo 'export HISTFILESIZE=5' >> /etc/profile
	tail -3 /etc/profile
	. /etc/profile
}

function limit(){
	echo '*		- 	nofile 		65535'>>/etc/security/limits.conf
	tail -l /etc/security/limits.conf
	ulimit -SHn 65535
	ulimit -n
}

function ssh(){
	cp /etc/ssh/sshd_config{,.ori}
	sed -i -e "17s/.*/Port 55555/g" /etc/ssh/sshd_config
	sed -i -e "19s/.*/ListenAddress 192.168.88.51/g" /etc/ssh/sshd_config
	sed -i -e "38s/.*/PermitRootLogin no/g" /etc/ssh/sshd_config
	sed -i -e "64s/.*/PermitEmptyPasswords no/g" /etc/ssh/sshd_config 
	sed -i -e "79s/.*/GSSAPIAuthentication no/g" /etc/ssh/sshd_config
	sed -i -e "115s/.*/UseDNS no/g" /etc/ssh/sshd_config
}

function file(){
	chattr +i /etc/passwd /etc/shadow /etc/group
	chattr +i /etc/inittab /etc/fstab /etc/sudoers
	lsattr /etc/passwd /etc/shadow /etc/group /etc/inittab /etc/fstab /etc/sudoers
	mv /usr/bin/chattr /opt/tmp
	cp /usr/bin/any /usr/bin/chattr
}

function issue(){
	cat /dev/null>/etc/issue
	cat /dev/null>/etc/issue.net
}

function ping(){
	echo "net.ipv4.icmp_echo_ignore_all=1">> /etc/sysctl.conf
}

function alias(){
	echo "alias grep='grep --color=auto'">>/etc/profile
	source /etc/profile	
}


main(){
	init_ssh
	set_kernel
	ope_file
	time_sync
	charset
	adduser
}
main
