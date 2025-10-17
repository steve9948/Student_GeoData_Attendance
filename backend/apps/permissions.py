from rest_framework.permissions import BasePermission

class IsStudent(BasePermission):
    """
    Allows access only to users with the 'student' role.
    """

    def has_permission(self, request, view):
        # Check if the user is authenticated and has the 'student' role.
        return bool(
            request.user and
            request.user.is_authenticated and
            request.user.role == 'student'
        )

class IsFaculty(BasePermission):
    """
    Allows access only to users with the 'faculty' role.
    """

    def has_permission(self, request, view):
        return bool(
            request.user and
            request.user.is_authenticated and
            request.user.role == 'faculty'
        )

class IsAdmin(BasePermission):
    """
    Allows access only to users with the 'admin' role.
    """

    def has_permission(self, request, view):
        return bool(
            request.user and
            request.user.is_authenticated and
            request.user.role == 'admin'
        )
