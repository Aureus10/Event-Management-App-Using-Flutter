// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:assignment/theme/fonts.dart';
import 'package:assignment/widgets/components/custom_buttons.dart';
import 'package:assignment/widgets/components/empty_space.dart';
import 'package:assignment/widgets/pickers/file_picker.dart';
import 'package:flutter/material.dart';

class ReportUserScreen extends StatefulWidget {
  const ReportUserScreen({super.key});

  @override
  State<ReportUserScreen> createState() => _ReportUserScreenState();
}

class _ReportUserScreenState extends State<ReportUserScreen> {
  Map<String, File> _supportingDocs = {};
  final _formKey = GlobalKey<FormState>();

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
        child: 
        Form(
          key: _formKey,
          child: 
        
        Column(
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
            CustomFilePicker(actionOnPressed: (names, files) {
              if (names.isNotEmpty && files.isNotEmpty) {
                for (int i = 0; i < names.length; i++) {
                  setState(() {
                    _supportingDocs[names[i]!] = files[i]!;
                  });
                }
              }
            }),
            const VerticalEmptySpace(),
            SizedBox(
              height: _supportingDocs.length < 3
                  ? 100
                  : _supportingDocs.length * 40,
              child: _supportingDocs.isEmpty
                  ? const Center(
                      child: Text(
                      "Supporting Documents Goes Here...",
                      style: smallTextStyle,
                    ))
                  : ListView.builder(
                      itemCount: _supportingDocs.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        String fileName = _supportingDocs.keys.elementAt(index);
                        IconData fileIcon;
                        if (fileName.endsWith('.pdf')) {
                          fileIcon = Icons.picture_as_pdf;
                        } else if (fileName.endsWith('.png') ||
                            fileName.endsWith('.jpg') ||
                            fileName.endsWith('.jpeg')) {
                          fileIcon = Icons.image;
                        } else if (fileName.endsWith('.xlsx') ||
                            fileName.endsWith('.xls')) {
                          fileIcon = Icons.table_chart;
                        } else {
                          fileIcon = Icons.insert_drive_file;
                        }
                        return Column(
                          children: [
                            Row(
                              children: [
                                Icon(fileIcon),
                                Expanded(
                                  child: Text(
                                    fileName,
                                    style: smallTextStyle,
                                  ),
                                ),
                                CustomLink(
                                  displayText: 'Remove',
                                  actionOnPressed: () {
                                    setState(() {
                                      _supportingDocs.remove(fileName);
                                    });
                                  },
                                  color: Colors.red,
                                ),
                              ],
                            ),
                            const Divider(),
                          ],
                        );
                      }),
            ),
            // const SizedBox(height: 32),
            const SizedBox(height: 48), // Add spacing before button
          ],
        ),
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
}
