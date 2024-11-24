import 'package:flutter/material.dart';

class CustomSidebar extends StatelessWidget {
  const CustomSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Upper Section
          Container(
            width: double.infinity,
            color: const Color.fromARGB(255, 64, 58, 145),
            padding:
                const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'WorkStatus',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 25),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/signup.png'),
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Team SRM',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'TeamSRM@gmail.com',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // List Section
          Expanded(
            child: ListView(
              children: [
                const SidebarItem(icon: Icons.alarm, title: 'Timer'),
                SidebarItem(
                  icon: Icons.calendar_today,
                  title: 'Attendance',
                  onTap: () {
                    Navigator.pushNamed(
                        context, '/attendance'); // Navigate to Attendance
                  },
                ),
                const SidebarItem(icon: Icons.bar_chart, title: 'Activity'),
                const SidebarItem(icon: Icons.schedule, title: 'Timesheet'),
                const SidebarItem(icon: Icons.report, title: 'Report'),
                const SidebarItem(icon: Icons.location_city, title: 'Jobsite'),
                const SidebarItem(icon: Icons.group, title: 'Team'),
                const SidebarItem(icon: Icons.beach_access, title: 'Time off'),
                const SidebarItem(icon: Icons.event, title: 'Schedules'),
              ],
            ),
          ),

          // Bottom Section
          Container(
            width: double.infinity,
            color: Colors.grey[200],
            padding: const EdgeInsets.all(16.0),
            child: const Row(
              children: [
                Icon(Icons.group_add, color: Colors.black54),
                SizedBox(width: 10),
                Text(
                  'Request to join Organization',
                  style: TextStyle(color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SidebarItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const SidebarItem({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  _SidebarItemState createState() => _SidebarItemState();
}

class _SidebarItemState extends State<SidebarItem> {
  bool _isHovering = false; // State to track hover

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click, // Set cursor to pointer
      onHover: (event) {
        setState(() {
          _isHovering = true; // Update hover state
        });
      },
      onExit: (event) {
        setState(() {
          _isHovering = false; // Reset hover state
        });
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            children: [
              Icon(
                widget.icon,
                color: _isHovering
                    ? const Color.fromARGB(255, 76, 69, 170)
                    : Colors.black54, // Icon changes color on hover
              ),
              const SizedBox(width: 12),
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 16,
                  color: _isHovering
                      ? const Color.fromARGB(255, 76, 69, 170)
                      : Colors.black, // Text changes color on hover
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
