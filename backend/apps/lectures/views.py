from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from rest_framework.permissions import IsAuthenticated

from django.contrib.gis.geos import Point

from ..permissions import IsFaculty # Import our custom permission
from ..campuses.models import Campus
from .models import Lecture

class CreateLectureView(APIView):
    """
    API view for faculty members to create a new lecture.
    
    Requires the lecturer to be authenticated and validates that their location
    is within the campus geofence before creating the lecture.
    """
    permission_classes = [IsAuthenticated, IsFaculty] # Protect this endpoint

    def post(self, request, *args, **kwargs):
        # Extract lecture details from the request
        unit_code = request.data.get('unit_code')
        title = request.data.get('title')
        room = request.data.get('room')
        latitude = request.data.get('latitude')
        longitude = request.data.get('longitude')

        # Validate required fields
        if not all([unit_code, title, room, latitude, longitude]):
            return Response(
                {'error': 'Missing one or more required fields.'},
                status=status.HTTP_400_BAD_REQUEST
            )

        try:
            lecturer_location = Point(float(longitude), float(latitude), srid=4326)
        except (ValueError, TypeError):
            return Response(
                {'error': 'Invalid latitude or longitude format.'},
                status=status.HTTP_400_BAD_REQUEST
            )

        # --- Geofence Validation ---
        is_on_campus = Campus.objects.filter(geom__contains=lecturer_location).exists()

        if not is_on_campus:
            return Response(
                {'error': 'You must be on campus to create a lecture.'},
                status=status.HTTP_400_BAD_REQUEST
            )

        # --- Create the Lecture ---
        lecture = Lecture.objects.create(
            lecturer=request.user,
            unit_code=unit_code,
            title=title,
            room=room
        )

        # --- TODO: Trigger Asynchronous Notification Task ---
        # from ..tasks import send_lecture_creation_notifications
        # send_lecture_creation_notifications.delay(lecture.id)

        return Response(
            {'message': f'Lecture \'{title}\' created successfully!'},
            status=status.HTTP_201_CREATED
        )
