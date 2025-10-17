import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';

class ApiService {
  final Dio _dio = Dio();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  
  // IMPORTANT: Replace with your actual WSL IP address
  // Use 'http://10.0.2.2:8000/api/v1' for Android Emulator
  // Use your computer's network IP for a physical device
  final String _baseUrl = 'http://172.25.83.140 :8000/api/v1';

  /// Authenticates the user and securely stores the JWT tokens.
  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/token/', // Correct endpoint for JWT
        data: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        // On success, store the tokens securely
        await _secureStorage.write(key: 'access_token', value: response.data['access']);
        await _secureStorage.write(key: 'refresh_token', value: response.data['refresh']);

        // You can decode the token to get user role, but it's better if the API returns it
        // For now, we'll assume a successful login is a student for navigation purposes.
        // The backend should be updated to return the user's role.
        return {'success': true, 'role': 'student'}; // Placeholder role
      } else {
        return {'success': false, 'error': 'Invalid server response'};
      }
    } on DioException catch (e) {
      String errorMessage = 'An unknown error occurred.';
      if (e.response != null && e.response?.data['detail'] != null) {
        errorMessage = e.response!.data['detail'];
      } else {
        errorMessage = 'Could not connect to the server. Please check your connection.';
      }
      return {'success': false, 'error': errorMessage};
    } catch (e) {
      return {'success': false, 'error': 'An unexpected error occurred.'};
    }
  }

  /// Retrieves the stored authentication token.
  Future<String?> _getAuthToken() async {
    return await _secureStorage.read(key: 'access_token');
  }

  /// Marks attendance by sending the user's location to the backend for verification.
  Future<String> markAttendance(Position position) async {
    final token = await _getAuthToken();

    if (token == null) {
      return 'Authentication error: Please log in again.';
    }

    try {
      final response = await _dio.post(
        '$_baseUrl/attendance/mark/', // Placeholder endpoint
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
        '$_baseUrl/lectures/create/', // Placeholder endpoint
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
