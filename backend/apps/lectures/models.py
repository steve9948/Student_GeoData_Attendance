from django.db import models
from django.conf import settings # Use settings for user model reference

# Note: We removed the direct import of the User model to prevent circular dependencies.

class Lecture(models.Model):
    title = models.CharField(max_length=200)
    unit_code = models.CharField(max_length=20, db_index=True)
    room = models.CharField(max_length=50)
    
    # Use a string reference to the user model to prevent circular import errors
    lecturer = models.ForeignKey(
        settings.AUTH_USER_MODEL, 
        on_delete=models.CASCADE, 
        limit_choices_to={'role': 'faculty'}, # Use the string 'faculty' as defined in User model
        related_name='lectures'
    )
    
    created_at = models.DateTimeField(auto_now_add=True, db_index=True)
    starts_at = models.DateTimeField()
    ends_at = models.DateTimeField()

    def __str__(self):
        return f"{self.unit_code}: {self.title} ({self.lecturer.username})"

    class Meta:
        ordering = ['-created_at']
