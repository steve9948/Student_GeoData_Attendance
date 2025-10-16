# gfams_project/settings/production.py
from .base import *
from decouple import config, Csv
from dj_database_url import parse as db_url

DEBUG = config('DEBUG', default=False, cast=bool)

ALLOWED_HOSTS = config('ALLOWED_HOSTS', cast=Csv())

# Database configuration for production
DATABASES = {
    'default': config(
        'DATABASE_URL',
        cast=db_url
    )
}

# Production specific security settings
SECURE_PROXY_SSL_HEADER = ('HTTP_X_FORWARDED_PROTO', 'https')
SECURE_SSL_REDIRECT = config('SECURE_SSL_REDIRECT', default=True, cast=bool)
SESSION_COOKIE_SECURE = config('SESSION_COOKIE_SECURE', default=True, cast=bool)
CSRF_COOKIE_SECURE = config('CSRF_COOKIE_SECURE', default=True, cast=bool)
X_FRAME_OPTIONS = 'DENY'

# Static files storage in production (e.g., S3 or Whitenoise)
# Will be configured later with actual deployment strategy
STATICFILES_STORAGE = 'whitenoise.storage.CompressedManifestStaticFilesStorage'

# Disable schema serving in production
SPECTACULAR_SETTINGS['SERVE_INCLUDE_SCHEMA'] = False