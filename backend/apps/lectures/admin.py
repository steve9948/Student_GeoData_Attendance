from django.contrib import admin

# Register your models here.
from .models import Lecture

@admin.register(Lecture)
class LectureAdmin(admin.ModelAdmin):
    list_display = ('title', 'lecturer', 'start_time', 'end_time', 'created_at')
    list_filter = ('lecturer', 'start_time', 'created_at')
    search_fields = ('title', 'description', 'lecturer__full_name', 'lecturer__username')
    raw_id_fields = ('lecturer',) # Useful for selecting lecturers in admin
