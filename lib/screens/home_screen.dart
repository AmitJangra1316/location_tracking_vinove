import 'package:flutter/material.dart';
import '../widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 76, 69, 170),
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          'Vinove Software',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      drawer: const CustomSidebar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text(
                'Team Members',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 76, 69, 170),
                ),
              ),
              const SizedBox(height: 8),
              // Team member details
              Column(
                children: const [
                  TeamMemberCard(
                    name: 'Amit',
                    description: 'A pasionate Full Stack developer .',
                  ),
                  TeamMemberCard(
                    name: 'Rakshita',
                    description: 'A pasionate Full Stack developer .',
                  ),
                  TeamMemberCard(
                    name: 'Tanay Das',
                    description: 'A pasionate Full Stack developer .',
                  ),
                  TeamMemberCard(
                    name: 'Sakshi Tyagi',
                    description: 'A pasionate Full Stack developer .',
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'About SRM University',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 76, 69, 170),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'SRM University is one of the leading institutions in India, known for its excellence in education and innovation. '
                'The university hosts top companies like Vinove Software for placements and internships.',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class TeamMemberCard extends StatelessWidget {
  final String name;
  final String description;

  const TeamMemberCard({
    super.key,
    required this.name,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            child: Text(name[0], style: const TextStyle(fontSize: 18)),
          ),
          title: Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          subtitle: Text(
            description,
            style: const TextStyle(height: 1.4),
          ),
          isThreeLine: false,
        ),
      ),
    );
  }
}
