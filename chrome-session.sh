#!/bin/bash
#
# Launches chrome as an nth independent session
#

# follow symlinks
script_dir="$(cd "$(dirname "$([[ -h "$0" ]] && readlink "$0" || echo "$0")")" && pwd)"

usage() {
    echo "Usage: $(basename "$0") [-s session-number]"
    echo -e "\nOptions:"
    echo -e "\t-s"
    echo -e "\t\tnth session to launch"
    exit 1
}

# defaults
session_num=0

while getopts "s:" opt; do
    case "$opt" in
        s)
            if [[ ! "$OPTARG" =~ ^[0-9]+ ]]; then
                echo -e "Invalid session number: $OPTARG\n"
                usage
            fi
            session_num=$OPTARG
        ;;
        *) 
            usage
        ;;
    esac
done
OPTIND=1

# support 'this.sh help' and prevent unintentional misuse with flags
if [[ ${#1} -gt 0 && $(printf -- "$1" | grep -c '^-') -le 0 ]]; then
    usage
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
