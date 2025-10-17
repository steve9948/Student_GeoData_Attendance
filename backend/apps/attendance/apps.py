from django.apps import AppConfig


class AttendanceConfig(AppCofig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'apps.attendance' # Match the path in INSTALLED_APPS
