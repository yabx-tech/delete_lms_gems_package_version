# Delete LMS Gems Package Version

Github action to delete specific LMS gem's latest version which is already present in github packages.

## Inputs
### `package-name`
**Required** The name of the package to be deleted
### `organization-name`
**optional** The name of the organization if package belongs to organisation account
### `repo-name`
**optional** The name of the repo if package is in different repo
### `token`
**optional** Secret token if you don't want to use GITHUB_TOKEN

## Example usage


```
jobs:
  build:
    name: Build + Publish
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v2
    - name: Set up Ruby 2.6
      uses: actions/setup-ruby@v1
      with:
        version: 2.6.x
    - name: Delete LMS Gems Package Version
      uses: yabx-tech/delete_lms_gems_package_version@v1
      with:
        package-name: your-package-name
        organisation-name: your-organization-name
      env:
        GITHUB_TOKEN: ${{secrets.GITHUB_TOKEN}}
        OWNER: username
```
