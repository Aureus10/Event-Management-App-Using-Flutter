// ignore_for_file: prefer_final_fields, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewRequestScreen extends StatefulWidget {
  const ViewRequestScreen({super.key});

  @override
  _ViewRequestScreenState createState() => _ViewRequestScreenState();
}

class _ViewRequestScreenState extends State<ViewRequestScreen> {
  //Import the data initially
  int _requestId = 001;
  String _date = '18/5/2024';
  String _status = 'Pending Review';
  String _requestType = 'Request for Organizer Role';
  String _requestDescription = 'Description...';
  List<Tuple2<String, String>> files = [
    Tuple2('document1.pdf', 'https://firebasestorage.googleapis.com/v0/b/mae-assignment-a88ea.appspot.com/o/images%2FScreenshot%202023-05-19%20031809.png?alt=media&token=48f860ff-6960-404e-84f1-373b27cfd029'),
    Tuple2('image1.png', 'https://firebasestorage.googleapis.com/v0/b/mae-assignment-a88ea.appspot.com/o/images%2FNew1234%40gmail.com?alt=media&token=75388f82-e280-4d43-8e79-30ff42c6107b'),
  ];

  IconData getFileIcon(String fileName) {
    if (fileName.endsWith('.pdf')) {
      return Icons.picture_as_pdf;
    } else if (fileName.endsWith('.png') || fileName.endsWith('.jpg') || fileName.endsWith('.jpeg')) {
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


  void approve() {
    print("hi");
  }

  void reject() {
    print("hello");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Request'),
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
              'Request Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(children: [
              const Text(
                'Request ID: ',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 8),
              Text(
                '$_requestId',
                style: const TextStyle(
                    fontSize: 16, color: Color.fromARGB(255, 0, 136, 255)),
              ),
            ]),
            const SizedBox(height: 16),
            Row(children: [
              const Text(
                'Request Date: ',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 8),
              Text(
                _date,
                style: const TextStyle(
                    fontSize: 16, color: Color.fromARGB(255, 0, 136, 255)),
              ),
            ]),
            const SizedBox(height: 16),
            Row(children: [
              const Text(
                'Status: ',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 8),
              Text(
                _status,
                style: const TextStyle(
                    fontSize: 16, color: Color.fromARGB(255, 0, 136, 255)),
              ),
            ]),
            const SizedBox(height: 16),
            Row(children: [
              const Text(
                'Request Type: ',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 8),
              Text(
                _requestType,
                style: const TextStyle(
                    fontSize: 16, color: Color.fromARGB(255, 0, 136, 255)),
              ),
            ]),
            const SizedBox(height: 16),
            Row(children: [
              const Text(
                'Request Description: ',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 8),
              Text(
                _requestDescription,
                style: const TextStyle(
                    fontSize: 16, color: Color.fromARGB(255, 0, 136, 255)),
              ),
            ]),
            const Text(
              'Supporting Documents: ',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            ...files.map((tuple) {
              return ListTile(
                leading: Icon(getFileIcon(tuple.item1)),
                title: Text(tuple.item1),
                onTap: () {
                  openFile(tuple.item2);
                },
              );
            }),
            const SizedBox(height: 32),
            const SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  approve();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: const Text(
                  'Approve',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  reject();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Color.fromARGB(255, 255, 0, 0),
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: const Text(
                  'Reject',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
