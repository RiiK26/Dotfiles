#
# ~/.bashrc
#
[[ $- == *i* ]] && source /usr/share/blesh/ble.sh --noattach

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='\[\e[1;32m\][\u#\h \W]\$ \[\e[0m\]'

export GOTELEMETRY=off
export XKB_DEFAULT_LAYOUT="us,ara"
export XKB_DEFAULT_OPTIONS="grp:alt_shift_toggle"
export PATH="$HOME/.local/bin:$PATH"
export VCPKG_DISABLE_METRICS=1
export PATH=$PATH:$HOME/go/bin
export NDK_HOME=/opt/android-ndk
export GPG_TTY=$(tty)
export GH_TELEMETRY=false

[[ ${BLE_VERSION-} ]] && ble-attach
