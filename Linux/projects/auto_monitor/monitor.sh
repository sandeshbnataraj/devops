#!/bin/bash
# -----------------------------------------------------------------------------
# Script Name : setup.sh
# Description : DevOps monitoring script for EC2 (Ubuntu)
# Author      : Sandesh Nataraj
# Created On  : 2025-04-02
# -----------------------------------------------------------------------------
set -e  # Exit immediately on unhandled error
DRY_RUN=false  # Toggle for dry-run mode (simulates actions)

log_file_path="/home/ubuntu/monitor_health/logs"  # Directory for log file

# -----------------------------------------------------------------------------
# Logging Helpers
# -----------------------------------------------------------------------------
log_error() {
    local timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    local errmsg="[$timestamp] [ERROR] $1"
    echo "$errmsg" >&2
    [[ -n "$error_log" && -f "$error_log" ]] && echo "$errmsg" >> "$error_log"
    exit 1
}

log_stmt() {
    local timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    local msg="[$timestamp] [INFO] $1"
    echo "$msg"
    [[ -n "$monitor_log" && "$monitor_log" ]] && echo "$msg" >> "$monitor_log"
}

Initialize_log_files() {
    local timestamp=$(date "+%Y%m%d-%H%M%S")
    monitor_log="${log_file_path}/monitor-${timestamp}.log"
    error_log="${log_file_path}/errorlog-${timestamp}.log"

    mkdir -p "$log_file_path" || log_error "Failed to create log directory: $log_file_path"
    touch "$monitor_log" || log_error "Failed to create Monitor Log: $monitor_log"
    touch "$error_log" || log_error "Failed to create Error Log: $error_log"
}
Initialize_log_files

clear_logs() {
    rm -rf "$log_file_path" || log_error "Failed to remove logs"
    log_stmt "Log directory cleared: $log_file_path"
}

# -----------------------------------------------------------------------------
# System health details
# -----------------------------------------------------------------------------
sys_health_detail() {
    log_stmt "===== SYSTEM REPORT for $(date "+%F %H:%M:%S") ====="

    log_stmt "===== Disk usage ====="
    df -hT || log_error "Failed to get disk usage"

    log_stmt "===== Memory usage ====="
    free -ht || log_error "Failed to get memory usage"

    log_stmt "===== CPU usage ====="
    uptime || log_error "Failed to get CPU usage"

    log_stmt "===== User(s) Info ====="
    who || log_error "Failed to get User(s) Info"

    log_stmt "===== SSHD STATUS ====="
    systemctl is-active sshd || true

    log_stmt "===== CROND STATUS ====="
    systemctl is-active crond || true

    log_stmt "===== END OF SYSTEM REPORT ====="
}

users_count() {
    echo "$(who | wc -l)"
}

disk_usage() {
    local highest=$(df -hT | awk '$2 != "tmpfs" && $2 != "vfat" {print $(NF-1)}' | tr -d '%' | sort -nr | head -1) || log_error "Failed to get Disk Usage"
    if [[ -z "$highest" || ! "$highest" =~ ^[0-9]+$ ]]; then
        log_error "Disk usage value invalid or missing: '$highest'"
    fi
    echo "$highest"
}

mem_usage() {
    local freemem=$(free -m | awk '/Mem:/ {print $7}')  # available memory
    local total=$(free -m | awk '/Mem:/ {print $2}')

    if [[ -z "$freemem" || ! "$freemem" =~ ^[0-9]+$ ]]; then
        log_error "Memory usage value invalid or missing: '$freemem'"
    fi
    if [[ -z "$total" || ! "$total" =~ ^[0-9]+$ ]]; then
        log_error "Memory usage value invalid or missing: '$total'"
    fi

    local availper=$(( 100 * freemem / total ))
    echo "$availper"
}

cpu_usage() {
    local load=$(uptime | awk -F 'load average: ' '{print $2}' | cut -d',' -f1)
    local core=$(nproc)
    local remload=$(echo "$core - $load" | bc -l)
    echo "$remload $load"
}

alert_sys_health() {
    local high=$(disk_usage)
    if (( high >= 80 )); then
        log_stmt "===== Disk Usage Alert ====="
        log_stmt "WARNING! Usage higher than '$high'%"
    fi

    local avail=$(mem_usage)
    if (( avail <= 20 )); then
        log_stmt "===== Memory Usage Alert ====="
        log_stmt "WARNING! Available Memory less than '$avail'%"
    fi

    read reml loadavg <<< "$(cpu_usage)"
    if (( $(echo "$reml <= 0" | bc -l) )); then
        log_stmt "===== CPU Usage Alert ====="
        log_stmt "WARNING! High CPU Load Average per minute: '$loadavg'"
    fi
}

sys_health_summary() {
    log_stmt "===== SYSTEM SUMMARY REPORT for $(date "+%F %H:%M:%S") ====="
    log_stmt "--- Disk usage: '$(disk_usage)'% ---"
    log_stmt "--- Available Memory: '$(mem_usage)'% ---"
    cpuu=($(cpu_usage))
    log_stmt "--- CPU Load Per minute: '${cpuu[1]}' ---"
    log_stmt "--- Number of Users logged in: '$(users_count)' ---"
    log_stmt "--- SSHD status: '$(systemctl is-active sshd)' ---"
    log_stmt "--- CROND status: '$(systemctl is-active crond)' ---"
    log_stmt "===== END OF SYSTEM SUMMARY REPORT ====="
}

daemon_run() {
    (crontab -l 2>/dev/null | grep -v "monitor.sh" | crontab -) || log_error "Failed to remove previous Cronjob"

    local cronjob="*/${1} * * * * /home/ubuntu/monitor_health/monitor.sh --summary --alert >> /home/ubuntu/monitor_health/cron.log"
    log_stmt "Setting cron job: $cronjob"
    (crontab -l 2>/dev/null; echo "$cronjob") | crontab - || log_error "Failed to add cron job"
    log_stmt "Cron job added successfully"
}

stop_daemon() {
    local cronj=$(crontab -l 2>/dev/null | grep "monitor.sh")
    (crontab -l 2>/dev/null | grep -v "monitor.sh" | crontab -) || log_error "Failed to remove Cronjob"
    if [[ -z "$cronj" ]]; then
        log_stmt "No cron jobs found to remove"
    else
        log_stmt "Removed cron job: '$cronj'"
    fi
}

print_help() {
    echo "\nUsage: $0 [OPTIONS]"
    echo "Options:"
    echo "  --check-health       Run a full system health check"
    echo "  --summary            Print a summarized system health report"
    echo "  --alert              Trigger alert if any resource thresholds are crossed"
    echo "  --newlog             Clear existing log directory"
    echo "  --cron-run <min>     Set up cron to run every <min> minutes"
    echo "  --stop-cron          Stop the monitoring cron job"
    echo "  -h, --help           Show this help message"
    echo
}

while [[ "$#" -gt 0 ]]; do
    case "$1" in
        --check-health) sys_health_detail; shift ;;
        --alert) alert_sys_health; shift ;;
        --summary) sys_health_summary; shift ;;
        --newlog) clear_logs; shift ;;
        --cron-run) daemon_run "$2"; shift 2 ;;
        --stop-cron) stop_daemon; shift ;;
        -h|--help) print_help; exit 0 ;;
        *) echo "Unknown flag: '$1'"; print_help; exit 1 ;;
    esac
done