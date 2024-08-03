// ignore_for_file: prefer_final_fields, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PastRequestScreen extends StatefulWidget {
  const PastRequestScreen({super.key});

  @override
  _PastRequestScreenState createState() => _PastRequestScreenState();
}

class _PastRequestScreenState extends State<PastRequestScreen> {
  //Import the data initially
  String _date = '18/5/2024';
  String _status = 'Pending Review';
  String _requestType = 'Request for Organizer Role';
  String _requestDescription = 'Description...';
  Map<String, String> files = {
    'document1.pdf':
        'https://firebasestorage.googleapis.com/v0/b/mae-assignment-a88ea.appspot.com/o/images%2FScreenshot%202023-05-19%20031809.png?alt=media&token=48f860ff-6960-404e-84f1-373b27cfd029',
    'image1.png':
        'https://firebasestorage.googleapis.com/v0/b/mae-assignment-a88ea.appspot.com/o/images%2FNew1234%40gmail.com?alt=media&token=75388f82-e280-4d43-8e79-30ff42c6107b'
  };

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
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not open the URL.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Past Requests'),
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
            ...files.keys.map((fileName) {
              return ListTile(
                leading: Icon(getFileIcon(fileName)),
                title: Text(fileName),
                onTap: () {
                  openFile(files[fileName]!);
                },
              );
            }),
            const SizedBox(height: 32),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
