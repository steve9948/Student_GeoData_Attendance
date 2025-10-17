from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from rest_framework.permissions import IsAuthenticated

from django.contrib.gis.geos import Point

from ..permissions import IsStudent # A custom permission we might need to create
from ..campuses.models import Campus
from .models import Attendance
# We will need to import the Lecture model and have logic to find the current one
# from ..lectures.models import Lecture 

class MarkAttendanceView(APIView):
    """
    API view for students to mark their attendance.

    Requires the student to be authenticated and sends their GPS coordinates.
    The backend validates if the location is within the institution's geofence.
    """
    permission_classes = [IsAuthenticated, IsStudent] # Protect this endpoint

    def post(self, request, *args, **kwargs):
        latitude = request.data.get('latitude')
        longitude = request.data.get('longitude')

        if not latitude or not longitude:
            return Response(
                {'error': 'Latitude and Longitude are required.'},
                status=status.HTTP_400_BAD_REQUEST
            )

        try:
            # Create a Point object from the student's coordinates
            user_location = Point(float(longitude), float(latitude), srid=4326)
        except (ValueError, TypeError):
            return Response(
                {'error': 'Invalid latitude or longitude format.'},
                status=status.HTTP_400_BAD_REQUEST
            )

        # Check if any campus geofence contains the user's location
        # This assumes you have at least one Campus object in your database.
        is_on_campus = Campus.objects.filter(geom__contains=user_location).exists()

        if not is_on_campus:
            return Response(
                {'error': 'You must be within the campus to mark attendance.'},
                status=status.HTTP_400_BAD_REQUEST
            )

        # --- TODO: Find the currently active lecture for the student ---
        # This is a placeholder for the logic you will need to implement.
        # For example, find a lecture that is happening right now for the student's department.
        # current_lecture = Lecture.objects.filter(department=request.user.student_profile.department, ...).first()
        # if not current_lecture:
        #     return Response({'error': 'No active lecture found for you at this time.'}, status=status.HTTP_400_BAD_REQUEST)
        
        # For now, we'll assume a lecture is found and has an ID of 1
        mock_lecture_id = 1

        # Check if attendance has already been marked for this lecture
        already_marked = Attendance.objects.filter(
            student=request.user,
            lecture_id=mock_lecture_id
        ).exists()

        if already_marked:
            return Response(
                {'message': 'Attendance already marked for this lecture.'},
                status=status.HTTP_200_OK
            )

        # Create the attendance record
        Attendance.objects.create(
            student=request.user,
            lecture_id=mock_lecture_id, # Replace with current_lecture
            location_at_marking=user_location,
            marked_by='auto'
        )

        return Response(
            {'message': 'Attendance Marked Successfully!'},
            status=status.HTTP_201_CREATED
        )
