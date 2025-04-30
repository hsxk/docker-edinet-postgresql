# EDINET Database
This repository contains a Dockerfile to build an EDINET database service. The resulting image is based on PostgreSQL with PostGIS and pg_trgm extensions, designed for storing and processing financial data from the EDINET system (Electronic Disclosure for Investors' NETwork) in Japan.

## Features
- Based on latest PostgreSQL
- Integrated PostGIS spatial data extension
- Support for pg_trgm text search extension
- Multi-architecture support: linux/amd64, linux/arm64
- Automated database initialization
- Optimized configuration for financial data storage
## Build and Run
To build the Docker image locally, use the following command:

sh

运行

Open Folder

1

docker build -t edinet-db .

To run the container based on the built image, use the following command:

sh

运行

Open Folder

1

docker run -d --name

edinet-db-service -e

POSTGRES_PASSWORD=your_password -p

5432:5432 hsxk/edinet-db

You can also pull the pre-built image directly from Docker Hub:

sh

运行

Open Folder

1

2

docker pull hsxk/edinet-db

docker run -d --name

edinet-db-service -e

POSTGRES_PASSWORD=your_password -p

5432:5432 hsxk/edinet-db

## Configuration
The container is configured with:

- PostGIS extension for geospatial data processing
- pg_trgm extension for text similarity search and indexing
- Automatic initialization scripts to ensure extensions are available in all databases
- Optimized parameters for financial data processing
## Environment Variables
You can customize the database configuration with the following environment variables:

- POSTGRES_PASSWORD : (Required) PostgreSQL superuser password
- POSTGRES_USER : (Optional) PostgreSQL superuser name (default: postgres)
- POSTGRES_DB : (Optional) Default database name (default: postgres)
- PGDATA : (Optional) Data directory location (default: /var/lib/postgresql/data)
## Data Persistence
To ensure data persistence, it's recommended to mount a volume to the container's data directory:

sh

运行

Open Folder

1

2

3

4

docker run -d --name

edinet-db-service \

-e

POSTGRES_PASSWORD=your_password \

-v edinet_db_data:/var/lib/

postgresql/data \

-p 5432:5432 hsxk/edinet-db

## Contributing
If you have any suggestions, improvements, or issues, feel free to create an issue or pull request in the GitHub repository.

## License
This project is licensed under the GPLv3 License.