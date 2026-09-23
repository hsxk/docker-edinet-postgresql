# Contributing

Changes should keep this image small, reproducible, and easy to verify.

## Before opening a pull request

Build locally:

```sh
docker build -t edinet-postgresql:local .
```

Boot PostgreSQL and verify both extensions can be created. Pull requests run the
same essential checks automatically.

## Dependency changes

- Keep the PostgreSQL major version explicit.
- Avoid unpinned GitHub Actions; actions in workflows should use immutable
  commit SHAs.
- Treat PostGIS/PostgreSQL upgrades as compatibility changes and verify both
  `linux/amd64` and `linux/arm64` publishing still works.

## Release model

`main` publishes the moving `latest` channel after validation. Version tags
publish semver tags. Never replace an existing version tag with a materially
different image.
