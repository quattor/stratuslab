
unique template common/security/crl;

variable FETCH_CRL_QUIET ?= true;
variable FETCH_CRL_FORCE_OVERWRITE ?= true;


# ---------------------------------------------------------------------------- 
# fetch-crl configuration
# ---------------------------------------------------------------------------- 
include { 'components/sysconfig/config' };
"/software/components/sysconfig/files/fetch-crl/CRLDIR" = SITE_DEF_CERTDIR;
"/software/components/sysconfig/files/fetch-crl/FORCE_OVERWRITE" = if ( FETCH_CRL_FORCE_OVERWRITE ) {
                                                                     'yes';
                                                                   } else {
                                                                     'no';
                                                                   };
"/software/components/sysconfig/files/fetch-crl/QUIET" = if ( FETCH_CRL_QUIET ) {
                                                           'yes';
                                                         } else {
                                                           'no';
                                                         };

# ---------------------------------------------------------------------------- 
# cron
# ---------------------------------------------------------------------------- 
include { 'components/cron/config' };
"/software/components/cron/entries" =
  push(nlist(
    "name","fetch-crl-cron",
    "user","root",
    "frequency", "AUTO 3,9,15,21 * * *",
    "command", '/usr/sbin/fetch-crl  --no-check-certificate --loc '+SITE_DEF_CERTDIR+' -out '+SITE_DEF_CERTDIR+' -a 24 --quiet'));


# ---------------------------------------------------------------------------- 
# altlogrotate
# ---------------------------------------------------------------------------- 
include { 'components/altlogrotate/config' }; 
"/software/components/altlogrotate/entries/fetch-crl-cron" = 
  nlist("pattern", "/var/log/fetch-crl-cron.ncm-cron.log",
        "compress", true,
        "missingok", true,
        "frequency", "monthly",
        "create", true,
        "ifempty", true,
        "rotate", 12);

