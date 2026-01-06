STATUS=$(bluetoothctl show | grep "Powered: yes")

if [ -n "$STATUS" ]; then
    bluetoothctl power off
else
    bluetoothctl power on
fi
