# Secrets Scanner action

This action scans git repos using awslabs/git-secrets.

## Example usage
```
steps:
      - uses: actions/checkout@v2
      - uses: kams-mash/gh-secrets-scanner-action@master
```