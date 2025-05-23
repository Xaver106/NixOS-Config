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

# Store the original branch name
original_branch=$(git rev-parse --abbrev-ref HEAD) || error "Failed to get current branch"
info "Current branch: $original_branch"

# Check if working directory is clean
if [[ -n "$(git status --porcelain)" ]]; then
    warn "Working directory has uncommitted changes"
    info "Stashing current changes"
    git stash push -u -m "Temporary stash" || error "Failed to stash changes"
else
    info "No changes. Exiting"
    exit 0
fi

# Store the original commit hash
lastCommit=$(git rev-parse --short HEAD) || error "Failed to get commit hash"
parallelBranch="rebuilds-$lastCommit"

cleanup() {
    info "Cleaning up..."

    # Return to original branch if we're not already there
    current_branch=$(git rev-parse --abbrev-ref HEAD)
    if [[ "$current_branch" != "$original_branch" ]]; then
        git checkout "$original_branch" || warn "Failed to return to $original_branch"
    fi

    # Restore stashed changes if any
    info "Restoring stashed changes"
    git stash pop || warn "Failed to restore stashed changes, they are still stashed!"
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

if ! git stash apply; then
    warn "Stash apply failed - forcing stashed changes"
    git checkout --theirs . || error "Failed to force stashed changes"
    git add . || error "Failed to add resolved changes"
fi

# Make and commit changes - including all new and tracked files for complete rebuild state
info "Adding and committing changes"
git add . || error "Failed to add changes"

if [[ -n "$(git status --porcelain)" ]]; then
    git commit -m "Rebuild $(date '+%d.%m.%Y %H:%M:%S')" || error "Failed to commit changes"
else
    warn "No changes to commit"
fi

# Return to original branch
info "Returning to $original_branch"
git checkout "$original_branch" || error "Failed to checkout $original_branch"

info "Script completed successfully"
exit 0
