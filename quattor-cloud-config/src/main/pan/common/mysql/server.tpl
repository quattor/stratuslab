#
# Copied from QWG templates.
#

unique template common/mysql/server;

# Include RPMs for MySQL server
include { 'config/os/mysql' };


# ---------------------------------------------------------------------------- 
# chkconfig
# ---------------------------------------------------------------------------- 
include { 'components/chkconfig/config' };


# ---------------------------------------------------------------------------- 
# Enable and start MySQL service
# ---------------------------------------------------------------------------- 
'/software/components/chkconfig/service/mysqld/on' = ''; 
'/software/components/chkconfig/service/mysqld/startstop' = true; 


# ---------------------------------------------------------------------------- 
# accounts
# ---------------------------------------------------------------------------- 
# Should be done by the rpms.  If not, create the given template or add
# the information here.
#
#include { 'users/mysql' };


# ---------------------------------------------------------------------------- 
# iptables
# ---------------------------------------------------------------------------- 
#include { 'components/iptables/config' };

# Limit access to MySQL (port 3306) to the localhost.

include { 'components/iptables/config' };

'/software/components/iptables/filter/rules' = append(
  nlist('command', '-A',
        'chain', 'INPUT',
        'protocol', 'tcp',
        'match', 'tcp',
        'source', '127.0.0.1',
        'dst_port', '3306',
        'target', 'accept'));

'/software/components/iptables/filter/rules' = append(
  nlist('command', '-A',
        'chain', 'INPUT',
        'protocol', 'tcp',
        'match', 'tcp',
        'dst_port', '3306',
        'target', 'reject',
        'reject-with', 'icmp-port-unreachable'));


# ---------------------------------------------------------------------------- 
# etcservices
# ---------------------------------------------------------------------------- 
include { 'components/etcservices/config' };

'/software/components/etcservices/entries' = append('mysql 3306/tcp');
'/software/components/etcservices/entries' = append('mysql 3306/udp');


# ---------------------------------------------------------------------------- 
# cron
# ---------------------------------------------------------------------------- 
#include { 'components/cron/config' };


# ---------------------------------------------------------------------------- 
# altlogrotate
# ---------------------------------------------------------------------------- 
#include { 'components/altlogrotate/config' }; 
