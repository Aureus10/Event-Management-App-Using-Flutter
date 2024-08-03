import 'package:assignment/models/profile_model.dart';
import 'package:assignment/models/request_model.dart';
import 'package:assignment/providers/profile_provider.dart';
import 'package:assignment/services/auth_service.dart';
import 'package:assignment/utils/formatter.dart';
import 'package:flutter/material.dart';

class BanUserScreen extends StatefulWidget {
  const BanUserScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BanUserScreenState createState() => _BanUserScreenState();
}

class _BanUserScreenState extends State<BanUserScreen> {
  int _banDuration = 5;

  String _reasons = '';

  Future<void> _banUser(ProfileModel targetUser) async {
    AuthService().banUser(
        targetUser,
        ReportModel(
            userEmail: ProfileProvider().userProfile!.email,
            reportedUserEmail: targetUser.email,
            date: formatDateTimeToDate(DateTime.now()),
            status: 'Approved',
            type: 'Report User',
            description: _reasons,
            supportingDocs: {}));
  }

  @override
  Widget build(BuildContext context) {
    ProfileModel targetUser =
        ModalRoute.of(context)!.settings.arguments as ProfileModel;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ban User'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ban Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              readOnly: true,
              initialValue: targetUser.email,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text(
                  'Duration',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.timer, color: Color.fromARGB(255, 0, 0, 0)),
                const SizedBox(width: 8),
                Text(
                  '$_banDuration days',
                  style: const TextStyle(fontSize: 16, color: Colors.red),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () async {
                    int? duration = await _showEditDurationDialog(context);
                    if (duration != null) {
                      setState(() {
                        _banDuration = duration;
                      });
                    }
                  },
                  child: const Text(
                    'edit',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: '',
              decoration: const InputDecoration(
                labelText: 'Reasons',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
              onChanged: (val) {
                _reasons = val;
              },
            ),
            const SizedBox(height: 32),
            const SizedBox(height: 16), // Extra space before the button
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            _banUser(targetUser);
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.blue,
            minimumSize: const Size(double.infinity, 48),
          ),
          child: const Text(
            'Ban',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Future<int?> _showEditDurationDialog(BuildContext context) async {
    TextEditingController controller = TextEditingController();
    return showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Duration'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Ban Duration (days)',
              hintText: 'Enter number of days',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                int? duration = int.tryParse(controller.text);
                Navigator.of(context).pop(duration);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
