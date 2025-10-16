# Create your models here.
from django.contrib.auth.models import AbstractUser
from django.db import models
from django.utils.translation import gettext_lazy as _

class UserRole(models.TextChoices):
    ADMIN = 'admin', _('Admin')
    FACULTY = 'faculty', _('Faculty')
    STUDENT = 'student', _('Student')

class User(AbstractUser):
    # Add unique related_name for groups and user_permissions to avoid clashes
    # This is a common requirement when extending AbstractUser.
    groups = models.ManyToManyField(
        'auth.Group',
        verbose_name=_('groups'),
        blank=True,
        help_text=_('The groups this user belongs to. A user will get all permissions granted to each of their groups.'),
        related_name="custom_user_groups", # Unique related_name
        related_query_name="custom_user_group",
    )
    user_permissions = models.ManyToManyField(
        'auth.Permission',
        verbose_name=_('user permissions'),
        blank=True,
        help_text=_('Specific permissions for this user.'),
        related_name="custom_user_permissions", # Unique related_name
        related_query_name="custom_user_permission",
    )

    role = models.CharField(
        max_length=10,
        choices=UserRole.choices,
        default=UserRole.STUDENT,
        db_index=True # Index this for fast lookups by role
    )
    full_name = models.CharField(max_length=255, blank=True)

    def save(self, *args, **kwargs):
        # Automatically create the full_name from first and last names
        if not self.full_name and self.first_name and self.last_name:
            self.full_name = f"{self.first_name} {self.last_name}"
        super().save(*args, **kwargs)

    def __str__(self):
        return self.username

class StudentProfile(models.Model):
    user = models.OneToOneField(
        User,
        on_delete=models.CASCADE,
        primary_key=True, # Make the user the primary key for efficiency
        related_name='student_profile',
        limit_choices_to={'role': UserRole.STUDENT} # Ensure only students can have a profile
    )
    admission_number = models.CharField(
        max_length=20,
        unique=True,
        db_index=True # Index this field for fast lookups
    )
    # Potentially add a 'department' or 'program' field here if needed for filtering notifications
    # For now, we'll assume it might be on the User model or derived elsewhere.

    def __str__(self):
        return f"Student: {self.user.full_name} ({self.admission_number})"

    class Meta:
        verbose_name = _('Student Profile')
        verbose_name_plural = _('Student Profiles')
