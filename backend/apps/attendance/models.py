from django.db import models

# Create your models here.
from django.contrib.gis.db import models # Use gis.db for PointField
from apps.users.models import User, UserRole
from apps.lectures.models import Lecture
from django.utils.translation import gettext_lazy as _

class Attendance(models.Model):
    student = models.ForeignKey(
        User,
        on_delete=models.CASCADE,
        related_name='attendance_records',
        db_index=True, # Index for fast lookups by student
        limit_choices_to={'role': UserRole.STUDENT} # Only students can have attendance records
    )
    lecture = models.ForeignKey(
        Lecture,
        on_delete=models.CASCADE,
        related_name='attendance_records',
        db_index=True # Index for fast lookups by lecture
    )
    # PointField for the student's location when attendance was marked.
    # PostGIS automatically creates a GiST index on geometry fields.
    location_at_marking = models.fields.PointField(srid=4326) # SRID 4326 for WGS84

    timestamp = models.DateTimeField(
        auto_now_add=True,
        db_index=True # Index for fast time-based queries
    )

    class Meta:
        unique_together = ('student', 'lecture') # Prevent a student from marking attendance multiple times for the same lecture
        ordering = ['-timestamp']
        verbose_name = _('Attendance')
        verbose_name_plural = _('Attendance Records')

    def __str__(self):
        return f"{self.student.full_name} - {self.lecture.title} ({self.timestamp.strftime('%Y-%m-%d %H:%M')})"
