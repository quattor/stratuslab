unique template common/fetch-crl/rpms;

variable FETCH_CRL_RPM_NAME ?= 'fetch-crl';
variable FETCH_CRL_VERSION ?= '3.0.5-1.fc14';

'/software/packages' = pkg_repl(FETCH_CRL_RPM_NAME, FETCH_CRL_VERSION,'noarch');
