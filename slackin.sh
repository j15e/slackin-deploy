#!/bin/bash
### BEGIN INIT INFO
# If you wish the Daemon to be lauched at boot / stopped at shutdown :
#
#    On Debian-based distributions:
#      sudo cp slackin.sh /etc/init.d/slackin
#      sudo chmod a+x /etc/init.d/slackin
#      INSTALL : update-rc.d slackin defaults
#      (UNINSTALL : update-rc.d -f slackin remove)
#      ls -l /etc/rc*.d/*slackin*
#
#    On RedHat-based distributions (CentOS, OpenSUSE...):
#      INSTALL : chkconfig --level 35 slackin on
#      (UNINSTALL : chkconfig --level 35 slackin off)
#
# chkconfig:         2345 90 60
# Provides:          /vagrant/app.js
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: forever running /vagrant/app.js
# Description:       /vagrant/app.js
### END INIT INFO
#
# initd a node app
# Based on a script posted by https://gist.github.com/jinze at https://gist.github.com/3748766
#

if [ -e /lib/lsb/init-functions ]; then
	# LSB source function library.
	. /lib/lsb/init-functions
fi;

pidFile="/var/run/slackin.pid"
logFile="/vagrant/slackin.log"

command="/home/vagrant/.anyenv/envs/nodenv/shims/node"
nodeApp="/vagrant/app.js"
foreverApp="/home/vagrant/.anyenv/envs/nodenv/shims/forever"

start() {
  echo "Starting $nodeApp"
  export NODE_ENV=production
  $foreverApp start --pidFile $pidFile -l $logFile -a -d -c "$command" $nodeApp
  RETVAL=$?
}

restart() {
	echo -n "Restarting $nodeApp"
	$foreverApp restart $nodeApp
	RETVAL=$?
}

stop() {
	echo -n "Shutting down $nodeApp"
   $foreverApp stop $nodeApp
   RETVAL=$?
}

status() {
   echo -n "Status $nodeApp"
   $foreverApp list
   RETVAL=$?
}

case "$1" in
   start)
        start
        ;;
    stop)
        stop
        ;;
   status)
        status
       ;;
   restart)
   	restart
        ;;
	*)
       echo "Usage:  {start|stop|status|restart}"
       exit 1
        ;;
esac
exit $RETVAL
