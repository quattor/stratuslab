${BUILD_INFO}
${LEGAL}

unique template one/service/xmlrpc-ssl-proxy-frontend;

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

"/software/components/filecopy/services" =
  npush(escape("/etc/httpd/conf.d/proxy_xmlrpc.conf"),
        nlist("config",CONTENTS,
              "owner","root",
              "perms","0644",
        ));


include { 'components/iptables/config' };

# Inbound port(s).

#"/software/components/iptables/filter/rules" = push(
#  nlist("command", "-A",
#        "chain", "input",
#        "protocol", "tcp",
#	"source", "127.0.0.1",
#        "dst_port", "2633",
#        "target", "accept"));

#"/software/components/iptables/filter/rules" = push(
#  nlist("command", "-A",
#        "chain", "input",
#        "protocol", "tcp",
#        "dst_port", "2633",
#        "target", "drop"));

