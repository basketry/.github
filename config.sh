#!/bin/bash

# configures repo settings and branch protections for all repos

echo "Configuring repos"
gh api https://api.github.com/orgs/basketry/repos | jq -r .[].name | while read repo; do
  if [ $repo == 'basketry' ]; then wiki=true; else wiki=false; fi
  gh api -X PUT "https://api.github.com/repos/basketry/$repo/branches/main/protection" --input branch-protections.json --silent
  gh repo edit "basketry/$repo" \
    --enable-discussions=false \
    --enable-issues=true \
    --enable-projects=false \
    --enable-wiki=$wiki \
    --enable-merge-commit=false \
    --enable-squash-merge=false \
    --enable-rebase-merge \
    --delete-branch-on-merge \
    --template=false
done
echo "done"
