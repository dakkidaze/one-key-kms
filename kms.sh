#!/bin/bash
# Author: Dakkidaze <gioku@docomo.net.cn>

DAEMON=/usr/local/kms/vlmcsd
STAT=2
check_running(){
PID=`ps -ef | grep -v grep | grep -i "vlmcsd" | awk '{print $2}'`
       if [ ! -z $PID ]; then
        STAT=0
    else
        STAT=1
    fi
}

do_restart() {
	check_running
	if [ $STAT = 0 ]; then
		echo "Restarting KMS Server..."
		kill $PID
	elif [ $STAT = 1 ]; then
		echo "Not started, starting now"
	fi
	$DAEMON -L 0.0.0.0:1688 -l vlmcsd.log
	check_running
	if [ $STAT = 0 ]; then
		echo "Succeeded."
	elif [ $STAT = 1 ]; then
		echo "Failed."
	fi
}
do_stop() {
	check_running
	if [ $STAT = 0 ]; then
	        echo "Shutting down KMS Server..."
		kill $PID
		check_running
		if [ $STAT = 0 ]; then
			echo "Failed."
		elif [ $STAT = 1 ]; then
			echo "Succeeded."
	        fi
        elif [ $STAT = 1 ]; then
                echo "Not running, no kill."
        fi
}
do_status() {
	check_running
	if [ $STAT = 0 ]; then
                echo "KMS Server is running."
        elif [ $STAT = 1 ]; then
                echo "KMS Server is not running."
        fi
}

do_start() {
	check_running
	if [ $STAT = 0 ]; then
                echo "KMS Server is already running."
		exit 0;
        elif [ $STAT = 1 ]; then
                echo "KMS Server is not running, starting now..."
	$DAEMON -L 0.0.0.0:1688 -l vlmcsd.log
	fi
        check_running
        if [ $STAT = 0 ]; then
                echo "Succeeded."
        elif [ $STAT = 1 ]; then
                echo "Failed."
        fi
}

case "$1" in
    start|stop|restart|status)
    do_$1
    ;;
    *)
    echo "Usage: $0 start | stop | restart | status "
    ;;
esac
