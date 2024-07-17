import 'package:flutter/material.dart';

class BanUserScreen extends StatefulWidget {
  const BanUserScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BanUserScreenState createState() => _BanUserScreenState();
}

class _BanUserScreenState extends State<BanUserScreen> {
  int _banDuration = 5; // Default ban duration in days

@override
Widget build(BuildContext context) {
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
          const TextField(
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'Username',
              hintText: 'Name',
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
          TextField(
            controller: TextEditingController(text: ''),
            decoration: const InputDecoration(
              labelText: 'Reasons',
              border: OutlineInputBorder(),
            ),
            maxLines: 5,
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
          // Add update functionality here
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Colors.blue,
          minimumSize: const Size(double.infinity, 48),
        ),
        child: const Text(
          'Submit',
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
