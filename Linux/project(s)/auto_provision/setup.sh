#!/bin/bash
# -----------------------------------------------------------------------------
# Script Name : setup.sh
# Description : DevOps provisioning script for EC2 (Ubuntu)
# Author      : Sandesh Nataraj
# Created On  : 2025-03-30
# -----------------------------------------------------------------------------

set -e  # Exit immediately on unhandled error
DRY_RUN=false  # Toggle for dry-run mode (simulates actions)

log_file_path="$HOME/provisioner"  # Directory for log file

# -----------------------------------------------------------------------------
# Logging Helpers
# -----------------------------------------------------------------------------

log_stmt() {
  local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
  local msg="[$timestamp] [+] $1"
  echo "$msg"
  [[ -n "$full_log_path" ]] && echo "$msg" >> "$full_log_path"
}

log_error() {
  local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
  local msg="[$timestamp] ❌ ERROR: $1"
  echo "$msg" >&2
  [[ -n "$full_log_path" ]] && echo "$msg" >> "$full_log_path"
  exit 1
}

create_log_file() {
  local log_file_name="$1"
  local new_log="$2"  # 'n' to overwrite; otherwise, append
  full_log_path="${log_file_path}/${log_file_name}.log"

  mkdir -p "$log_file_path" || log_error "Unable to create log directory"

  if [[ "$new_log" == "n" ]]; then
    > "$full_log_path" || log_error "Failed to overwrite log file"
  else
    touch "$full_log_path" || log_error "Failed to create log file"
  fi

  log_stmt "Log file created at: $full_log_path"
}

# Initialize default log
create_log_file "install" "e"

# -----------------------------------------------------------------------------
# Package Installation & Removal
# -----------------------------------------------------------------------------

install_package() {
  local pkg="$1"

  if [[ "$DRY_RUN" == true ]]; then
    log_stmt "DRY-RUN: Would install package '$pkg'"
    return
  fi

  if ! dpkg -l | grep -qw "$pkg"; then
    log_stmt "Installing package: $pkg"
    sudo apt update -y || log_error "apt update failed"
    sudo apt install -y "$pkg" || log_error "Installation failed for $pkg"
    local version=$("$pkg" --version 2>&1 || true)
    [[ -n "$version" ]] && log_stmt "$pkg version: $version"
  else
    log_stmt "Package '$pkg' already installed"
  fi
}

remove_package() {
  local pkg="$1"

  if [[ "$DRY_RUN" == true ]]; then
    log_stmt "DRY-RUN: Would remove package '$pkg'"
    return
  fi

  if dpkg -l | grep -qw "$pkg"; then
    log_stmt "Removing package: $pkg"
    sudo apt remove -y "$pkg" || log_error "Removal failed"
    sudo apt purge -y "$pkg"
    sudo apt autoremove -y
  else
    log_stmt "Package '$pkg' not installed"
  fi
}

# -----------------------------------------------------------------------------
# DevOps Tools Installer (Interactive Menu)
# -----------------------------------------------------------------------------

install_devops_tools() {
  echo "Select DevOps tools to install:"
  options=("Podman" "Java" "Git" "Pip" "Python3" "curl" "All" "None")

  select opt in "${options[@]}"; do
    case $opt in
      "Podman") install_package "podman"; break ;;
      "Java") install_package "default-jre"; break ;;
      "Git") install_package "git"; break ;;
      "Pip") install_package "python3-pip"; break ;;
      "Python3") install_package "python3"; break ;;
      "curl") install_package "curl"; break ;;
      "All")
        for tool in "${options[@]:0:6}"; do
          install_package "$tool"
        done
        break ;;
      "None") echo "No tools selected."; break ;;
      *) echo "Invalid selection: $REPLY";;
    esac
  done
}

# -----------------------------------------------------------------------------
# User & Group Management
# -----------------------------------------------------------------------------

create_group() {
  local group="$1"

  if [[ "$DRY_RUN" == true ]]; then
    log_stmt "DRY-RUN: Would create group '$group'"
    return
  fi

  if ! getent group "$group" > /dev/null; then
    sudo groupadd "$group" || log_error "Failed to create group: $group"
    log_stmt "Group created: $group"
  else
    log_stmt "Group '$group' already exists"
  fi
}

create_user() {
  local user="$1"

  if [[ "$DRY_RUN" == true ]]; then
    log_stmt "DRY-RUN: Would create user '$user'"
    return
  fi

  if ! id "$user" &>/dev/null; then
    sudo useradd -m -s /bin/bash -c "${user} DevOps User" "$user" || log_error "Failed to create user"
    sudo passwd "$user"
    log_stmt "User '$user' created"
  else
    log_stmt "User '$user' already exists"
  fi
}

add_to_group() {
  local user="$1"
  local group="$2"

  if [[ "$DRY_RUN" == true ]]; then
    log_stmt "DRY-RUN: Would add '$user' to group '$group'"
    return
  fi

  id "$user" &>/dev/null || log_error "User '$user' not found"
  getent group "$group" > /dev/null || log_error "Group '$group' not found"

  sudo usermod -aG "$group" "$user" || log_error "Failed to assign user to group"
  log_stmt "User '$user' added to group '$group'"
}

restrict_access_to_group() {
  local group="$1"
  local bin="$2"

  if [[ "$DRY_RUN" == true ]]; then
    log_stmt "DRY-RUN: Would restrict '$bin' to group '$group'"
    return
  fi

  getent group "$group" > /dev/null || log_error "Group '$group' does not exist"
  command -v "$bin" &>/dev/null || log_error "Binary '$bin' not found"

  local path
  path=$(which "$bin")

  sudo chgrp "$group" "$path" || log_error "Failed to set group for '$bin'"
  sudo chmod 750 "$path" || log_error "Failed to restrict access for '$bin'"
  log_stmt "Access to '$bin' restricted to group '$group'"
}

# -----------------------------------------------------------------------------
# Firewall Configuration
# -----------------------------------------------------------------------------

setup_firewall() {
  log_stmt "Setting up firewall with UFW"

  install_package "ufw"

  sudo ufw allow 22/tcp || log_error "Failed to allow SSH port"
  sudo ufw default deny incoming || log_error "Failed to set incoming default"
  sudo ufw default allow outgoing || log_error "Failed to set outgoing default"
}

enable_firewall() {
  log_stmt "Enabling UFW"
  sudo ufw --force enable || log_error "Failed to enable UFW"
}

disable_firewall() {
  log_stmt "Disabling UFW"
  sudo ufw --force disable || log_error "Failed to disable UFW"
}

check_firewall_status() {
  log_stmt "Checking UFW status"
  sudo ufw status numbered || log_error "Failed to get UFW status"
}

allow_port_open() {
  local port="$1"
  log_stmt "Allowing inbound traffic on port $port"
  sudo ufw allow "$port" || log_error "Failed to allow port $port"
}

block_port() {
  local port="$1"
  log_stmt "Blocking inbound traffic on port $port"
  sudo ufw deny "$port" || log_error "Failed to block port $port"
}

# -----------------------------------------------------------------------------
# CLI Argument Parser
# -----------------------------------------------------------------------------

while [[ "$#" -gt 0 ]]; do
  case "$1" in
    --allow-port) allow_port_open "$2"; shift 2 ;;
    --block-port) block_port "$2"; shift 2 ;;
    --firewall-status) check_firewall_status; shift ;;
    --enable-firewall) enable_firewall; shift ;;
    --disable-firewall) disable_firewall; shift ;;
    --setup-firewall) setup_firewall; shift ;;
    --add-user) create_user "$2"; shift 2 ;;
    --add-group) create_group "$2"; shift 2 ;;
    --add-user-to-group) add_to_group "$2" "$3"; shift 3 ;;
    --restrict) restrict_access_to_group "$2" "$3"; shift 3 ;;
    --install) install_package "$2"; shift 2 ;;
    --remove) remove_package "$2"; shift 2 ;;
    --install-devops) install_devops_tools; shift ;;
    --newlog) create_log_file "install" "n"; shift ;;
    --dry-run) DRY_RUN=true; log_stmt "Dry-run enabled"; shift ;;
    --help|-h)
      echo "Usage: ./setup.sh [OPTIONS]"
      echo "  --install <pkg>              Install a package"
      echo "  --remove <pkg>               Remove a package"
      echo "  --install-devops             Install common DevOps tools"
      echo "  --setup-firewall             Configure UFW (default deny)"
      echo "  --enable-firewall            Enable UFW"
      echo "  --disable-firewall           Disable UFW"
      echo "  --firewall-status            Show current UFW rules"
      echo "  --allow-port <port>          Allow a specific port"
      echo "  --block-port <port>          Block a specific port"
      echo "  --add-user <username>        Add a new system user"
      echo "  --add-group <groupname>      Add a new group"
      echo "  --add-user-to-group <user> <group>"
      echo "                               Add user to group"
      echo "  --restrict <group> <bin>     Restrict binary to group"
      echo "  --dry-run                    Preview actions only"
      echo "  --newlog                     Overwrite install log"
      echo "  --help, -h                   Show help message"
      exit 0 ;;
    *) log_stmt "Unknown flag: $1"; shift ;;
  esac
done
