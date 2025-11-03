#!/usr/bin/env bash
set -euo pipefail

# Requirements: bash, jq, cloc, curl, git

# GitHub username (can also pass as first argument)
USERNAME="${1:-dattali18}"

# Output file for cloc
OUT_FILE="result.csv"

# Only include these file extensions (no dots, comma-separated)
# Note: includes .cuda and maps it to CUDA via --force-lang
INCLUDE_EXTS="py,c,cpp,cuda,h,cuh,java,cs,r,js,ts,asm,swift,sh,css,html"

# Create a directory to store the cloned repositories
mkdir -p "$USERNAME"
cd "$USERNAME"

# Get up to 100 repositories for the user (public). For private repos, add an Authorization header.
REPOS=$(curl -s "https://api.github.com/users/$USERNAME/repos?per_page=100" | jq -r '.[].clone_url')

# Clone each repository (skip if it already exists locally)
for REPO in $REPOS; do
  NAME=$(basename "$REPO" .git)
  if [ -d "$NAME" ]; then
    echo "Skipping already cloned repo: $NAME"
  else
    git clone --quiet "$REPO"
  fi
done

# Run cloc on all repositories and save the results, restricted to selected extensions.
# --force-lang=CUDA,cuda ensures .cuda files are treated as CUDA.
cloc . \
  --csv \
  --out="$OUT_FILE" \
  --include-ext="$INCLUDE_EXTS" \
  --force-lang=CUDA,cuda

echo "Lines of code and programming languages statistics saved to $OUT_FILE"
echo "Filtered by extensions: $INCLUDE_EXTS"
