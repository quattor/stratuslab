# ${BUILD_INFO}
#
# Created as part of the StratusLab project (http://stratuslab.eu)
#
# Copyright (c) 2010, Centre Nationale de la Recherche Scientifique
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

unique template one/service/xmlrpc-ssl-proxy-frontend;

# 
# Ensure that Apache is started on the server. 
#
include { 'components/chkconfig/config' };

'/software/components/chkconfig/service/httpd/on' = '';
'/software/components/chkconfig/service/httpd/startstop' = true;


# Apache reverse proxy for XMLRPC
variable CONTENTS = <<EOF;
Listen 2634

<VirtualHost _default_:2634>
 ProxyPass        /RPC2 http://127.0.0.1:2633/RPC2
 ProxyPassReverse /RPC2 http://127.0.0.1:2633/RPC2
ErrorLog logs/ssl_error_log
TransferLog logs/ssl_access_log
LogLevel warn
SSLEngine on
SSLProtocol all -SSLv2
SSLCipherSuite ALL:!ADH:!EXPORT:!SSLv2:RC4+RSA:+HIGH:+MEDIUM:+LOW
SSLCertificateFile /etc/pki/tls/certs/localhost.crt
SSLCertificateKeyFile /etc/pki/tls/private/localhost.key
<Files ~ "\.(cgi|shtml|phtml|php3?)$">
    SSLOptions +StdEnvVars
</Files>
<Directory "/var/www/cgi-bin">
    SSLOptions +StdEnvVars
</Directory>
SetEnvIf User-Agent ".*MSIE.*" \
         nokeepalive ssl-unclean-shutdown \
         downgrade-1.0 force-response-1.0
CustomLog logs/ssl_request_log \
          "%t %h %{SSL_PROTOCOL}x %{SSL_CIPHER}x \"%r\" %b"

</VirtualHost>
EOF

'/software/components/filecopy/services' =
  npush(escape('/etc/httpd/conf.d/proxy_xmlrpc.conf'),
        nlist('config',CONTENTS,
              'owner','root',
              'perms','0644',
        ));
