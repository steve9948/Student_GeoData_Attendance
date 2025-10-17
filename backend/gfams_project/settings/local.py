# gfams_project/settings/local.py
from .base import * # Import all settings from base.py

# For development, allow all hosts so you can connect from your mobile device.
# In production, this should be a specific list of your domain names.
ALLOWED_HOSTS = ['*']

# The DATABASES configuration from base.py (using env.db() and setting PostGIS ENGINE)
# is sufficient for local development. You do not need to redefine it here unless
# your local database setup specifically deviates from the DATABASE_URL in .env.

# We only need to specify local-specific overrides.
# For example, to ensure schema serving in local, which is False in base.py's default
SPECTACULAR_SETTINGS['SERVE_INCLUDE_SCHEMA'] = True

# Add any other local-only settings here.
# For example, if you want Django Debug Toolbar, it would go here.
# INSTALLED_APPS += [
#    'debug_toolbar',
# ]
# MIDDLEWARE += [
#    'debug_toolbar.middleware.DebugToolbarMiddleware',
# ]
# INTERNAL_IPS = ['127.0.0.1']
