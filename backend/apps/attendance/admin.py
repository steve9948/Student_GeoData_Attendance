from django.contrib import admin

# Register your models here.
from leaflet.admin import LeafletGeoAdmin
from django.contrib.gis import admin # Use gis.admin for map widget
from .models import Attendance

@admin.register(Attendance)
class AttendanceAdmin(LeafletGeoAdmin): # Use LeafletGeoAdmin for location_at_marking
    list_display = ('student', 'lecture', 'timestamp', 'location_at_marking')
    list_filter = ('lecture', 'student', 'timestamp')
    search_fields = ('student__full_name', 'student__username', 'lecture__title')
    raw_id_fields = ('student', 'lecture')
    readonly_fields = ('timestamp',)
