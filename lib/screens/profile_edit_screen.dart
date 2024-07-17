import 'package:flutter/material.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  bool _showPassword = false;

  // Controllers for text fields
  final TextEditingController _nameController =
      TextEditingController(text: 'Golden');
  final TextEditingController _dobController =
      TextEditingController(text: '12/2003');
  final TextEditingController _emailController =
      TextEditingController(text: 'Golden@gmail.com');
  final TextEditingController _contactController =
      TextEditingController(text: '01x - xxx xxxx');
  final TextEditingController _currentPasswordController =
      TextEditingController(text: 'CurrentPassword');
  final TextEditingController _newPasswordController =
      TextEditingController(text: 'NewPassword');
  final TextEditingController _confirmPasswordController =
      TextEditingController(text: 'NewPassword');

  @override
  void dispose() {
    // Dispose controllers when the widget is disposed
    _nameController.dispose();
    _dobController.dispose();
    _emailController.dispose();
    _contactController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _dobController,
                    decoration: const InputDecoration(
                      labelText: 'Date of Birth',
                      prefixIcon: Icon(Icons.calendar_today),
                    ),
                    keyboardType: TextInputType.datetime,
                  ),
                ),
                const SizedBox(width: 16), // Space between fields
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Gender',
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Male',
                        child: Text('Male'),
                      ),
                      DropdownMenuItem(
                        value: 'Female',
                        child: Text('Female'),
                      ),
                    ],
                    onChanged: (String? value) {},
                    value: 'Male',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email Address',
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _contactController,
              decoration: const InputDecoration(
                labelText: 'Contact Number',
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _currentPasswordController,
              decoration: const InputDecoration(
                labelText: 'Current Password',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _newPasswordController,
              decoration: const InputDecoration(
                labelText: 'New Password',
              ),
              obscureText: !_showPassword,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _confirmPasswordController,
              decoration: const InputDecoration(
                labelText: 'Confirm Password',
              ),
              obscureText: !_showPassword,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Switch(
                  value: _showPassword,
                  onChanged: (bool value) {
                    setState(() {
                      _showPassword = value;
                    });
                  },
                ),
                const Text('Show Password'),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add update functionality here
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor:
                    Colors.blue, // Set the button background color to blue
              ),
              child: const Text(
                'Update',
                style: TextStyle(
                  color: Colors.white, // Set text color to white
                  fontWeight: FontWeight.bold, // Make the text bold
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
