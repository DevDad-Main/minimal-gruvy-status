#!/usr/bin/env bash

get_tmux_option() {
  local option=$1
  local default_value="$2"
  local option_value
  option_value=$(tmux show-options -gqv "$option")

  if [ "$option_value" != "" ]; then
    echo "$option_value"
    return
  fi
  echo "$default_value"
}

# Helper to set a tmux option only if it doesn't already exist
set_default_option() {
  local option=$1
  local default_value=$2
  local current_value
  current_value=$(tmux show-option -gqv "$option")

  if [ -z "$current_value" ]; then
    tmux set-option -g "$option" "$default_value"
  fi
}

# -------------------------------------------------------------------
# 🎨 Default style and color settings for minimal-tmux
# -------------------------------------------------------------------
set_default_option "status-style" "bg=default"
set_default_option "status-position" "bottom"

set_default_option "@minimal-tmux-use-arrow" "true"
set_default_option "@minimal-tmux-right-arrow" ""
set_default_option "@minimal-tmux-left-arrow" ""

set_default_option "@minimal-tmux-bg" "#C18F1A"
set_default_option "@minimal-tmux-fg" "#3C3836"
set_default_option "@minimal-tmux-accent" "#FABD2F"
set_default_option "@minimal-tmux-alt-fg" "#D5C4A1"
# -------------------------------------------------------------------

default_color="#[bg=default,fg=default,bold]"

# variables
bg=$(get_tmux_option "@minimal-tmux-bg" "#C18F1A")
fg=$(get_tmux_option "@minimal-tmux-fg" "#3C3836")

use_arrow=$(get_tmux_option "@minimal-tmux-use-arrow" true)
larrow="$("$use_arrow" && get_tmux_option "@minimal-tmux-left-arrow" "")"
rarrow="$("$use_arrow" && get_tmux_option "@minimal-tmux-right-arrow" "")"

status=$(get_tmux_option "@minimal-tmux-status" "bottom")
justify=$(get_tmux_option "@minimal-tmux-justify" "centre")

indicator_state=$(get_tmux_option "@minimal-tmux-indicator" true)
indicator_str=$(get_tmux_option "@minimal-tmux-indicator-str" " tmux ")
indicator=$("$indicator_state" && echo " $indicator_str ")

right_state=$(get_tmux_option "@minimal-tmux-right" true)
left_state=$(get_tmux_option "@minimal-tmux-left" true)

status_right=$("$right_state" && get_tmux_option "@minimal-tmux-status-right" "#S")
status_left=$("$left_state" && get_tmux_option "@minimal-tmux-status-left" "${default_color}#{?client_prefix,,${indicator}}#[bg=${bg},fg=${fg},bold]#{?client_prefix,${indicator},}${default_color}")
status_right_extra="$status_right$(get_tmux_option "@minimal-tmux-status-right-extra" "")"
status_left_extra="$status_left$(get_tmux_option "@minimal-tmux-status-left-extra" "")"

window_status_format=$(get_tmux_option "@minimal-tmux-window-status-format" ' #I:#W ')

expanded_icon=$(get_tmux_option "@minimal-tmux-expanded-icon" '󰊓 ')
show_expanded_icon_for_all_tabs=$(get_tmux_option "@minimal-tmux-show-expanded-icon-for-all-tabs" false)

# -------------------------------------------------------------------
# Apply settings to tmux
# -------------------------------------------------------------------
tmux set-option -g status-position "$status"
tmux set-option -g status-style "bg=default,fg=default"
tmux set-option -g status-justify "$justify"

tmux set-option -g status-left "$status_left_extra"
tmux set-option -g status-right "$status_right_extra"

tmux set-option -g window-status-format "$window_status_format"
"$show_expanded_icon_for_all_tabs" && \
  tmux set-option -g window-status-format " ${window_status_format}#{?window_zoomed_flag,${expanded_icon},}"

# Active window "bubble" style
tmux set-option -g window-status-current-format "#[fg=${bg}]#[bg=${bg},fg=${fg},bold] ${window_status_format} #[fg=${bg},bg=default]"

# Inactive windows (flat or muted)
tmux set-option -g window-status-format "#[fg=${bg},bg=default] ${window_status_format} "

# -------------------------------------------------------------------
# 🧠 Status Right — CPU + RAM + Icons
# -------------------------------------------------------------------
tmux set -g status-right "#[fg=#D79921] #[fg=#EBDBB2]#(top -bn1 | grep 'Cpu(s)' | awk '{print \$2 + \$4}')%% #[fg=#D79921]|  #[fg=#EBDBB2]#(free -h | awk '/Mem:/ {print \$3\"/\"\$2}') "
