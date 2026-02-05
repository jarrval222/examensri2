#!/bin/bash

service named start
service vsftpd start
a2enmod authz_groupfile
apache2ctl -D FOREGROUND