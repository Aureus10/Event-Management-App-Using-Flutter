import 'dart:io';

import 'package:assignment/models/event_model.dart';
import 'package:assignment/models/profile_model.dart';
import 'package:assignment/providers/profile_provider.dart';
import 'package:assignment/utils/formatter.dart';
import 'package:assignment/widgets/pickers/datetime_picker.dart';
import 'package:assignment/widgets/pickers/location_picker.dart';
import 'package:assignment/theme/fonts.dart';
import 'package:assignment/utils/form_vadidator.dart';
import 'package:assignment/widgets/components/custom_buttons.dart';
import 'package:assignment/widgets/components/custom_input_fields.dart';
import 'package:assignment/widgets/components/empty_space.dart';
import 'package:assignment/widgets/header_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class OrganizeEventScreen extends StatefulWidget {
  const OrganizeEventScreen({super.key});

  @override
  State<OrganizeEventScreen> createState() => _OrganizeEventScreenState();
}

class _OrganizeEventScreenState extends State<OrganizeEventScreen> {
  LatLng? _location;
  bool _isFirstPage = true;
  final _formKey = GlobalKey<FormState>();
  final List<Map<DateTime, DateTime>> _eventDateTime = [{}];
  TextEditingController _locationController = TextEditingController();
  late ProfileProvider provider;

  // late String name;

  // @override
  // void initState() {

  //   name = Provider.of<ProfileProvider>(context, listen: false).userProfile!.username;
  //   super.initState();
  // }
  EventType _eventType = EventType.exhibition;
  String? _eventTitle;
  String? _eventDesc;
  String? _contact;
  double? _eventFees;
  int? _capacity;
  bool _isAnonymous = false;
  List<File> _eventMaterials = [];

  // final EventType type;
  // final String capacity;
  // final String imageLink;
  // final bool isAnonymous;
  // final EventStatus status;
  // final List<String>? materials;
  // final List<String>? participants;

  Future<void> _pickLocation() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => (CustomLocationPicker(
          setLocation: (LatLng location) {
            setState(() {
              _location = location;
            });
          },
          controller: _locationController,
          initialValue: _location,
        )),
      ),
    );
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> firstPage = [
      Text(
        'Step 1: Event Info',
        style: largeTextStyle.copyWith(decoration: TextDecoration.underline),
      ),
      const VerticalEmptySpace(),
      Text(
        'Event Type: ${_eventType.toString().split('.').last}',
        style: mediumTextStyle,
      ),
      const VerticalEmptySpace(),
      // SingleChildScrollView(
      //   scrollDirection: Axis.horizontal,
      //   child: 
      // ),
      Container(
        height: 200,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(10)
        ),
        child: GridView.builder(
          scrollDirection: Axis.horizontal,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 4/10
          ),
          itemCount: EventType.values.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _eventType = EventType.values[index];
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: _eventType == EventType.values[index] ? Colors.green : Colors.blueAccent,
                ),
                alignment: Alignment.center,
                child: Text(
                  EventType.values[index].toString().split('.').last,
                  style: mediumTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          },
        ),
      ),
      const VerticalEmptySpace(),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Location: ',
            style: mediumTextStyle,
          ),
          _location == null
              ? const Text(
                  'N/A',
                  style: mediumTextStyle,
                )
              : CustomLink(
                  displayText: formatLocationToString(_location!),
                  actionOnPressed: _pickLocation,
                  fontSize: 20,
                ),
          IconButton(
              onPressed: _pickLocation,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: const Icon(
                Icons.map,
                size: 28,
                color: Colors.blue,
              ))
        ],
      ),
      const VerticalEmptySpace(),
      Text(
        'Datetime',
        style: mediumTextStyle.copyWith(decoration: TextDecoration.underline),
      ),
      SizedBox(
        height: _eventDateTime.length * 110,
        child: ListView.builder(
            itemCount: _eventDateTime.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Day ${index + 1}',
                        style: mediumTextStyle,
                      ),
                      CustomDateTimePicker(
                          setDatetime: (DateTime start, DateTime end) {
                        setState(() {
                          _eventDateTime[index] = {start: end};
                        });
                      }),
                      Visibility(
                        visible: _eventDateTime.length > 1,
                        child: CustomLink(
                          displayText: 'Remove',
                          actionOnPressed: () {
                            setState(() {
                              _eventDateTime.removeAt(index);
                            });
                          },
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const Row(children: [
                    Expanded(
                        child: Text(
                      'End Datetime: ',
                      style: smallTextStyle,
                    )),
                    Expanded(
                        child: Text(
                      'End Datetime:',
                      style: smallTextStyle,
                    ))
                  ]),
                  Row(children: [
                    Expanded(
                        child: Text(
                      _eventDateTime[index].isNotEmpty
                          ? formatDateTimeToString(
                              _eventDateTime[index].keys.first)
                          : 'N/A',
                      style: smallTextStyle,
                    )),
                    Expanded(
                        child: Text(
                      _eventDateTime[index].isNotEmpty
                          ? formatDateTimeToString(
                              _eventDateTime[index].values.first)
                          : 'N/A',
                      style: smallTextStyle,
                    ))
                  ]),
                  const Divider(),
                ],
              );
            }),
      ),
      CustomLink(
          displayText: 'Add one more day',
          actionOnPressed: () {
            setState(() {
              if (_eventDateTime.last.isNotEmpty) {
                _eventDateTime.add({});
              } else {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please select datetime for all sessions'),
                  ),
                );
              }
            });
          }),
      const VerticalEmptySpace(
        height: 16,
      ),
      CustomActionButton(
          displayText: 'Continue',
          actionOnPressed: () {
            setState(() {
              if (_eventDateTime.last.isEmpty) {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please select datetime for all sessions 1'),
                  ),
                );
              } else if (_formKey.currentState!.validate()) {
                _isFirstPage = !_isFirstPage;
              }
            });
          }),
      const VerticalEmptySpace(),
    ];
    List<Widget> secondPage = [
      Text(
        'Step 2: Event Info',
        style: largeTextStyle.copyWith(decoration: TextDecoration.underline),
      ),
      const VerticalEmptySpace(),
      CustomTextFormField(
          text: 'Event Title',
          validator: emptyValidator(),
          actionOnChanged: (value) {
            _eventTitle = value;
          }),
      const VerticalEmptySpace(),
      CustomTextArea(
        text: 'Event Description',
        validator: emptyValidator(),
        actionOnChanged: (value) {
          _eventDesc = value;
        },
      ),
      const VerticalEmptySpace(),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.35,
            child: CustomNumericalTextFormField(
                text: 'Fees',
                validator: emptyValidator(),
                actionOnChanged: (value) {
                  _eventFees = double.parse(value);
                }),
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.35,
              child: CustomNumericalTextFormField(
                text: 'Capacity',
                initialValue: _capacity,
                validator: emptyValidator(),
                actionOnChanged: (value) {
                  _capacity = int.parse(value);
                },
                hintText: '0 for no limit',
              )),
        ],
      ),
      const VerticalEmptySpace(),
      CustomNumericalTextFormField(
          text: 'Event Contact',
          validator: contactValidator(),
          actionOnChanged: (value) {
            _contact = value;
          }),
      const VerticalEmptySpace(),
      Row(
        children: [
          Switch(
            value: _isAnonymous,
            onChanged: (_) {
              setState(() {
                _isAnonymous = !_isAnonymous;
              });
            },
            activeColor: Colors.amber,
            activeTrackColor: const Color.fromARGB(255, 255, 239, 192),
          ),
          const Text(
            'Keep Participants Anonymous',
            style: smallTextStyle,
          )
        ],
      ),
      Row(
        children: [
          const Text(
            'Event Image:',
            style: mediumTextStyle,
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.upload_file,
                size: 36,
              )),
        ],
      ),
      const VerticalEmptySpace(),
      Row(children: [
        const Text(
          'Event Materials:',
          style: mediumTextStyle,
        ),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.upload_file,
              size: 36,
            )),
      ]),
      const VerticalEmptySpace(),
      CustomActionButton(
          displayText: 'Organize',
          actionOnPressed: () {
            Navigator.pop(context);
            // Navigator.of(context).push();
          }),
      const VerticalEmptySpace(),
    ];
    return Scaffold(
        appBar: HeaderBar(
          headerTitle: 'Organize Event',
          menuRequired: false,
          customAction: _isFirstPage
              ? null
              : () {
                  setState(() {
                    _isFirstPage = !_isFirstPage;
                  });
                },
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.1,
                35,
                MediaQuery.of(context).size.width * 0.1,
                0),
            // child: MapTesting(
            //   setLocation: (LatLng val) {
            //   LatLng loc = val;
            // }),
            // child: const CustomDateTimePicker(),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: _isFirstPage ? firstPage : secondPage,
              ),
            ),
          ),
        ));
  }
}
