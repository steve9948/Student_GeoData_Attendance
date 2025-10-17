from django.apps import AppConfig


class CampusesConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'apps.campuses' # Match the path in INSTALLED_APPS
