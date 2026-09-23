# EDINET PostgreSQL

[![Docker Build](https://github.com/hsxk/docker-edinet-postgresql/actions/workflows/docker-build.yml/badge.svg?branch=main)](https://github.com/hsxk/docker-edinet-postgresql/actions/workflows/docker-build.yml)
[![Docker Pulls](https://img.shields.io/docker/pulls/hsxk/edinet-postgresql)](https://hub.docker.com/r/hsxk/edinet-postgresql)
[![License: GPL-3.0](https://img.shields.io/badge/license-GPL--3.0-blue.svg)](./LICENSE)

A PostgreSQL 17 image for EDINET-oriented data workloads with PostGIS installed
and PostgreSQL's built-in `pg_trgm` extension available.

Published image: [`hsxk/edinet-postgresql`](https://hub.docker.com/r/hsxk/edinet-postgresql)

## What is included

- PostgreSQL 17
- PostGIS 3 packages for PostgreSQL 17
- `pg_trgm` support from PostgreSQL contrib
- `linux/amd64` and `linux/arm64` published images
- CI validation that boots PostgreSQL and creates both `postgis` and
  `pg_trgm` before an image is published
- Trivy HIGH/CRITICAL vulnerability gate
- SBOM and provenance on published multi-arch images

The image **installs** PostGIS, but it does not automatically enable extensions
inside every database. Enable the extensions in each database that needs them:

```sql
CREATE EXTENSION IF NOT EXISTS postgis;
CREATE EXTENSION IF NOT EXISTS pg_trgm;
```

## Pull and run

```sh
docker pull hsxk/edinet-postgresql:latest

docker run -d \
  --name edinet-postgresql \
  -e POSTGRES_PASSWORD=change-me \
  -e POSTGRES_DB=edinet \
  -p 5432:5432 \
  -v edinet_postgres_data:/var/lib/postgresql/data \
  hsxk/edinet-postgresql:latest
```

For production, pin an explicit version/digest from Docker Hub instead of
depending indefinitely on the moving `latest` tag.

## Build locally

```sh
docker build -t edinet-postgresql:local .
```

Then verify the extensions:

```sh
docker run -d --rm \
  --name edinet-postgresql-test \
  -e POSTGRES_PASSWORD=test-password \
  -e POSTGRES_DB=edinet_test \
  edinet-postgresql:local

docker exec edinet-postgresql-test \
  psql -U postgres -d edinet_test -c 'CREATE EXTENSION postgis;'

docker exec edinet-postgresql-test \
  psql -U postgres -d edinet_test -c 'CREATE EXTENSION pg_trgm;'
```

## Environment variables

This image inherits the standard PostgreSQL Docker image configuration,
including:

- `POSTGRES_PASSWORD` — required unless another supported authentication
  strategy is intentionally configured
- `POSTGRES_USER` — defaults to `postgres`
- `POSTGRES_DB` — defaults to the value of `POSTGRES_USER`
- `PGDATA` — PostgreSQL data directory

Refer to the official PostgreSQL image documentation for the complete
initialization contract.

## Persistence

Mount a named volume or durable host path at:

```text
/var/lib/postgresql/data
```

Example:

```sh
docker volume create edinet_postgres_data
```

Do not expose PostgreSQL directly to the public internet unless you have a
deliberate network and authentication design.

## CI and releases

Pull requests and `main` pushes build and boot-test the image. CI verifies
that PostgreSQL accepts connections and that both PostGIS and `pg_trgm` can be
created successfully. Trivy fails the build on fixable HIGH/CRITICAL findings.

A successful push to `main` publishes `latest` plus a commit-SHA tag. A
version tag such as `v17.1.0` publishes semver tags. Published images are
multi-architecture and include provenance and SBOM attestations.

GitHub Actions are pinned to immutable commit SHAs; Dependabot checks those pins
weekly.

## Contributing and security

See [CONTRIBUTING.md](./CONTRIBUTING.md) before proposing changes and
[SECURITY.md](./SECURITY.md) before reporting a vulnerability.

## License

GPL-3.0. See [LICENSE](./LICENSE).
