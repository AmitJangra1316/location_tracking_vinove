import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:intl/intl.dart';
import '../services/attendance_service.dart';
import '../services/map_screen.dart'; // Ensure this is the correct path
import 'package:flutter_map/flutter_map.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final AttendanceService _attendanceService = AttendanceService();
  late Future<List<Map<String, dynamic>>> _attendanceData;
  DateTime _selectedDate = DateTime.now();
  bool _isMapView = false;

  @override
  void initState() {
    super.initState();
    _attendanceData = _attendanceService.fetchAttendanceData();
  }

  String get formattedDate {
    return DateFormat('dd-MM-yyyy').format(_selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Attendance',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 76, 69, 170),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 15),
            _buildDateNavigation(),
            const SizedBox(height: 20),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _isMapView ? _buildMapView() : _buildAttendanceList(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: GestureDetector(
          onTap: () {
            setState(() {
              _isMapView = !_isMapView;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            color: Colors.blueAccent,
            child: Center(
              child: Text(
                _isMapView ? 'Open List View' : 'Open Map View',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Row(
          children: [
            Icon(Icons.person, color: Colors.grey),
            SizedBox(width: 5),
            Text(
              'All Members',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            // Handle "Change" action
          },
          child: const Text(
            'Change',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateNavigation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.grey),
              onPressed: () {
                setState(() {
                  _selectedDate = _selectedDate.subtract(Duration(days: 1));
                });
              },
            ),
            Text(
              formattedDate,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward, color: Colors.grey),
              onPressed: () {
                setState(() {
                  _selectedDate = _selectedDate.add(Duration(days: 1));
                });
              },
            ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.calendar_today, color: Colors.grey),
          onPressed: () {
            _selectDate(context);
          },
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Widget _buildAttendanceList() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _attendanceData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No attendance data available.'),
          );
        }

        final data = snapshot.data!;
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final user = data[index];

            final latitude = double.tryParse(user['latitude'].toString());
            final longitude = double.tryParse(user['longitude'].toString());

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundImage: user['profilePic'] != null
                      ? AssetImage(user['profilePic'])
                      : const AssetImage('assets/profile_pic.png'),
                ),
                title: Text(user['name'] ?? 'Unknown'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.arrow_upward,
                            color: Colors.green, size: 16),
                        const SizedBox(width: 5),
                        Text(user['checkIn'] ?? '--:--'),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.arrow_downward,
                            color: Colors.red, size: 16),
                        const SizedBox(width: 5),
                        Text(user['checkOut'] ?? '--:--'),
                      ],
                    ),
                    if (user['status'] != null)
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: user['status'] == 'WORKING'
                              ? Colors.green.shade100
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          user['status']!,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.location_on, color: Colors.orange),
                      onPressed: () {
                        if (latitude != null &&
                            longitude != null &&
                            latitude >= -90 &&
                            latitude <= 90 &&
                            longitude >= -180 &&
                            longitude <= 180) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MapScreen(
                                memberName: user['name'] ?? 'Unknown',
                                coordinates: _generateRouteCoordinates(
                                    LatLng(latitude, longitude)),
                                currentLocation: LatLng(latitude, longitude),
                                isRoute: false,
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Location data is invalid.'),
                            ),
                          );
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.route, color: Colors.green),
                      onPressed: () {
                        if (latitude != null &&
                            longitude != null &&
                            latitude >= -90 &&
                            latitude <= 90 &&
                            longitude >= -180 &&
                            longitude <= 180) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MapScreen(
                                memberName: user['name'] ?? 'Unknown',
                                coordinates: _generateRouteCoordinates(
                                    LatLng(latitude, longitude)),
                                currentLocation: LatLng(latitude, longitude),
                                isRoute: true,
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Location data is invalid.'),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildMapView() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _attendanceData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No attendance data available.'));
        }

        final data = snapshot.data!;
        final markers = <Marker>[];

        for (final user in data) {
          final latitude = double.tryParse(user['latitude'].toString());
          final longitude = double.tryParse(user['longitude'].toString());

          if (latitude != null &&
              longitude != null &&
              latitude >= -90 &&
              latitude <= 90 &&
              longitude >= -180 &&
              longitude <= 180) {
            markers.add(Marker(
              point: LatLng(latitude, longitude),
              builder: (context) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Pin for location
                  Icon(
                    Icons.location_on,
                    color: Colors.red.shade700,
                    size: 30,
                  ),
                  // Name of the member
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      user['name'] ?? 'Unknown',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ));
          }
        }

        return FlutterMap(
          options: MapOptions(
            center: markers.isNotEmpty ? markers.first.point : LatLng(0, 0),
            zoom: 16.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayer(
              markers: markers,
            ),
          ],
        );
      },
    );
  }
}

List<LatLng> _generateRouteCoordinates(LatLng basePoint) {
  const double offset = 0.01; // Base offset for variations
  return [
    // Curved deviation
    LatLng(basePoint.latitude, basePoint.longitude), // Center
    LatLng(basePoint.latitude + offset * 0.6,
        basePoint.longitude + offset * -0.1), // Curved deviation
    LatLng(basePoint.latitude + offset * 0.7,
        basePoint.longitude + offset * 0.8), // Slightly bottom-right
  ];
}
