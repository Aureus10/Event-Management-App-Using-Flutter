import 'dart:io';

import 'package:assignment/models/profile_model.dart';
import 'package:assignment/providers/event_provider.dart';
import 'package:assignment/providers/profile_provider.dart';
import 'package:assignment/theme/fonts.dart';
import 'package:assignment/utils/formatter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:assignment/models/event_model.dart';

class EventDetailsScreen extends StatefulWidget {
  const EventDetailsScreen({super.key});

  @override
  _EventDetailsScreenState createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  UserType _userType = UserType.user;
  EventType _eventType = EventType.exhibition;
  String? _eventTitle;
  String? _eventDesc;
  String? _contact;
  double? _eventFees;
  int? _capacity;
  bool _isAnonymous = false;
  File? _image;
  Map<String, String> _materials = {};

  final String eventTitle = "Event Title";
  final String organizer = "Organizer";
  final String venue = "Venue";
  final String daterange = "Date Range";
  final List<Map<DateTime, DateTime>> _eventDateTime = [
    {DateTime(2023, 5, 1, 13, 28): DateTime(2023, 5, 1, 14, 28)},
    {DateTime(2023, 5, 2, 13, 29): DateTime(2023, 5, 2, 14, 29)},
    {DateTime(2023, 5, 3, 13, 30): DateTime(2023, 5, 3, 14, 30)},
  ];
  final String fees = "Fees";
  final String capacity = "Capacity";
  final String contact = "Contact";
  final String type = "Type";
  final String materials = "Materials";
  final String description =
      "Event Description Goes Here! Event Description Goes Here! Event Description Goes Here! Event Description Goes Here! Event Description Goes Here!";
  final int participants = 11;
  final int maxParticipants = 100;
  final List<Map<String, String>> files = [
    {
      'name': 'image1.png',
      'url':
          'https://firebasestorage.googleapis.com/v0/b/mae-assignment-a88ea.appspot.com/o/images%2FScreenshot%202023-05-19%20031809.png?alt=media&token=48f860ff-6960-404e-84f1-373b27cfd029'
    },
    {
      'name': 'document1.pdf',
      'url':
          'https://firebasestorage.googleapis.com/v0/b/mae-assignment-a88ea.appspot.com/o/images%2FLab%2010%20-%20Queues.pdf?alt=media&token=98f856ae-d110-40dc-8a76-bfe78332ac59'
    },
  ];

  void loadDate(EventModel event) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: event.datetime.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<DateTime, DateTime> dateRange = entry.value;
                  debugPrint(dateRange.keys.first.toString());
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Session ${index + 1}',
                          style: mediumTextStyle,
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Start Datetime: ${formatDateTimeToString(dateRange.keys.first)}',
                          // 'Start',
                          style: smallTextStyle,
                        ),
                        Text(
                          'End Datetime: ${formatDateTimeToString(dateRange.values.first)}',
                          // 'End',
                          style: smallTextStyle,
                        ),
                        const Divider(),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  IconData getFileIcon(String fileName) {
    if (fileName.endsWith('.pdf')) {
      return Icons.picture_as_pdf;
    } else if (fileName.endsWith('.png') ||
        fileName.endsWith('.jpg') ||
        fileName.endsWith('.jpeg')) {
      return Icons.image;
    } else if (fileName.endsWith('.xlsx') || fileName.endsWith('.xls')) {
      return Icons.table_chart;
    }
    return Icons.insert_drive_file;
  }

  void openFile(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      print('Attempting to open URL: $uri');
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        print('URL successfully opened: $url');
      } else {
        print('Could not open the URL: $url');
        throw 'Could not open the URL: $url';
      }
    } catch (e) {
      print('Error: $e');
      // You can show an error message to the user here
    }
  }

  bool isOrganizer(String organizer) {
    return Provider.of<ProfileProvider>(context, listen: false)
            .userProfile!
            .email ==
        organizer;
  }

  bool isParticipant(List<String>? participants) {
    if (participants == null) {
      return false;
    }
    return participants.contains(
        Provider.of<ProfileProvider>(context, listen: false)
            .userProfile!
            .email);
  }

  bool isViewOnly() {
    return _userType == UserType.administrator;
  }

  void joinEvent(EventModel event) {
    EventProvider().joinEvent(event);
  }

  void leaveEvent(EventModel event) {
    EventProvider().leaveEvent(event);
  }

  void editEvent(EventModel event) {
    Navigator.of(context).pushNamed('/edit_event', arguments: event);
  }

  @override
  Widget build(BuildContext context) {
    EventModel event = ModalRoute.of(context)!.settings.arguments as EventModel;
    void Function()? actionOnPressed;
    String actionButtonText;
    Color actionButtonColor;
    if (isViewOnly()) {
      actionOnPressed = null;
      actionButtonText = '';
      actionButtonColor = Colors.transparent;
    } else if (isOrganizer(event.organizerEmail)) {
      actionOnPressed = () {
        editEvent(event);
      };
      actionButtonText = 'Edit';
      actionButtonColor = Colors.blueAccent;
    } else if (isParticipant(event.participants)) {
      actionOnPressed = () {
        leaveEvent(event);
      };
      actionButtonText = 'Leave';
      actionButtonColor = Colors.redAccent;
    } else {
      actionOnPressed = () {
        joinEvent(event);
      };
      actionButtonText = 'Join';
      actionButtonColor = Colors.blueAccent;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Go back
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // Open menu
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(eventTitle,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8.0),
            Center(
              child: SizedBox(
                height: 150,
                child: Image.network(event.imageLink),
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  child: Icon(Icons.person, size: 40),
                ),
                const SizedBox(height: 5),
                Text(organizer),
              ],
            ),
            Container(
              constraints: const BoxConstraints(minHeight: 40),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.location_on),
                            const SizedBox(width: 8.0),
                            Expanded(
                              child: Wrap(
                                children: [
                                  Text(venue),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            loadDate(event);
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(Icons.date_range),
                              const SizedBox(width: 8.0),
                              Expanded(
                                child: Wrap(
                                  children: [
                                    Text(
                                        'Sessions: ${event.datetime.length + 1}',
                                        style: linkTextStyle),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              constraints: const BoxConstraints(minHeight: 40),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.attach_money),
                            const SizedBox(width: 8.0),
                            Expanded(
                              child: Wrap(
                                children: [
                                  Text(fees),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.people),
                            const SizedBox(width: 8.0),
                            Expanded(
                              child: Wrap(
                                children: [
                                  Text(capacity),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Flexible(
                    child: Column(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              constraints: const BoxConstraints(minHeight: 40),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.phone),
                            const SizedBox(width: 8.0),
                            Expanded(
                              child: Wrap(
                                children: [
                                  Text(contact),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.category),
                            const SizedBox(width: 8.0),
                            Expanded(
                              child: Wrap(
                                children: [
                                  Text(type),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Flexible(
                    child: Column(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            if (isOrganizer(event.organizerEmail) ||
                isParticipant(event.participants))
              const Text("Materials",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...files.map((file) {
              return ListTile(
                leading: Icon(getFileIcon(file['name']!)),
                title: Text(file['name']!),
                onTap: () {
                  openFile(file['url']!);
                },
              );
            }),
            const SizedBox(height: 8.0),
            const Text('Event Description', style: mediumTextStyle,),
            Text(description, style: smallTextStyle,),
            const SizedBox(height: 16.0),
            Text('Participants ($participants/$maxParticipants)',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8.0),
            if (!_isAnonymous)
              Wrap(
                children: List.generate(participants, (index) {
                  return const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                  );
                }),
              ),
          ],
        ),
      ),
      bottomNavigationBar: isViewOnly()
          ? null
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: actionOnPressed,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: actionButtonColor,
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: Text(actionButtonText,
                    style: mediumTextStyle.copyWith(color: Colors.white)),
              ),
            ),
    );
  }
}
