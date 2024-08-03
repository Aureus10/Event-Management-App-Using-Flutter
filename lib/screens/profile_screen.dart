import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
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
                              TextButton(
                                onPressed: () {
                                  // Add ban user functionality here
                                },
                                child: const Text('Edit Profile'),
                              )
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
                  controller: TextEditingController(text: '_Name'), // Default value
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
          Positioned(
            bottom: 16.0, // Distance from the bottom
            right: 16.0, // Distance from the right
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: () {
                    // Your onPressed code here
                  },
                  child: const Icon(Icons.logout), // Icon for the button
                ),
                const SizedBox(height: 8), // Spacing between the button and text
                const Text(
                  'Logout',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}