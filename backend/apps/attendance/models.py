from django.contrib.gis.db import models
from django.conf import settings # Use settings for user model reference
from django.utils.translation import gettext_lazy as _

class Attendance(models.Model):
    """
    Model to store attendance records for students in a specific lecture.
    Includes geospatial data for location verification.
    """

    # Use a string reference 'users.User' to prevent circular import issues
    student = models.ForeignKey(
        settings.AUTH_USER_MODEL, 
        on_delete=models.CASCADE, 
        related_name='attendance_records',
        db_index=True
    )
    
    # Use a string reference 'lectures.Lecture'
    lecture = models.ForeignKey(
        'lectures.Lecture',
        on_delete=models.CASCADE, 
        related_name='attendance',
        db_index=True
    )
    
    timestamp = models.DateTimeField(auto_now_add=True, db_index=True)
    
    # The exact location where attendance was marked.
    # SRID 4326 is the standard for GPS coordinates (WGS 84).
    location_at_marking = models.PointField(srid=4326)
    
    class MarkedByChoices(models.TextChoices):
        AUTO = 'auto', _('Automatic')
        MANUAL = 'manual', _('Manual')

    marked_by = models.CharField(
        max_length=10,
        choices=MarkedByChoices.choices,
        default=MarkedByChoices.AUTO
    )

    def __str__(self):
        return f"{self.student.username} - {self.lecture.unit_code} at {self.timestamp.strftime('%Y-%m-%d %H:%M')}"

    class Meta:
        ordering = ['-timestamp']
        # Prevents a student from being marked present multiple times for the same lecture.
        unique_together = ('student', 'lecture')
