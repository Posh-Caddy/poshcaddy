$relserverbin="/usr/bin/caddy"
$relcaddyfile = "Caddyfile"

$serverbin = $(get-item $relserverbin).fullname
$caddyfile = $(get-item $relcaddyfile).fullname

& $serverbin start --config $caddyfile | tail -f -
