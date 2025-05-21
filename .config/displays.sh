#! /usr/bin/env bash

PRIMARY=$( xrandr | grep -oE "^.+\s+connected\s+primary" | cut -d ' ' -f1 )
CONNECTED=($( xrandr | grep -oE "^.+\sconnected" | tr ' ' '_' ))
DISCONNECTED=($( xrandr | grep -oE "^.+\sdisconnected" | tr ' ' '_' ))

echo "DISPLAYS:"
echo "========="
echo
echo "  - prim: $PRIMARY"
echo "  - conn: ${CONNECTED[@]}"
echo "  - disc: ${DISCONNECTED[@]}"
echo

disconnect()
{
    local keep_looping=true

    while $keep_looping
    do
        for display in "${DISCONNECTED[@]}"
        do
            echo "${display}" | cut -d '_' -f1
        done
        printf "turn off disconnected displays? (Y/n): "
        read conf

        if [[ -z $conf || $( echo $conf | tr [a-z] [A-Z] ) == 'Y' ]]
        then
            for display in ${DISCONNECTED[@]}
            do
                local output=$( cut -d '_' -f1 <<< $display )
                xrandr --output $output --off
            done
            keep_looping=false
        elif [[ $conf == [nN] ]]
        then
            keep_looping=false
        else
            echo
            echo "$conf is not a valid option"
            echo
        fi
    done
}

connect()
{
    if [[ ${#CONNECTED[@]} > 1 ]]
    then
        local keep_looping=true
        echo ${CONNECTED[@]} | tr ' ' '\r' | tr '_' '\t'
        for display in ${CONNECTED[@]}
        do
            local output=$( cut -d '_' -f1 <<< $display )
            local pos=''
            local of=''
            while $keep_looping
            do
                [[ $output == $PRIMARY ]] && break
                printf "Start $output on [right|left]: "
                read pos
                printf "of [default: $PRIMARY]: "
                read of
                [[ -z $of ]] && of=$PRIMARY

                if [[ $( grep -oE "right|left" <<< $pos ) &&
                      $( grep -oE "$of" <<< ${CONNECTED[@]} ) ]]
                then
                    xrandr --output $output --auto --$pos-of $of
                    keep_looping=false
                else
                    echo "Wrong options: $pos or $of"
                fi
            done
        done
    else
        echo "No extra monitors connected ..."
    fi
}

"$@"

