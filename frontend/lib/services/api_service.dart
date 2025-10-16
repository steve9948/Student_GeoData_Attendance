import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';

class ApiService {
  final Dio _dio = Dio();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final String _baseUrl = 'http://10.0.2.2:8000/api'; // Standard localhost for Android emulator

  /// Retrieves the stored authentication token.
  Future<String?> _getAuthToken() async {
    return await _secureStorage.read(key: 'auth_token');
  }

  /// Marks attendance by sending the user's location to the backend for verification.
  Future<String> markAttendance(Position position) async {
    final token = await _getAuthToken();

    if (token == null) {
      return 'Authentication error: Please log in again.';
    }

    try {
      final response = await _dio.post(
        '$_baseUrl/attendance/mark/',
        data: {
          'latitude': position.latitude,
          'longitude': position.longitude,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data['message'] ?? 'Attendance marked successfully!';
      } else {
        final errorMessage = response.data['error'] ?? 'An unknown error occurred.';
        return 'Error: $errorMessage';
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return 'Server error: ${e.response?.data['error'] ?? 'Please try again.'}';
      } else {
        return 'Network error: Could not connect to the server.';
      }
    } catch (e) {
      return 'An unexpected error occurred: ${e.toString()}';
    }
  }

  /// Creates a new lecture by sending details and lecturer's location to the backend.
  Future<String> createLecture(String unitCode, String title, String room, Position position) async {
    final token = await _getAuthToken();

    if (token == null) {
      return 'Authentication error: Please log in again.';
    }

    try {
      final response = await _dio.post(
        '$_baseUrl/lectures/create/', // Assuming this is your lecture creation endpoint
        data: {
          'unit_code': unitCode,
          'title': title,
          'room': room,
          'latitude': position.latitude,
          'longitude': position.longitude,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 201) {
        return response.data['message'] ?? 'Lecture created successfully!';
      } else {
        final errorMessage = response.data['error'] ?? 'An unknown error occurred.';
        return 'Error: $errorMessage';
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return 'Server error: ${e.response?.data['error'] ?? 'Please try again.'}';
      } else {
        return 'Network error: Could not connect to the server.';
      }
    } catch (e) {
      return 'An unexpected error occurred: ${e.toString()}';
    }
  }
}
