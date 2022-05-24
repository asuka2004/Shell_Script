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

function set_timezone(){
	cp /etc/locale.conf /etc/locale.conf.`date +"%Y-%m-%d"`
	localectl set-locale LANG=C
	cat  /etc/locale.conf
}

function sync_time(){
	cron=/var/spool/cron/root
	if [ `grep -w "ntpdate" $cron|wc -l` -lt 1 ]
	 then
		echo '#time sync by Kung' >>$cron
		echo '*/5 * * * * /usr/sbin/ntpdate time.stdtime.gov.tw>/dev/null 2>&1' >>$cron
		crontabl -l 
	fi
}

function opt_file(){
	if [ `grep 65535 /etc/security/limits.conf|wc -l` -lt 1 ]
	 then
		echo '* - nofile 65535 '>>/etc/security/limits.conf
	fi
	ulimit -SHn 65535
}

function opt_profile(){
	echo 'export TMOUT=300' >>/etc/profile
	echo 'export HISTSIZE=5' >> /etc/profile
	echo 'export HISTFILESIZE=5' >> /etc/profile
	tail -3 /etc/profile
	. /etc/profile
}

function opt_kernel(){
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
}

function opt_sshd(){
	cp /etc/ssh/sshd_config /etc/ssh/sshd_config.`date +"%Y-%m-%d"`
	sed -i -e "17s/.*/Port 55555/g" /etc/ssh/sshd_config
	sed -i -e "19s/.*/ListenAddress 192.168.88.51/g" /etc/ssh/sshd_config
	sed -i -e "38s/.*/PermitRootLogin no/g" /etc/ssh/sshd_config
	sed -i -e "64s/.*/PermitEmptyPasswords no/g" /etc/ssh/sshd_config 
	sed -i -e "79s/.*/GSSAPIAuthentication no/g" /etc/ssh/sshd_config
	sed -i -e "115s/.*/UseDNS no/g" /etc/ssh/sshd_config
	/etc/init.d/sshd reload &>/dev/null
}


function add_user(){
	if [ `grep -w Kung /etc/passwd|wc -l` -lt 1 ]
	 then
		useradd Kung
		echo P@ssw0rd| passwd --stdin Kung
		cp /etc/sudoers /etc/sudoers.ori
		echo "Kung ALL=(ALL) NOPASSWD:ALL" >>/etc/sudoers
		visudo -c &>/dev/null	
	fi
}


function disable_service(){
	systemctl list-unit-files | grep enable| egrep -v "sshd.service|cron.service|sysstat|rsyslog|NetworkManager.service|irqbalance.service" |awk '{print "systemctl disable",$1}'
}


function lock_file(){
	chattr +i /etc/passwd /etc/shadow /etc/group
	chattr +i /etc/inittab /etc/fstab /etc/sudoers
	lsattr /etc/passwd /etc/shadow /etc/group /etc/inittab /etc/fstab /etc/sudoers
	mv /usr/bin/chattr /opt/tmp
	cp /usr/bin/any /usr/bin/chattr
}

function clear_issue(){
	cat /dev/null>/etc/issue
	cat /dev/null>/etc/issue.net
}

function ban_ping(){
	echo "net.ipv4.icmp_echo_ignore_all=1">> /etc/sysctl.conf
}

main(){
	set_timezone
	sync_time
	opt_file
	opt_profile
	opt_kernel
	opt_sshd
	add_user
	disable_service
	lock_file
	clear_issue
	ban_ping
}
main
