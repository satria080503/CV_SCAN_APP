import 'package:flutter/material.dart';

class HistoryEntry {
  final String name;
  final List<String> skills;
  final String universityProject;
  final String education;
  final String phoneNumber;
  final String experience;

  HistoryEntry({
    required this.name,
    required this.skills,
    required this.universityProject,
    required this.education,
    required this.phoneNumber,
    required this.experience,
  });
}

class History {
  static List<HistoryEntry> entries = [];

  static void addToHistory(HistoryEntry entry) {
    entries.add(entry);
  }
}

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xff872341),
        ),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          children: [
            _buildEntry(context, 'assets/page-2/images/sandra_indriasti.jpg',
                'sandra indriasti'),
            SizedBox(height: 20),
            _buildEntry(context, 'assets/page-2/images/THOMAS_LAMPKIN.jpg',
                'THOMAS LAMPKIN'),
            // Add more entries as needed
          ],
        ),
      ),
    );
  }

  Widget _buildEntry(BuildContext context, String imagePath, String name) {
    return GestureDetector(
      onTap: () {
        // Show the popup for the tapped image
        _showImagePopup(context, imagePath);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Image.asset(
              imagePath,
              height: 150,
              width: 150,
            ),
          ),
          SizedBox(height: 10),
          Text(
            name,
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
        ],
      ),
    );
  }

  void _showImagePopup(BuildContext context, String imagePath) {
    // Implement your logic to show a popup with the tapped image
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Image.asset(
            imagePath,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
        );
      },
    );
  }
}
