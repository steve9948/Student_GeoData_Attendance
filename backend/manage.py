#!/usr/bin/env python
"""Django's command-line utility for administrative tasks."""
import os
import sys


def main():
    """Run administrative tasks."""
    # This line is crucial for development. It tells Django to use the local settings file.
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'gfams_project.settings.local')

    # This adds your 'apps' directory to Python's path.
    # It allows for cleaner imports, e.g., 'from users.models' instead of 'from apps.users.models'.
    sys.path.append(os.path.join(os.path.dirname(__file__), 'apps'))

    try:
        from django.core.management import execute_from_command_line
    except ImportError as exc:
        raise ImportError(
            "Couldn't import Django. Are you sure it's installed and "
            "available on your PYTHONPATH environment variable? Did you "
            "forget to activate a virtual environment?"
        ) from exc
    execute_from_command_line(sys.argv)


if __name__ == '__main__':
    main()
