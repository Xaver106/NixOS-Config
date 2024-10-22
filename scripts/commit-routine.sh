#!/usr/bin/env bash

set -e  # Exit on any error

# Colors for better visibility
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
RESET=$(tput sgr0)

# Function for error messages
error() {
    echo "${RED}ERROR: $1${RESET}" >&2
    exit 1
}

# Function for info messages
info() {
    echo "${GREEN}INFO: $1${RESET}"
}

# Function for warnings
warn() {
    echo "${YELLOW}WARNING: $1${RESET}"
}

# Check if we're on master
if [[ "master" != $(git rev-parse --abbrev-ref HEAD) ]]; then
    error "Not on master branch"
fi

# Check if working directory is clean
if ! git diff --quiet HEAD; then
    warn "Working directory has uncommitted changes"
    info "Stashing current changes"
    git stash push -u -m "Temporary stash before rebuild" || error "Failed to stash changes"
    STASHED=true
else
    STASHED=false
fi

# Store the original commit hash
lastCommit=$(git rev-parse --short HEAD) || error "Failed to get commit hash"
parallelBranch="rebuilds-$lastCommit"

cleanup() {
    info "Cleaning up..."

    # Return to master if we're not already there
    current_branch=$(git rev-parse --abbrev-ref HEAD)
    if [[ "$current_branch" != "master" ]]; then
        git checkout master || warn "Failed to return to master"
    fi

    # Restore stashed changes if any
    if [[ "$STASHED" == true ]]; then
        info "Restoring stashed changes"
        git stash pop || warn "Failed to restore stashed changes"
    fi
}

# Set up trap to ensure cleanup runs even if script fails
trap cleanup EXIT

# Create or checkout the parallel branch
if ! git show-ref --verify --quiet refs/heads/$parallelBranch; then
    info "Creating and checking out new branch: $parallelBranch"
    git checkout -b $parallelBranch || error "Failed to create new branch"
else
    info "Branch exists, checking out: $parallelBranch"
    git checkout -f $parallelBranch || error "Failed to checkout existing branch"
fi

# Make and commit changes - including all new and tracked files for complete rebuild state
info "Adding and committing changes"
if git add .; then
    if ! git diff --cached --quiet; then
        git commit -m "Rebuild $(date '+%d.%m.%Y %H:%M:%S')" || error "Failed to commit changes"
    else
        warn "No changes to commit"
    fi
else
    error "Failed to add changes"
fi

# Return to master and merge
info "Returning to master"
git checkout master || error "Failed to checkout master"

info "Merging changes"
if ! git merge --no-edit --squash $parallelBranch; then
    error "Merge failed"
fi

info "Script completed successfully"
exit 0
