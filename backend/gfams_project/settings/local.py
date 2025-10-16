# gfams_project/settings/local.py
from .base import *
from decouple import config, Csv
from dj_database_url import parse as db_url

DEBUG = config('DEBUG', default=True, cast=bool)

ALLOWED_HOSTS = config('ALLOWED_HOSTS', default='127.0.0.1,localhost', cast=Csv())

# Database configuration for local development
DATABASES = {
    'default': config(
        'DATABASE_URL',
        default='postgis://user:password@localhost:5432/gfams_db',
        cast=db_url
    )
}

# For local development, allow serving schema
SPECTACULAR_SETTINGS['SERVE_INCLUDE_SCHEMA'] = True