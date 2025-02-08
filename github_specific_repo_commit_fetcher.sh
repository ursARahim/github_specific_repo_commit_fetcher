#!/bin/bash

REPOSITORY_NAME="moodle"
REPOSITORY_OWNER="moodle"
BRANCH_NAME="MOODLE_405_STABLE"

NUMBER_OF_COMMITS_TO_SHOW=${1:-5}

check_requirements() {
    if ! command -v curl &> /dev/null; then
        echo "Error: curl is not installed. Please install it."
        exit 1
    fi
    if ! command -v jq &> /dev/null; then
        echo "Error: jq is not installed. Please install it."
        exit 1
    fi
}

fetch_commits() {
    echo "Fetching last $NUMBER_OF_COMMITS_TO_SHOW commits from $REPOSITORY_NAME's $BRANCH_NAME branch"

    RESPONSE=$(curl -s "https://api.github.com/repos/$REPOSITORY_OWNER/$REPOSITORY_NAME/commits?sha=$BRANCH_NAME&per_page=$NUMBER_OF_COMMITS_TO_SHOW")

    if [ $? -ne 0 ]; then
        echo "Error: Failed to fetch commits"
        exit 1
    fi

    echo "$RESPONSE" | jq -r '.[] | "Commit Message: \(.commit.message)\nAuthor Name: \(.commit.author.name)\n"'
}

check_requirements
fetch_commits
