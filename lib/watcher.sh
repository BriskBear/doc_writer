rute=`dirname -- $(realpath ${BASH_SOURCE[0]})`

function has_changed() {
  handle="`echo "$1"|awk -F'[/.]' '{print $2}'`_SUM"
  tmp_sum=`md5sum "$1"|awk '{print $1}'`

  if [[ ${!handle} != $tmp_sum ]]
  then
    export $handle=$tmp_sum
    return 0
  else
    return 1
  fi
}

function rebuild() {
  has_changed "$1"
  if [[ $? -eq 0 ]]
  then
    printf "[38;5;122m$1 has changed, rebuilding...\n[0m"
    ./build
    hyprctl dispatch sendshortcut ,F5, title:"Zen Browser" &>/dev/null
  fi
}

printf "[38;5;122m/: ${rute}\n[0m"
ls ${rute}/../build
printf "[38;5;122mStarted watching md/intro.md.erb\n[0m"
printf "[38;5;122mStarted watching md/body.md.erb\n[0m"

while true
do
  rebuild md/intro.md
  rebuild md/body.md
  sleep 2
done
