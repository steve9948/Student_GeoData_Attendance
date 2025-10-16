from django.db import models

# Create your models here.
from django.contrib.gis.db import models
from django.utils.translation import gettext_lazy as _

class Campus(models.Model):
    name = models.CharField(max_length=255, unique=True)
    description = models.TextField(blank=True)
    # PolygonField for defining campus boundaries.
    # PostGIS automatically creates a GiST index on geometry fields,
    # which is crucial for efficient spatial queries like `contains`.
    geom = models.fields.PolygonField(srid=4326) # SRID 4326 is for WGS84 (latitude/longitude)

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = _('Campus')
        verbose_name_plural = _('Campuses')