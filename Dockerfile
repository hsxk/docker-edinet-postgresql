# 使用官方 PostgreSQL 镜像
FROM postgres:latest

# 安装 PostGIS 和依赖包
RUN apt-get update && \
    apt-get install -y postgis postgresql-$(postgres -V | awk '{print $3}' | cut -d '.' -f 1)-postgis-3 && \
    apt-get clean
    
# Run the command for new database
# CREATE EXTENSION IF NOT EXISTS postgis;
# CREATE EXTENSION IF NOT EXISTS pg_trgm;