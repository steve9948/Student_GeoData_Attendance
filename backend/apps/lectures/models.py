from django.db import models

# Create your models here.
from users.models import User, UserRole # Import our custom User model
from django.utils.translation import gettext_lazy as _

class Lecture(models.Model):
    title = models.CharField(max_length=255)
    description = models.TextField(blank=True)
    lecturer = models.ForeignKey(
        User,
        on_delete=models.PROTECT, # Prevent deleting a lecturer with active lectures
        related_name='lectures_taught',
        db_index=True, # Index this field for fast lookups by lecturer
        limit_choices_to={'role': UserRole.FACULTY} # Only faculty can be lecturers
    )
    start_time = models.DateTimeField()
    end_time = models.DateTimeField()
    # Location where the lecture was created (e.g., inside a campus)
    # Not necessarily the exact attendance location, but useful for context.
    # We won't require a spatial index here unless we plan to do spatial queries directly on this field
    # in a way that differs from the attendance location.
    # For now, a regular PointField is sufficient if it's just for storage.
    # If we need spatial queries for lecture location too, make it a models.PointField with srid=4326.
    # For simplicity, let's keep it as is, or remove it if not strictly needed for this model.
    # For this project, let's assume `location_at_marking` in Attendance is the primary geospatial point.
    # We can add `lecture_location` if there's a requirement to define a lecture's fixed physical location.
    # For now, let's omit it from Lecture model, as the prompt specifies `location_at_marking` in Attendance.

    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ['-start_time']
        verbose_name = _('Lecture')
        verbose_name_plural = _('Lectures')

    def __str__(self):
        return f"{self.title} by {self.lecturer.full_name}"
