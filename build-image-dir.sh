#!/bin/bash

STATE_NO_CHANGES=0
STATE_CHANGED=1
STATE_FIRST_RUN=2

function dir_changed() {
  local cache_dir=$1
  local src_dir=$2

  # Replace '/' with '--' in the path
  local tag=$(echo $src_dir | sed 's/\//\-\-/g')
  local last_state="$cache_dir/$tag.last"
  local curr_state="$cache_dir/$tag.current"

  mkdir -p "$cache_dir"

  find $src_dir -type f \( -exec sha1sum "$PWD"/{} \; \) > "$curr_state"

  if [[ ! -e "$last_state" ]]; then
    # We don't have previous state
    export has_changes=$STATE_FIRST_RUN
  elif [[ ! -z $(diff $last_state $curr_state) ]]; then
    # State has changed since previous run
    export has_changes=$STATE_CHANGED
  else
    # No changes since previous run
    export has_changes=$STATE_NO_CHANGES
  fi

  if [[ $has_changes -ne $STATE_NO_CHANGES ]]; then
    mv "$curr_state" "$last_state"
  else
    rm "$curr_state"
  fi

  echo $has_changes
  return $has_changes
}

function build_image() {
  local tag=$1
  local src_dir=$2

  cd "$src_dir"
  echo -e "-- \x1b[32mBuilding \x1b[35m$tag\x1b[0m"
  docker build -t $tag .
  echo -e "-- \x1b[32mPushing \x1b[35m$tag\x1b[0m"
  docker push $tag
}


cache_dir=$1
tag=$2
src_dir=$3
has_changes=$(dir_changed "$cache_dir" "$src_dir")

if [[ $has_changes -ne 0 ]]; then
  build_image "$tag" "$src_dir"
else
  echo -e "-- \x1b[32mNo changes in \x1b[35m$tag\x1b[32m, skipping...\x1b[0m"
fi
