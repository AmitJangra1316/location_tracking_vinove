import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[700],
      padding: const EdgeInsets.all(16.0),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/profile_pic.png'),
              ),
              SizedBox(width: 10),
              Text(
                'All Members',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(width: 10),
              Text(
                'Change',
                style: TextStyle(color: Colors.white70, fontSize: 14, decoration: TextDecoration.underline),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.arrow_back_ios, color: Colors.white),
              SizedBox(width: 10),
              Text(
                'Tue, Aug 31 2022',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(width: 10),
              Icon(Icons.calendar_today, color: Colors.white),
            ],
          ),
        ],
      ),
    );
  }
}
