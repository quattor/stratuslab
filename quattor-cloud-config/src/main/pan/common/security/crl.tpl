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

