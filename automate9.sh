#!/bin/bash
array=(helloservice hiservice nameservice managerservice teamservice)
for service in "${array[@]}"
do
    COUNT=$(ps -ef | grep "$service" | grep -v grep | wc -l)
    MAX=2
    echo "$service"
    echo "$COUNT"
    if [ "$COUNT" -gt "$MAX" ]; then
        PROCS=$(ps -ef | grep "$service" | grep -v grep | awk '{print $2, $11, $12, $13}' | sort -k 4)
        JAR=$(echo "$PROCS" | awk -F"-Djar_name=| " '{print $5}')
        echo "$JAR"
        JAR_RUN=$(echo "$JAR" | sed 's/ /,/g')
        echo "$JAR_RUN"
        cd /apps/nnos/test/scripts
        ./mail.sh "$service" "$JAR_RUN" "$COUNT"
    fi
done

