#!/bin/bash
cage -m extend -d -a "burn-cli.sh;HDMI-A-1" -a "burn.sh;DSI-1" -i "raspberrypi-ts;DSI-1" -i "深圳市全动电子技术有限公司 ByQDtech 触控USB鼠标;HDMI-A-1" -- "/app/burn.sh;/app/burn-cli.sh" > /var/log/cage/cage.log 2> /var/log/cage/cage_err.log
