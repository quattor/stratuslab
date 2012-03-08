# ${BUILD_INFO}
#
# Created as part of the StratusLab project (http://stratuslab.eu)
#
# Copyright (c) 2010-2011, Centre National de la Recherche Scientifique
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

unique template one/service/squid-host;

variable CONTENTS = <<EOF;
acl all src all
acl manager proto cache_object
acl localhost src 127.0.0.1/255.255.255.255
acl to_localhost dst 127.0.0.0/8
acl SSL_ports port 443
acl Safe_ports port 80		# http
acl Safe_ports port 21		# ftp
acl Safe_ports port 443		# https
acl Safe_ports port 70		# gopher
acl Safe_ports port 210		# wais
acl Safe_ports port 1025-65535	# unregistered ports
acl Safe_ports port 280		# http-mgmt
acl Safe_ports port 488		# gss-http
acl Safe_ports port 591		# filemaker
acl Safe_ports port 777		# multiling http
acl CONNECT method CONNECT

http_access allow manager localhost
http_access deny manager
http_access deny !Safe_ports
http_access deny CONNECT !SSL_ports
http_access allow localhost
http_access deny all
icp_access allow all
http_port 3128

hierarchy_stoplist cgi-bin ?

cache_mem 4 GB
cache_dir ufs /var/spool/squid 15000 16 256
maximum_object_size 3 GB

access_log /var/log/squid/access.log squid
debug_options ALL,1
acl QUERY urlpath_regex cgi-bin \?
cache deny QUERY
refresh_pattern ^ftp:		1440	20%	10080
refresh_pattern ^gopher:	1440	0%	1440
refresh_pattern .		0	20%	4320
store_avg_object_size 2 GB
acl apache rep_header Server ^Apache
coredump_dir /var/spool/squid
EOF

"/software/components/filecopy/services" =
  npush(escape("/etc/squid/squid.conf"),
        nlist("config",CONTENTS,
              "owner","root",
              "perms","0755",
        ));


include { 'components/chkconfig/config' };

"/software/components/chkconfig/service/squid/on" = "";
"/software/components/chkconfig/service/squid/startstop" = true;

include { 'components/profile/config' };

'/software/components/profile/env/http_proxy' = 'http://127.0.0.1:3128';

include { 'components/iptables/config' };

'/software/components/iptables/filter/rules' = append(
  nlist('command', '-A',
        'chain', 'INPUT',
        'protocol', 'tcp',
        'match', 'tcp',
        'source', '127.0.0.1',
        'dst_port', '3128',
        'target', 'accept'));

