import 'package:assignment/widgets/components/empty_space.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;

class ReportUserScreen extends StatelessWidget {
  const ReportUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report User'),
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
              'Report Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              readOnly: true,
              controller: TextEditingController(text: 'Name'),
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
            const VerticalEmptySpace(height: 20),
            TextField(
              controller: TextEditingController(text: 'this person...'),
              decoration: const InputDecoration(
                labelText: 'Request Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                // Call your upload file action here
                uploadFile(context);
              },
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.upload_file, size: 40),
                    SizedBox(width: 16),
                    Text(
                      'Supporting Documents',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            const SizedBox(height: 48), // Add spacing before button
          ],
        ),
      ),
      bottomNavigationBar: Container(
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

  Future<void> uploadFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;

      // Here you can implement your upload logic
      // For example, using dio to upload the file

      try {
        Dio dio = Dio();
        String fileName = path.basename(file.path!);
        FormData formData = FormData.fromMap({
          "file": await MultipartFile.fromFile(file.path!, filename: fileName),
        });

        Response response = await dio.post(
          "https://example.com/upload", // Replace with your API endpoint
          data: formData,
        );

        if (response.statusCode == 200) {
          // File uploaded successfully
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('File uploaded: ${response.data}')),
          );
        } else {
          // Handle error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('File upload failed: ${response.statusMessage}')),
          );
        }
      } catch (e) {
        // Handle exception
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Exception occurred: $e')),
        );
      }
    } else {
      // User canceled the picker
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No file selected')),
      );
    }
  }
}
