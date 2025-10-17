# gfams_project/settings/local.py
from .base import * # Import all settings from base.py

# In local.py, we typically want DEBUG to be True and specific ALLOWED_HOSTS
# These settings will override what's in base.py if defined in .env or hardcoded here.

# DEBUG = env('DEBUG', default=True) # Already handled in base.py to read from .env
#                                    # and default to False if not found.
#                                    # If DEBUG=True is in your .env, it will be True.

# ALLOWED_HOSTS = env.list('ALLOWED_HOSTS', default=['127.0.0.1', 'localhost'])
# This is also already configured in base.py to read from .env.

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