#!/bin/bash

NO_PROXY=""
count=0
while read line
do
        ip=`awk '{print $1}' <<<$line`
        if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
                count=$(( $count + 1 ))
                if [ $count -eq 1 ]; then
                        if [ -z $NO_PROXY ]; then
                                NO_PROXY=$ip
                        fi
                elif [ $count -gt 1 ]; then
                        #echo "No_proxy=$NO_PROXY"
                        NO_PROXY+=":"$ip
                fi
        fi
done < /etc/hosts
echo "no_proxy=$NO_PROXY"
#set environment variable for no_proxy
export no_proxy=$NO_PROXY