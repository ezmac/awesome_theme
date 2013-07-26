Xephyr :1 -ac -br -noreset -screen 1152x720 &
sleep 1
DISPLAY=:1.0 awesome -c ~/.config/awesome/rc.lua.new
