# Theme Elements
theme="$HOME/.config/rofi/apps/theme.rasi"

status="`playerctl status`"
if [[ -z "$status" ]]; then
	prompt='Offline'
	mesg="Nothing Playing right now"
else
	prompt="`playerctl metadata title`"
	mesg="`playerctl metadata artist`"
fi

list_col='6'
list_row='1'

if [[ ${status} == "Playing" ]]; then
	option_1=""
else
	option_1=""
fi
option_2=""
option_3=""
option_4=""
option_5=""
option_6=""

# Toggle Actions
active=''
urgent=''
# Repeat
if [[ "`playerctl loop`" == "None" ]]; then
    urgent="-a 4"
else
    active="-u 4"
fi
# Random
if [[ "`playerctl shuffle`" == "On" ]]; then
    [ -n "$active" ] && active+=",5" || active="-a 5"
else
    [ -n "$urgent" ] && urgent+=",5" || urgent="-u 5"
fi

# Rofi CMD
rofi_cmd() {
	rofi -theme-str "listview {columns: $list_col; lines: $list_row;}" \
		-theme-str 'textbox-prompt-colon {str: "";}' \
		-dmenu \
		-p "$prompt" \
		-mesg "$mesg" \
		${active} ${urgent} \
		-markup-rows \
		-theme ${theme}
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$option_1\n$option_2\n$option_3\n$option_4\n$option_5\n$option_6" | rofi_cmd
}

# Execute Command
run_cmd() {
	if [[ "$1" == '--opt1' ]]; then
		playerctl play-pause && notify-send -u low -t 1000 " `playerctl metadata title`"
	elif [[ "$1" == '--opt2' ]]; then
		playerctl stop
	elif [[ "$1" == '--opt3' ]]; then
		playerctl previous && notify-send -u low -t 1000 " `playerctl metadata title`"
	elif [[ "$1" == '--opt4' ]]; then
		playerctl next && notify-send -u low -t 1000 " `playerctl metadata title`"
	elif [[ "$1" == '--opt5' ]]; then
		playerctl loop
	elif [[ "$1" == '--opt6' ]]; then
		playerctl shuffle
	fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $option_1)
		run_cmd --opt1
        ;;
    $option_2)
		run_cmd --opt2
        ;;
    $option_3)
		run_cmd --opt3
        ;;
    $option_4)
		run_cmd --opt4
        ;;
    $option_5)
		run_cmd --opt5
        ;;
    $option_6)
		run_cmd --opt6
        ;;
esac
