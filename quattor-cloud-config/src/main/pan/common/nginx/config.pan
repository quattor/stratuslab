unique template common/nginx/config;

include { 'components/chkconfig/config' };

prefix '/software/components/chkconfig';

'service/nginx/on' = '';
'service/nginx/startstop' = true;
