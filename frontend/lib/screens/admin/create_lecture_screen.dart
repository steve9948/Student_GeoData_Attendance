import 'package:flutter/material.dart';
import 'package:university_student_geodata/services/api_service.dart';
import 'package:university_student_geodata/services/location_service.dart';

class CreateLectureScreen extends StatefulWidget {
  const CreateLectureScreen({super.key});

  @override
  State<CreateLectureScreen> createState() => _CreateLectureScreenState();
}

class _CreateLectureScreenState extends State<CreateLectureScreen> {
  final _formKey = GlobalKey<FormState>();
  final _unitCodeController = TextEditingController();
  final _titleController = TextEditingController();
  final _roomController = TextEditingController();

  final LocationService _locationService = LocationService();
  final ApiService _apiService = ApiService();
  bool _isLoading = false;

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return; // If the form is not valid, do not proceed.
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // 1. Get the lecturer's current location
      final position = await _locationService.getCurrentPosition();

      // 2. Send the lecture details and location to the backend
      final response = await _apiService.createLecture(
        _unitCodeController.text,
        _titleController.text,
        _roomController.text,
        position,
      );

      // 3. Show success message and navigate back
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response)),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      // 4. Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a New Lecture'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _unitCodeController,
                decoration: const InputDecoration(
                  labelText: 'Unit Code',
                  hintText: 'e.g., BIT2105',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a unit code';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Lecture Title',
                  hintText: 'e.g., Mobile Application Development',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a lecture title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _roomController,
                decoration: const InputDecoration(
                  labelText: 'Room / Location',
                  hintText: 'e.g., Lab 4, LT01',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a room or location';
                  }
                  return null;
                },
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _isLoading ? null : _submitForm,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('CREATE LECTURE'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
