#!/usr/bin/env bash
# -*- coding: utf-8 -*-
echo "<html><head>"
echo "<title>ips</title>"
echo '<meta http-equiv="Content-type"
content="text/html;charset=UTF-8">'
echo "</head><body>"
list=`cat /var/log/nginx/access.log | head -3 | awk '{print $1}'`
for line in $list; do
    echo "$line</br>"
done
echo "</body></html>"
