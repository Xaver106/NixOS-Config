#! /usr/bin/env bash

backup_and_link() {
  local source_file=$(realpath --no-symlinks "$1")
  local target_file=$(realpath --no-symlinks "$2")
  local backup_file="${target_file}.bak"
  local target_dir=$(dirname "${target_file}")

  # Check if the source file exists
  if [ ! -f "${source_file}" ]; then
    echo "The source file ${source_file} does not exist."
    return 1
  fi

  # Ensure the target directory exists, create it if it doesn't
  if [ ! -d "${target_dir}" ]; then
    echo "The target directory ${target_dir} does not exist. Creating it now..."
    mkdir -p "${target_dir}"
  fi

  # Check if the target file is a symlink
  if [ -L "${target_file}" ]; then
    local current_source=$(realpath "${target_file}")
    if [ "${current_source}" = "${source_file}" ]; then
      echo "${target_file} is already a symbolic link to the correct source."
      return 0
    else
      echo "${target_file} is a symbolic link to a different source. It will be replaced."
      # Remove the incorrect symlink
      rm "${target_file}"
    fi
  fi

  # Check if the target file exists and is a regular file, then check for backup
  if [ -e "${target_file}" ]; then
    if [ -f "${backup_file}" ]; then
      echo "${backup_file} already exists. Remove it or rename it before running this script."
      return 1
    else
      mv "${target_file}" "${backup_file}"
      echo "Moved existing ${target_file} to ${backup_file}"
    fi
  fi

  # Create a new symlink to the correct source
  ln -s "${source_file}" "${target_file}"
  echo "Created a symbolic link for ${target_file}"
}

interactively_copy_if_different() {
  local source_file="$1"
  local target_file="$2"
  local target_dir

  # Check if the source file exists
  if [ ! -f "${source_file}" ]; then
    echo "The source file ${source_file} does not exist."
    return 1
  fi

  # Extract the directory part of the target path
  target_dir=$(dirname "${target_file}")

  # Ensure the target directory exists, create it if it doesn't
  if [ ! -d "${target_dir}" ]; then
    echo "The target directory ${target_dir} does not exist. Creating it now..."
    mkdir -p "${target_dir}"
    if [ $? -ne 0 ]; then
      echo "Failed to create the target directory. Check your permissions."
      return 1
    fi
  fi

  # If the target file does not exist, copy the source file to the target location immediately
  if [ ! -f "${target_file}" ]; then
    cp "${source_file}" "${target_file}"
    echo "Copied ${source_file} to ${target_file} because the target did not exist."
  elif ! cmp -s "${source_file}" "${target_file}"; then
    # Files exist and are different; ask user for copy direction or skipping
    echo "The file ${target_file} exists but is different from the source file."
    while true; do
      read -p "Do you want to overwrite the target with the source (S), overwrite the source with the target (T), or skip (X)? [S/T/X]: " stx
      case $stx in
      [Ss]*)
        cp "${source_file}" "${target_file}"
        echo "Copied ${source_file} to ${target_file}."
        break
        ;;
      [Tt]*)
        cp "${target_file}" "${source_file}"
        echo "Copied ${target_file} to ${source_file}."
        break
        ;;
      [Xx]*)
        echo "Skipping the copy operation."
        break
        ;;
      *) echo "Please answer S (source to target), T (target to source), or X (skip)." ;;
      esac
    done
  else
    # Files are the same, no copy needed
    echo "The target file ${target_file} already exists and is identical to the source file. No copy performed."
  fi
}

# User Gitconfig
backup_and_link "dotfiles/.gitconfig" "${HOME}/.gitconfig"

# Smartgit preferences and UI (Smartgit overrides instead of modifying)
interactively_copy_if_different "dotfiles/smartgit/ui-config.yml" "${HOME}/.config/smartgit/22.1/ui-config.yml"
