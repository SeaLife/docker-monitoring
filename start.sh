#!/bin/bash


service apache2 restart
service cron start
service sendmail start

tailf /var/log/apache2/error.log
