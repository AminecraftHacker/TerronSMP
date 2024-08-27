nb_present=false
for arg in "$@"
do
    if [ "$arg" == "--nb" ]; then
        nb_present=true
        echo "Backup is disabled!"
    fi
done

#!/bin/bash

java -Xms8G -Xmx8G --add-modules=jdk.incubator.vector -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -jar purpur-1.21-2284.jar --nogui

if ! $nb_present; then
	git add .
	git commit -m "$(date +"%d-%m-%y_%H-%M")"
	git push -u origin main
fi
