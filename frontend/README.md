# GFAMS - Flutter Mobile Frontend

This directory contains the source code for the GFAMS mobile application, built with Flutter. The app provides a user-friendly interface for students, lecturers, and administrators to interact with the Geo-Fencing Attendance Management System.

---

## Table of Contents

- [Features](#features)
- [Getting Started](#getting-started)
- [Project Structure](#project-structure)
- [Key Dependencies](#key-dependencies)

---

## Features

- **Role-Based Authentication**: Separate login flows and dashboards for Students, Lecturers, and Admins.
- **Geolocation Services**: Captures the user's live GPS coordinates for attendance marking.
- **Backend Integration**: Communicates with the Django REST API to validate attendance and manage data.
- **Modern UI**: A clean, responsive user interface built with Material 3 design principles.

---

## Getting Started

### Prerequisites

- Flutter SDK (version 3.x or higher)
- A configured IDE (Android Studio or VS Code)
- An Android emulator or a physical device

### Setup and Installation

1.  **Navigate to the Frontend Directory**:

    ```sh
    cd frontend
    ```

2.  **Install Dependencies**:

    Run the following command to download all the necessary packages defined in `pubspec.yaml`.

    ```sh
    flutter pub get
    ```

3.  **Configure Platform-Specific Permissions**:

    - **Android**: Ensure that `android/app/src/main/AndroidManifest.xml` includes the `ACCESS_FINE_LOCATION` and `ACCESS_COARSE_LOCATION` permissions.
    - **iOS**: Ensure that `ios/Runner/Info.plist` includes the `NSLocationWhenInUseUsageDescription` and `NSLocationAlwaysUsageDescription` keys with descriptive strings.

4.  **Run the Application**:

    Launch the application on your connected device or emulator.

    ```sh
    flutter run
    ```

---

## Project Structure

The project follows a feature-driven directory structure to keep the codebase organized and scalable.

```
lib/
├── core/               # Core utilities, extensions, and app-wide exports
├── main.dart           # Main entry point of the application
_...           # Other models, providers, etc.
├─_...          # Reusable UI components
├── screens/            # Individual screens/pages of the app
├── services/           # Services for API, location, authentication, etc.
├── theme/              # App theme and styling
├── widgets/            # Reusable custom widgets
```

---

## Key Dependencies

- **`dio`**: For making HTTP requests to the Django backend.
- **`geolocator`**: For retrieving the device's GPS location.
- **`flutter_secure_storage`**: For securely storing the JWT authentication token.
- **`flutter_svg`**: For rendering SVG assets like the university logo.
- **`flutter_launcher_icons`**: For generating the app's launcher icon.
