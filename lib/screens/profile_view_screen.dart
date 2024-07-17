import 'package:assignment/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileViewScreen extends StatelessWidget {
  final bool isAdmin;
  final String _name = '';

  const ProfileViewScreen({super.key, this.isAdmin = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Column 1: Avatar and User Type
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey,
                      child: Icon(
                        Icons.person,
                        size: 40,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'User Type',
                      style: TextStyle(
                        fontWeight: FontWeight.bold, // Make the text bold
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20),

                // Column 2: Remaining Space (for Event Joined and Credit Score)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row for Event Joined and Credit Score with enforced height
                      SizedBox(
                        height: 70, // Set the height for the row
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center, // Center vertically
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Center vertically within column
                                children: [
                                  ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      minHeight: 70,
                                      maxHeight: 70,
                                    ),
                                    child: const Center(
                                      // Center text vertically
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('0'),
                                          Text('Event Joined'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                                width: 20), // Space between the columns
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Center vertically within column
                                children: [
                                  ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      minHeight: 70,
                                      maxHeight: 70,
                                    ),
                                    child: const Center(
                                      // Center text vertically
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('100'),
                                          Text('Credit Score'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Row for Report User Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            Icons.warning,
                            color: Colors.red,
                          ),
                          if (isAdmin)
                            TextButton(
                              onPressed: () {
                                // Add ban user functionality here
                              },
                              child: const Text('Ban User', style: TextStyle(color: Colors.red)),
                            )
                          else
                            TextButton(
                              onPressed: () {
                                // Add report user functionality here
                              },
                              child: const Text('Report User', style: TextStyle(color: Colors.red)),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Text fields for additional user information
            TextField(
              readOnly: true,
              controller: TextEditingController(text: _name), // Default value
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    readOnly: true,
                    controller: TextEditingController(text: '21'),
                    decoration: const InputDecoration(
                      labelText: 'Age',
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    readOnly: true,
                    controller: TextEditingController(text: 'Male'),
                    decoration: const InputDecoration(
                      labelText: 'Gender',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              readOnly: true,
              controller: TextEditingController(text: '_Name@gmail.com'),
              decoration: const InputDecoration(
                labelText: 'Email Address',
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              readOnly: true,
              controller: TextEditingController(text: '016-123 4567'),
              decoration: const InputDecoration(
                labelText: 'Contact Number',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
