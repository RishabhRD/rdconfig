instance="$(pgrep 'picom')"
if [ -z "$instance" ]; then
	picom
else
	pkill picom
fi
