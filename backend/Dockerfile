# Stage 1: Builder
FROM python:3.11-slim-bullseye AS builder

WORKDIR /app

# Install system dependencies required for PostGIS and psycopg2
# gdal-bin, libgdal-dev, postgis (for postgis_restore), build-essential (for psycopg2-binary)
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        libgdal-dev \
        gdal-bin \
    && rm -rf /var/lib/apt/lists/*

# Copy only requirements first to leverage Docker cache
COPY requirements/base.txt requirements/local.txt requirements/prod.txt ./requirements/

# Install production dependencies
RUN pip install --no-cache-dir -r requirements/prod.txt

# Stage 2: Runner
FROM python:3.11-slim-bullseye AS runner

WORKDIR /app

# Install system dependencies required for PostGIS (runtime)
# gdal-bin, libgdal-dev for PostGIS spatial operations
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        libgdal-dev \
        gdal-bin \
    && rm -rf /var/lib/apt/lists/*

# Copy installed packages from builder
COPY --from=builder /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin

# Copy the rest of the application code
COPY . .

# Set environment variables for Gunicorn
ENV PYTHONUNBUFFERED 1
ENV DJANGO_SETTINGS_MODULE gfams_project.settings.production # Use production settings by default

# Expose the port Gunicorn will run on
EXPOSE 8000

# Command to run the application using Gunicorn
# This command will be overridden by docker-compose for different services
CMD ["gunicorn", "gfams_project.wsgi:application", "--bind", "0.0.0.0:8000"]