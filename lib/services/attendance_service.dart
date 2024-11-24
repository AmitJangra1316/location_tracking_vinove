import 'dart:async';

class AttendanceService {
  Future<List<Map<String, dynamic>>> fetchAttendanceData() async {
    // Mocked data to simulate attendance information
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

    return [
      {
        'name': 'Sunil',
        'profilePic': 'assets/signup.png',
        'checkIn': '09:30 am',
        'checkOut': null,
        'status': 'WORKING',
        'latitude': 37.7749,
        'longitude': -122.4194, // Base location
      },
      {
        'name': 'Ajay',
        'profilePic': 'assets/signup.png',
        'checkIn': '09:30 am',
        'checkOut': '06:40 pm',
        'status': null,
        'latitude': 37.7760,
        'longitude': -122.4205, // ~150m away
      },
      {
        'name': 'shivansh',
        'profilePic': 'assets/signup.png',
        'checkIn': null,
        'checkOut': null,
        'status': 'NOT LOGGED-IN YET',
        'latitude': 37.7770,
        'longitude': -122.4215, // ~250m away
      },
      {
        'name': 'hanuman',
        'profilePic': 'assets/signup.png',
        'checkIn': '09:30 am',
        'checkOut': '06:40 pm',
        'status': null,
        'latitude': 37.7780,
        'longitude': -122.4225, // ~350m away
      },
    ];
  }
}
