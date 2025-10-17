from django.contrib import admin
from .models import Lecture

@admin.register(Lecture)
class LectureAdmin(admin.ModelAdmin):
    """Admin configuration for the Lecture model."""
    # Use the correct field names from the Lecture model: 'starts_at' and 'ends_at'
    list_display = ('unit_code', 'title', 'lecturer', 'starts_at', 'ends_at', 'created_at')
    list_filter = ('lecturer', 'starts_at', 'created_at')
    search_fields = ('title', 'unit_code', 'lecturer__full_name', 'lecturer__username')
    raw_id_fields = ('lecturer',) # Makes selecting a user more efficient
    ordering = ('-starts_at',) # Order lectures by start time by default
