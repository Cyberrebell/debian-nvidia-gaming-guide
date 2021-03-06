#!/bin/bash

# temperature the GPU should have
target_temperature=65

# how much may the temperature vary from target
target_temperature_range=2

# interval for checking temperature in sec
interval=20

# speed adjustment interval
adjustment_rate=2

min_fanspeed=20

sleep 20

# overclocking clock
#nvidia-settings -c :0 -a '[gpu:0]/GPUGraphicsClockOffset[3]=140'

# overclocking memory
#nvidia-settings -c :0 -a '[gpu:0]/GPUMemoryTransferRateOffset[3]=400'

while true
do
	current_temperature=`nvidia-settings -t -c :0 -q [GPU:0]/GPUCoreTemp`
	current_fanspeed=`nvidia-settings -t -c :0 -q [fan:0]/GPUCurrentFanSpeed`
	current_interval=$interval
		
	if [ $current_temperature -gt `expr $target_temperature + $target_temperature_range` ]; then
		current_fanspeed=`expr $current_fanspeed + $adjustment_rate`
		nvidia-settings -c :0 -a [gpu:0]/GPUFanControlState=1 -a [fan:0]/GPUTargetFanSpeed=$current_fanspeed
		current_interval=$adjustment_rate
	else
		if [ $current_temperature -lt `expr $target_temperature - $target_temperature_range` ]; then
			if [ $current_fanspeed -gt `expr $min_fanspeed` ]; then
				current_fanspeed=`expr $current_fanspeed - $adjustment_rate`
				nvidia-settings -c :0 -a [gpu:0]/GPUFanControlState=1 -a [fan:0]/GPUTargetFanSpeed=$current_fanspeed
				current_interval=$adjustment_rate
			fi
		fi
	fi
	
	sleep $current_interval
done
