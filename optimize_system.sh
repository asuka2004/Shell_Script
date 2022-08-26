#!/bin/bash
# Author      : Kung
# Build       : 2022-04-21 21:07
# Version     : V1.0
# Description : Optimization system           
# System      : CentOS 7.9 
			       
export PS4='++ ${LINENO}'  
export LANG=C
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions
Script_Path=/root/project/github
[ ! -d ${Script_Path} ] && mkdir -p ${Script_Path}
Log_Path=/root/tmp
[ ! -d ${Log_Path} ] && mkdir -p ${Log_Path}

if [ "$UID" != "0" ]
 then
	echo "Please run the script by root"
	exit 1
fi

function install_soft(){
	yum install net-tools wget vim-enhanced ntpdate -y
	yum update -y
}

function set_hostname(){
	IP=`ifconfig eth0 |awk -F '[ :]+' 'NR==2 {print $3}'|awk -F '[ .]+' 'NR==1 {print $4}'`	
	hostnamectl set-hostname Test-$IP 
}

function set_language(){
	cp /etc/locale.conf /etc/locale.conf.`date +"%Y-%m-%d"`
	localectl set-locale LANG=C
	cat  /etc/locale.conf
}

function sync_time(){
	cron=/var/spool/cron/root
	if [ `grep -w "ntpdate" $cron|wc -l` -lt 1 ]
	 then
		echo '#Sync time by Kung' >>$cron
		echo '*/5 * * * * /usr/sbin/ntpdate time.stdtime.gov.tw>/dev/null 2>&1' >>$cron
		crontab -l 
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
	IP=`ifconfig eth0 |awk -F '[ :]+' 'NR==2 {print $3}'`	
	cp /etc/ssh/sshd_config /etc/ssh/sshd_config.`date +"%Y-%m-%d"`
	sed -i -e "17s/.*/Port 55555/g" /etc/ssh/sshd_config
	sed -i -e "19s/.*/ListenAddress $IP/g" /etc/ssh/sshd_config
	sed -i -e "38s/.*/PermitRootLogin no/g" /etc/ssh/sshd_config
	sed -i -e "64s/.*/PermitEmptyPasswords no/g" /etc/ssh/sshd_config 
	sed -i -e "79s/.*/GSSAPIAuthentication no/g" /etc/ssh/sshd_config
	sed -i -e "115s/.*/UseDNS no/g" /etc/ssh/sshd_config
	systemctl restart sshd	
}


function add_user(){
	if [ `grep -w Kung /etc/passwd|wc -l` -lt 1 ]
	 then
		useradd Kung
		read -p "Please input password:" Pwd
		echo $Pwd| passwd --stdin Kung
		cp /etc/sudoers /etc/sudoers.ori
		echo "Kung ALL=(ALL) NOPASSWD:ALL" >>/etc/sudoers
		visudo -c &>/dev/null	
	fi
}


function disable_service(){
	systemctl list-unit-files | grep enable| egrep -v "sshd.service|firewalld.service|cron.service|sysstat|rsyslog|NetworkManager.service|irqbalance.service" |awk '{print "systemctl disable",$1}'|bash
}


function lock_file(){
	chattr +i /etc/passwd /etc/shadow /etc/group /etc/inittab /etc/fstab /etc/sudoers
	lsattr /etc/passwd /etc/shadow /etc/group /etc/inittab /etc/fstab /etc/sudoers
	mv /usr/bin/chattr /opt/
}

function clear_issue(){
	cat /dev/null>/etc/issue
	cat /dev/null>/etc/issue.net
}

function ban_ping(){
	echo "net.ipv4.icmp_echo_ignore_all=1">> /etc/sysctl.conf
}


main(){
	
	install_soft
        if [ $? -eq 0 ]
         then
		 action "Success to install " /bin/true
        else
                 action "Fail to install " /bin/false
	fi

	set_hostname
        if [ $? -eq 0 ]
         then
		 action "Success to setup hostname" /bin/true
        else
                 action "Fail to setup hostname" /bin/false
	fi

	set_language
        if [ $? -eq 0 ]
         then
		 action "Success to setup timezone" /bin/true
        else
                 action "Fail to setup timezone" /bin/false
	fi
	
	sync_time
        if [ $? -eq 0 ]
         then
		 action "Success to sync time" /bin/true
        else
                 action "Fail to sync time" /bin/false
	fi

	opt_file
        if [ $? -eq 0 ]
         then
		 action "Success to opt file" /bin/true
        else
                 action "Fail to opt file" /bin/false
	fi
	
	opt_profile
        if [ $? -eq 0 ]
         then
		 action "Success to opt profile" /bin/true
        else
                 action "Fail to opt profile" /bin/false
	fi

	opt_kernel
        if [ $? -eq 0 ]
         then
		 action "Success to opt kernel" /bin/true
        else
                 action "Fail to opt kernel" /bin/false
	fi
	
	opt_sshd
        if [ $? -eq 0 ]
         then
		 action "Success to opt ssh" /bin/true
        else
                 action "Fail to opt ssh" /bin/false
	fi
	
	add_user
        if [ $? -eq 0 ]
         then
		 action "Success to add" /bin/true
        else
                 action "Fail to add" /bin/false
	fi

        disable_service
        if [ $? -eq 0 ]
         then
		 action "Success to disable" /bin/true
        else
                 action "Fail to disable" /bin/false
	fi

	lock_file
        if [ $? -eq 0 ]
         then
		 action "Success to lock file" /bin/true
        else
                 action "Fail to lock file" /bin/false
	fi
        
	clear_issue
        if [ $? -eq 0 ]
         then
		 action "Success to clear" /bin/true
        else
                 action "Fail to clear" /bin/false
	fi
        
	ban_ping
        if [ $? -eq 0 ]
         then
		 action "Success to ban" /bin/true
        else
                 action "Fail to ban " /bin/false
	fi
	
	echo "Warning !!!  Reboot soon "
	sleep 5
	reboot	
}
main
