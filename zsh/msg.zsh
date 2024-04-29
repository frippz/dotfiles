# Function to print a message with a specific color, icon, and bold text
print_message() {
  local color="$1"
  local icon="$2"
  local message="$3"
  echo ""
  echo "\033[1;${color}m${icon} ${message}\033[0m"
}

# Function to print a "done" message
msg_done() {
  local message="$1"
  print_message "32" "✅" "$message"
}

# Function to print an "info" message
msg_info() {
  local message="$1"
  print_message "34" "ℹ️" "$message"
}

# Function to print a "fail" message
msg_fail() {
  local message="$1"
  print_message "31" "⛔️" "$message"
}

# Function to print a "warn" message
msg_warn() {
  local message="$1"
  print_message "33" "⚠️" "$message"
}
