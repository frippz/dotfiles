zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

# Check if Colima is running with the correct context
function _check_colima_status() {
  if ! command -v colima >/dev/null 2>&1; then
    return 1
  fi

  local colima_status
  colima_status=$(colima ls -j 2>/dev/null)
  if [[ $? -ne 0 ]]; then
    return 1
  fi

  # Check if Colima is running and using the default context
  if [[ $(echo "$colima_status" | jq -r '.status') == "Running" && $(echo "$colima_status" | jq -r '.context') == "default" ]]; then
    return 0
  fi

  return 1
}

# Only set environment variables if Colima is running with the correct context
if _check_colima_status; then
  export DOCKER_HOST="unix://${HOME}/.colima/default/docker.sock"
  export TESTCONTAINERS_HOST_OVERRIDE="$(colima ls -j | jq -r '.address')"
else
  unset DOCKER_HOST
  unset TESTCONTAINERS_HOST_OVERRIDE
fi
