from django.apps import AppConfig


class LecturesConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'apps.lectures' # Match the path in INSTALLED_APPS
