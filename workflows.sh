#!/bin/bash

# Ensures all repos have the latest workflows.
# PRs are created for repos that are not up to date.

echo "Configuring workflows"
gh api https://api.github.com/orgs/basketry/repos | jq -r .[].name | while read repo; do
  # Add skipped repos here
  if [ $repo == '.github' ] || [ $repo == 'workflows' ] || [ $repo == 'vscode' ]; then continue; fi

  git clone "git@github.com:basketry/$repo.git" "clones/$repo" --depth 1 --quiet

  rm -rf "clones/$repo/.github/workflows"
  cp -r templates/workflows "clones/$repo/.github/workflows"

  cd "clones/$repo"
  if [[ `git status --porcelain` ]]; then
    git config user.name "`git -C ../.. config --get user.name`" --quiet
    git config user.email "`git -C ../.. config --get user.email`" --quiet
    git push origin --delete update-workflows --quiet
    git checkout -b update-workflows --quiet
    git add . 1>/dev/null 2>/dev/null
    git commit -m "chore: update workflows" --quiet
    git push origin update-workflows 1>/dev/null 2>/dev/null
    gh pr create --base main --head update-workflows --title "Update workflows" --body-file ../../templates/pr.md
  fi
  cd - > /dev/null
done

rm -rf clones
