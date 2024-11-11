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

# Default values
KEEP_BRANCHES=3
DRY_RUN=false
REBUILD_PREFIX="rebuilds-"

# Print usage
usage() {
    echo "Usage: $0 [-k number] [-n] [-h]"
    echo "  -k number : Keep this many most recent rebuild branches (default: 10, use 0 to delete all)"
    echo "  -n        : Dry run (don't actually delete branches)"
    echo "  -h        : Show this help message"
    exit 1
}

# Parse command line options
while getopts "k:nh" opt; do
    case $opt in
        k) KEEP_BRANCHES="$OPTARG"
           # Verify if KEEP_BRANCHES is a non-negative number
           if ! [[ "$KEEP_BRANCHES" =~ ^[0-9]+$ ]]; then
               error "Number of branches to keep must be a non-negative number"
           fi
           ;;
        n) DRY_RUN=true ;;
        h) usage ;;
        \?) usage ;;
    esac
done

# Function to delete branch
delete_branch() {
    local branch=$1

    if [ "$DRY_RUN" = true ]; then
        info "[DRY RUN] Would delete branch: $branch"
        return
    fi

    git branch -D "$branch" && info "Deleted branch: $branch" || warn "Failed to delete branch: $branch"
}

# Get all local rebuild branches sorted by last commit date (newest first)
mapfile -t rebuild_branches < <(git for-each-ref --sort='-committerdate' --format='%(refname:short)' refs/heads/ | \
    grep "^${REBUILD_PREFIX}" || true)

# Calculate how many branches to delete
TOTAL_BRANCHES=${#rebuild_branches[@]}
if [ "$TOTAL_BRANCHES" -eq 0 ]; then
    info "No rebuild branches found"
    exit 0
fi

if [ "$KEEP_BRANCHES" -eq 0 ]; then
    info "Found $TOTAL_BRANCHES rebuild branches, deleting all"
    for branch in "${rebuild_branches[@]}"; do
        delete_branch "$branch"
    done
elif [ "$TOTAL_BRANCHES" -gt "$KEEP_BRANCHES" ]; then
    TO_DELETE=$((TOTAL_BRANCHES - KEEP_BRANCHES))
    info "Found $TOTAL_BRANCHES rebuild branches, keeping $KEEP_BRANCHES, will delete $TO_DELETE"

    # Delete older branches (those after the KEEP_BRANCHES count)
    for ((i=KEEP_BRANCHES; i<TOTAL_BRANCHES; i++)); do
        delete_branch "${rebuild_branches[i]}"
    done
else
    info "Found $TOTAL_BRANCHES rebuild branches, which is <= $KEEP_BRANCHES (keep limit). No branches to delete."
fi

info "Rebuild branch cleanup completed"
