from django.apps import AppConfig


class AttendanceConfig(AppConfig): # Corrected from AppCofig
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'apps.attendance'
