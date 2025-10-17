from django.urls import path
from .views import CreateLectureView

urlpatterns = [
    path('create/', CreateLectureView.as_view(), name='create-lecture'),
]
