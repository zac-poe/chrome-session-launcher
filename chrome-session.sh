#!/bin/bash
#
# Launches chrome as an nth independent session
#

# follow symlinks
script_dir="$(cd "$(dirname "$([[ -h "$0" ]] && readlink "$0" || echo "$0")")" && pwd)"

usage() {
    echo "Usage: $(basename "$0") [[-s] session-number]"
    echo -e "\nOptions:"
    echo -e "\t-s"
    echo -e "\t\tnth session to launch"
    exit 1
}

# defaults
session_num=0

set_session() {
    if [[ ! "$1" =~ ^[0-9]+ ]]; then
        echo -e "Invalid session number: $1\n"
        usage
    fi
    session_num="$1"
}

while getopts "s:" opt; do
    case "$opt" in
        s) 
            set_session "$OPTARG"
        ;;
        *) 
            usage
        ;;
    esac
done
OPTIND=1

# support shorthand session number selection and prevent unintentional misuse
if [[ ${#1} -gt 0 ]]; then
    set_session "$1"
fi

# detect OS to support overrides
shopt -s nocasematch
case "$(uname -a)" in
    *darwin*) launch_command="open -a 'google chrome' -n --args";;
    *) launch_command='chrome';;
esac
shopt -u nocasematch

# user data dir allows independent session simulation, when 0, will use the system default
if [[ "$session_num" -gt 0 ]]; then
    data_dir="$script_dir/tmp/$session_num"
    mkdir -p "$data_dir"
    launch_command="$launch_command --user-data-dir=\"$data_dir\""
fi

eval $launch_command
