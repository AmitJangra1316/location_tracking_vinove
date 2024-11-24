import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // Ensure the correct path for your HomeScreen widget
import 'screens/attendance_screen.dart'; // Ensure the correct path for your AttendanceScreen widget

void main() {
  runApp(const LocationTrackingApp());
}

class LocationTrackingApp extends StatelessWidget {
  const LocationTrackingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hides the debug banner for a clean UI
      title: 'Location Tracking App', // App title (appears in task switcher on Android)
      theme: ThemeData(
        primarySwatch: Colors.blue, // Customizable primary color for the app
        scaffoldBackgroundColor: Colors.grey[100], // Light background for scaffold
        visualDensity: VisualDensity.adaptivePlatformDensity, // Adjusts for platform density
        // Optionally customize other theme properties like text theme, icon theme, etc.
      ),
      initialRoute: '/', // Default screen on app launch
      routes: {
        '/': (context) => HomeScreen(), // Home Screen route
        '/attendance': (context) => const AttendanceScreen(), // Attendance screen route
      },
    );
  }
}
