#!/bin/bash

# NOTE: you need to have installed
# 1. bash
# 2. jq (json query tool very useful if you are using a lot of json)
# 3. cloc (a tool to count lines of code)

# GitHub username
# NOTE: change this to be your username on GitHub
USERNAME="dattali18"

# Create a directory to store the cloned repositories
mkdir -p $USERNAME
cd $USERNAME

# Get all repositories for the user
REPOS=$(curl -s "https://api.github.com/users/$USERNAME/repos?per_page=100" | jq -r '.[].clone_url')

# Clone each repository
for REPO in $REPOS; do
	git clone $REPO
done

# Run cloc on all repositories and save the results to result.csv
cloc . --csv --out=result.csv

echo "Lines of code and programming languages statistics saved to result.csv"
