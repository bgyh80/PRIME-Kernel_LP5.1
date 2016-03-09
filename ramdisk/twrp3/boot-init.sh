#!/sbin/busybox sh

alias bb=/sbin/busybox

# Configure cafactive
echo cafactive > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo cafactive > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
echo 20000 > /sys/devices/system/cpu/cpu0/cpufreq/cafactive/timer_rate
echo 20000 > /sys/devices/system/cpu/cpu0/cpufreq/cafactive/timer_slack
echo 40000 > /sys/devices/system/cpu/cpu0/cpufreq/cafactive/min_sample_time
echo 900000 > /sys/devices/system/cpu/cpu0/cpufreq/cafactive/hispeed_freq
echo 85 > /sys/devices/system/cpu/cpu0/cpufreq/cafactive/go_hispeed_load
echo 75 > /sys/devices/system/cpu/cpu0/cpufreq/cafactive/target_loads
echo 19000 > /sys/devices/system/cpu/cpu0/cpufreq/cafactive/above_hispeed_delay
echo 40000 > /sys/devices/system/cpu/cpu0/cpufreq/cafactive/boostpulse_duration
echo 100000 > /sys/devices/system/cpu/cpu0/cpufreq/cafactive/max_freq_hysteresis
echo 20000 > /sys/devices/system/cpu/cpu4/cpufreq/cafactive/timer_rate
echo 20000 > /sys/devices/system/cpu/cpu4/cpufreq/cafactive/timer_slack
echo 40000 > /sys/devices/system/cpu/cpu4/cpufreq/cafactive/min_sample_time
echo 1200000 > /sys/devices/system/cpu/cpu4/cpufreq/cafactive/hispeed_freq
echo 89 > /sys/devices/system/cpu/cpu4/cpufreq/cafactive/go_hispeed_load
echo "65 1500000:75" > /sys/devices/system/cpu/cpu4/cpufreq/cafactive/target_loads
echo "59000 1300000:39000 1700000:19000" > /sys/devices/system/cpu/cpu4/cpufreq/cafactive/above_hispeed_delay
echo 40000 > /sys/devices/system/cpu/cpu4/cpufreq/cafactive/boostpulse_duration
echo 100000 > /sys/devices/system/cpu/cpu0/cpufreq/cafactive/max_freq_hysteresis
echo 100000 > /sys/devices/system/cpu/cpu4/cpufreq/cafactive/max_freq_hysteresis

# io_is_busy
echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/cafactive/io_is_busy
echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/cafactive/io_is_busy
echo 1 > /sys/devices/virtual/sec/sec_slow/io_is_busy

# fix some kernel value

for i in /sys/block/*/queue/add_random; do echo 0 > $i; done
for i in /sys/block/*/queue/rq_affinity; do echo 2 > $i; done

echo N > /sys/module/mmc_core/parameters/use_spi_crc
echo 0 > /sys/kernel/dyn_fsync/Dyn_fsync_active
echo 1 > /proc/sys/vm/dynamic_dirty_writeback
echo 1 > /sys/kernel/logger_mode/logger_mode
echo 400000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo 1300000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
echo 700000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
echo 1900000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq

