import 'package:assignment/models/profile_model.dart';
import 'package:assignment/providers/profile_provider.dart';
import 'package:assignment/services/auth_service.dart';
import 'package:assignment/widgets/components/empty_space.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.userProfile});

  final ProfileModel userProfile;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  // Add ban user functionality here
                                  Navigator.of(context).pushNamed('/ban_user', arguments: '');
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
                TextField(
                  readOnly: true,
                  controller: TextEditingController(text: userProfile?.username ?? ''),
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                const VerticalEmptySpace(),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        readOnly: true,
                        controller: TextEditingController(text: userProfile?.dateOfBirth ?? ''),
                        decoration: const InputDecoration(
                          labelText: 'Date of birth',
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        readOnly: true,
                        controller: TextEditingController(text: userProfile?.gender.toString() ?? ''),
                        decoration: const InputDecoration(
                          labelText: 'Gender',
                        ),
                      ),
                    ),
                  ],
                ),
                const VerticalEmptySpace(),
                TextField(
                  readOnly: true,
                  controller: TextEditingController(text: userProfile?.email ?? ''),
                  decoration: const InputDecoration(
                    labelText: 'Email Address',
                  ),
                ),
                const VerticalEmptySpace(),
                TextField(
                  readOnly: true,
                  controller: TextEditingController(text: userProfile?.contact ?? ''),
                  decoration: const InputDecoration(
                    labelText: 'Contact Number',
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: () {
                    AuthService().signOut();
                  },
                  child: const Icon(Icons.logout),
                ),
                const VerticalEmptySpace(),
                const Text(
                  'Logout',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      
    );
  }
}