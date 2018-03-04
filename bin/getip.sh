wget -q -O - http://checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//' > /tmp/public_ip
