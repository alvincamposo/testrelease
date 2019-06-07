libdir="$(dirname "${BASH_SOURCE[0]}")"

# config

load_config() {
  # shellcheck source=../release_config.env
  . "${libdir}/../release_config.env"
}


# typography

CYAN="$(tput setaf 6)"
NORMAL="$(tput sgr0)"


# process

die() {
  local message="$1"
  local exit_status="${2:-1}"

  echo "$message" >&2
  exit "$exit_status"
}

step() {
  local message="$1"

  echo ''
  echo -e "$message"
}

step_eval() {
  local command=( "$@" )

  echo '>' "${command[@]}"
  command "${command[@]}"
}

step_eval_and_redirect() {
  local filename="$1"
  shift
  local command=( "$@" )

  echo '>' "${command[@]}" ">${filename}"
  command "${command[@]}" >"$filename"
}
