#!/bin/bash
[ -d /var/log/cage ] || mkdir /var/log/cage
`cage -m extend -d -a "burn.sh;HDMI-A-1" -a "burn-cli.sh;DSI-1" -- "/app/burn.sh;/app/burn-cli.sh" >> /var/log/cage/cage.log 2>&1
