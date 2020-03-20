#!/usr/bin/env bash
sleep 10;
/var/www/symfony/bin/console messenger:consume success;
