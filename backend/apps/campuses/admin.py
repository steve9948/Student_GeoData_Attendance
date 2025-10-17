from django.contrib import admin

# Register your models here.
# from django.contrib.gis import admin
from leaflet.admin import LeafletGeoAdmin
from .models import Campus

# Use OSMGeoAdmin for a better map interface in the admin
@admin.register(Campus)
class CampusAdmin(LeafletGeoAdmin):
    list_display = ('name', 'description')
    search_fields = ('name',)
    # This will use the default GiST index created by PostGIS
    # No need to explicitly add db_index=True for geom field here.
