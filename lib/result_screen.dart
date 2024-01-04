import 'package:flutter/material.dart';
import 'package:scan_ycv_app/history.dart';

class ResultScreen extends StatelessWidget {
  final String text;

  const ResultScreen({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String name = extractName(text);
    final List<String> skills = extractSkills(text);
    final String universityProject = extractUniversityProject(text);
    final String education = extractEducation(text);
    final String phoneNumber = extractPhoneNumber(text);
    final String experience = extractExperience(text);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('Name:', name),
            _buildSection('Skills:',
                skills.isNotEmpty ? skills.join(', ') : 'Skills Not Found'),
            _buildSection('Education:', education),
            _buildSection('University Project:', universityProject),
            _buildSection('Phone Number:', phoneNumber),
            _buildSection('Experience:', experience),
            ElevatedButton(
              onPressed: () {
                _saveToHistory(name, skills, universityProject, education,
                    phoneNumber, experience);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Saved to History'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFF872341),
              ),
              child: const Text('Save to History'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          Text(content),
        ],
      ),
    );
  }

  void _saveToHistory(
    String name,
    List<String> skills,
    String universityProject,
    String education,
    String phoneNumber,
    String experience,
  ) {
    final entry = HistoryEntry(
      name: name,
      skills: skills,
      universityProject: universityProject,
      education: education,
      phoneNumber: phoneNumber,
      experience: experience,
    );

    History.addToHistory(entry);
  }

  String extractName(String text) {
    final List<String> lines = text.split('\n');
    return lines.isNotEmpty ? lines.first : 'Name Not Found';
  }

  List<String> extractSkills(String text) {
    final RegExp skillsPattern =
        RegExp(r'SKILLS(?:.*?)\n(.*?)(?:\n|$)', dotAll: true);
    final Match? match = skillsPattern.firstMatch(text);

    if (match != null) {
      final skillsText = match.group(1) ?? '';
      return skillsText.split(', ').map((skill) => skill.trim()).toList();
    } else {
      return [];
    }
  }

  String extractUniversityProject(String text) {
    final RegExp projectPattern =
        RegExp(r'UNIVERSITY PROJECT(?:.*?)\n(.*?)(?:\n|$)', dotAll: true);
    final Match? match = projectPattern.firstMatch(text);
    return match != null
        ? match.group(1) ?? 'University Project Not Found'
        : 'University Project Not Found';
  }

  String extractEducation(String text) {
    final RegExp educationPattern =
        RegExp(r'EDUCATION(?:.*?)\n(.*?)(?:\n|$)', dotAll: true);
    final Match? match = educationPattern.firstMatch(text);
    return match != null
        ? match.group(1) ?? 'Education Not Found'
        : 'Education Not Found';
  }

  String extractPhoneNumber(String text) {
    final RegExp phonePattern =
        RegExp(r'\b(\d{1,4}[.-]?\d{1,4}[.-]?\d{1,9})\b');
    final Iterable<Match> matches = phonePattern.allMatches(text);

    if (matches.isNotEmpty) {
      final List<String> phoneNumbers = matches.map((match) {
        return match.group(1) ?? '';
      }).toList();

      return 'Phone Numbers: ${phoneNumbers.join(", ")}';
    } else {
      return 'Phone Number Not Found';
    }
  }

  String extractExperience(String text) {
    final RegExp experiencePattern =
        RegExp(r'EXPERIENCE(?:.*?)\n(.*?)(?:\n|$)', dotAll: true);
    final Match? match = experiencePattern.firstMatch(text);
    return match != null
        ? match.group(1)?.trim() ?? 'Experience Not Found'
        : 'Experience Not Found';
  }
}
