#!/bin/bash

set -e

URI=https://api.github.com
API_HEADER="Accept: application/vnd.github.v3+json"
AUTH_HEADER="Authorization: token $GITHUB_TOKEN"
git config --global --add safe.directory /github/workspace

git remote set-url origin https://x-access-token:${!INPUT_PUSH_TOKEN}@github.com/$GITHUB_REPOSITORY.git
git config --global user.name "$COMMIT_NAME"
git config --global user.email "$COMMIT_EMAIL"

git fetch origin $SOURCE_BRANCH
git fetch origin $DESTINATION_BRANCH
git checkout -b $DESTINATION_BRANCH origin/$DESTINATION_BRANCH

echo "Trying to merge the '$SOURCE_BRANCH' branch ($(git log -1 --pretty=%H $SOURCE_BRANCH)) into the '$DESTINATION_BRANCH' branch ($(git log -1 --pretty=%H $DESTINATION_BRANCH))"

# Do the merge and push the branch
if git merge --no-edit -m "Merge branch '$SOURCE_BRANCH' into $DESTINATION_BRANCH" -m "Triggered by @$COMMENT_USER" origin/$SOURCE_BRANCH && git push origin $DESTINATION_BRANCH; then
  echo "Merge succeeded!"
  exit 0
fi;

echo "Merge failed!"
# TODO add slack integration
exit 1
