#!/bin/bash

BASEDIR=$HOME/.config/pilha
[ -d $BASEDIR ] || mkdir $BASEDIR

cmd=$1
shift 1

function filter {
    if [[ $1 == "" ]];then
        cat
        exit 0
    fi

    t=$1
    shift 1
    grep $t | filter $*
}

if [[ $cmd == "add" || $cmd == "+" ]];then
    entry=$1
    main_tag=$2
    shift 2
    echo "$entry % $main_tag $*" >> $BASEDIR/$main_tag

elif [[ $cmd == "get" || $cmd == "g" ]];then
    term=$1
    grep -h -i "$term" $BASEDIR/* | filter $*

elif [[ $cmd == "Get" || $cmd == "G" ]];then
    term=$1
    grep -h "$term" $BASEDIR/* | filter $*

elif [[ $cmd == "bget" || $cmd == "b" ]];then
    # "blind get": do not show tags
    term=$1
    grep -h "$term" $BASEDIR/* | sed 's: \% .\+::g'

elif [[ $cmd == "edit" || $cmd == "e" ]];then
    row=$(grep -h -i "$term" $BASEDIR/* | filter $* | head -1)
    tag=$(echo $row | sed 's:.\+ \% ::g' | cut -f1 -d' ')
    entry=$(echo $row | sed 's: \% .\+::g;s:/:\\/:g')
    vim "+/$entry" $BASEDIR/$tag

elif [[ $cmd == "ui" ]];then
    entry=$(cat $BASEDIR/* | dmenu -b -l 10)
    [[ $entry == "" ]] && exit 0
    if echo $entry | egrep -q '^\+ ';then
        value=$(xclip -selection clipboard -o)
        if [[ $value == "" ]];then
            exit 0
        fi
        tags=$(echo $entry | sed 's:^\+ ::g')
        $0 add "$value" $tags
    else
        echo -n $entry | sed 's: \% .\+::g' | xclip -selection clipboard -i
    fi

else
    echo "Unknown command. Available: add/get/Get/bget"
    exit 1
fi
