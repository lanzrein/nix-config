#!/bin/bash

#!/bin/bash

# Get memory stats
MEM_INFO=$(vm_stat)
MEM_FREE=$(echo "$MEM_INFO" | grep "Pages free" | awk '{print $3}' | sed 's/\.//')
MEM_INACTIVE=$(echo "$MEM_INFO" | grep "Pages inactive" | awk '{print $3}' | sed 's/\.//')
MEM_SPECULATIVE=$(echo "$MEM_INFO" | grep "Pages speculative" | awk '{print $3}' | sed 's/\.//')
MEM_WIRED=$(echo "$MEM_INFO" | grep "Pages wired down" | awk '{print $4}' | sed 's/\.//')
MEM_ACTIVE=$(echo "$MEM_INFO" | grep "Pages active" | awk '{print $3}' | sed 's/\.//')
MEM_COMPRESSED=$(echo "$MEM_INFO" | grep "Pages occupied by compressor" | awk '{print $5}' | sed 's/\.//')

# Calculate total memory
MEM_TOTAL=$((MEM_FREE + MEM_INACTIVE + MEM_ACTIVE + MEM_WIRED + MEM_COMPRESSED + MEM_SPECULATIVE))

# Calculate used memory percentage
MEM_USED=$((MEM_TOTAL - MEM_FREE - MEM_SPECULATIVE - MEM_INACTIVE))
MEM_PERCENT=$(echo "scale=0; ($MEM_USED * 100) / $MEM_TOTAL" | bc)

CORE_COUNT=$(sysctl -n machdep.cpu.thread_count)
CPU_INFO=$(ps -eo pcpu,user)
CPU_SYS=$(echo "$CPU_INFO" | grep -v $(whoami) | sed "s/[^ 0-9\.]//g" | awk "{sum+=\$1} END {print sum/(100.0 * $CORE_COUNT)}")
CPU_USER=$(echo "$CPU_INFO" | grep $(whoami) | sed "s/[^ 0-9\.]//g" | awk "{sum+=\$1} END {print sum/(100.0 * $CORE_COUNT)}")

CPU_PERCENT="$(echo "$CPU_SYS $CPU_USER" | awk '{printf "%.0f\n", ($1 + $2)*100}')"

sketchybar --set $NAME label=" $MEM_PERCENT% /  $CPU_PERCENT%"