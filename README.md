# Merge Deploy Action

Every hour the `master` branch will be deployed into the `deploy` branch.

Should an error occur, we will notify slack.

## Installation

To enable the action simply create the `.github/workflows/merge-deploy.yml`
file with the following content:

```yml
name: 'Merge to deploy'

on:
  schedule:
    - cron: "0 * * * *"

jobs:
  merge-command:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout
      uses: actions/checkout@v1

    - name: Merge master into deploy
      uses: FlexMR/gh-actions-merge-deploy@master
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        SOURCE_BRANCH: master
        DESTINATION_BRANCH: deploy
        COMMIT_NAME: whoever
        COMMIT_EMAIL: whoever@whatever
```
