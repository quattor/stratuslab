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

unique template stratuslab-srv;

'/software/packages' = pkg_repl('mailman', '2.1.9-4.el5', 'x86_64');
'/software/packages' = pkg_del('sendmail', '8.13.8-8.el5', 'x86_64');

# Dependencies for dokuwiki
'/software/packages' = pkg_repl('ImageMagick', '6.2.8.0-4.el5_1.1', 'i386');
'/software/packages' = pkg_repl('php', '5.1.6-27.el5', 'x86_64');
'/software/packages' = pkg_repl('php-ldap', '5.1.6-27.el5', 'x86_64');

# Dependencies for dependencies of dokuwiki (mostly ImageMagik)
'/software/packages' = pkg_repl('atk', '1.12.2-1.fc6', 'i386');
'/software/packages' = pkg_repl('bzip2-libs', '1.0.3-4.el5_2', 'i386');
'/software/packages' = pkg_repl('cairo', '1.2.4-5.el5', 'i386');
'/software/packages' = pkg_repl('cups-libs', '1.3.7-18.el5_5.4', 'i386');
'/software/packages' = pkg_repl('fontconfig', '2.4.1-7.el5', 'i386');
'/software/packages' = pkg_repl('freetype', '2.2.1-21.el5_3', 'i386');
'/software/packages' = pkg_repl('ghostscript', '8.15.2-9.11.el5', 'i386');
'/software/packages' = pkg_repl('glib2', '2.12.3-4.el5_3.1', 'i386');
'/software/packages' = pkg_repl('gnutls', '1.4.1-3.el5_4.8', 'i386');
'/software/packages' = pkg_repl('gtk2', '2.10.4-20.el5', 'i386');
'/software/packages' = pkg_repl('lcms', '1.18-0.1.beta1.el5_3.2', 'i386');
'/software/packages' = pkg_repl('libICE', '1.0.1-2.1', 'i386');
'/software/packages' = pkg_repl('libSM', '1.0.1-3.1', 'i386');
'/software/packages' = pkg_repl('libXcursor', '1.1.7-1.1', 'i386');
'/software/packages' = pkg_repl('libXext', '1.0.1-2.1', 'i386');
'/software/packages' = pkg_repl('libXfixes', '4.0.1-2.1', 'i386');
'/software/packages' = pkg_repl('libXft', '2.1.10-1.1', 'i386');
'/software/packages' = pkg_repl('libXi', '1.0.1-4.el5_4', 'i386');
'/software/packages' = pkg_repl('libXinerama', '1.0.1-2.1', 'i386');
'/software/packages' = pkg_repl('libXrandr', '1.1.1-3.3', 'i386');
'/software/packages' = pkg_repl('libXrender', '0.9.1-3.1', 'i386');
'/software/packages' = pkg_repl('libXt', '1.0.2-3.2.el5', 'i386');
'/software/packages' = pkg_repl('libgcrypt', '1.4.4-5.el5', 'i386');
'/software/packages' = pkg_repl('libgpg-error', '1.4-2', 'i386');
'/software/packages' = pkg_repl('libjpeg', '6b-37', 'i386');
'/software/packages' = pkg_repl('libpng', '1.2.10-7.1.el5_5.3', 'i386');
'/software/packages' = pkg_repl('libtiff', '3.8.2-7.el5_5.5', 'i386');
'/software/packages' = pkg_repl('libwmf', '0.2.8.4-10.2', 'i386');
'/software/packages' = pkg_repl('libxml2', '2.6.26-2.1.2.8', 'i386');
'/software/packages' = pkg_repl('pango', '1.14.9-8.el5', 'i386');
'/software/packages' = pkg_repl('librsvg2', '2.16.1-1.el5', 'i386');
'/software/packages' = pkg_repl('php-cli', '5.1.6-27.el5', 'x86_64');
'/software/packages' = pkg_repl('php-common', '5.1.6-27.el5', 'x86_64');
'/software/packages' = pkg_repl('php-gd', '5.1.6-27.el5', 'x86_64');

include { 'config/stratuslab/stratuslab-srv' };
