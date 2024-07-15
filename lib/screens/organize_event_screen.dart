import 'package:assignment/screens/testing.dart';
import 'package:assignment/theme/fonts.dart';
import 'package:assignment/utils/form_vadidator.dart';
import 'package:assignment/widgets/components/custom_buttons.dart';
import 'package:assignment/widgets/components/custom_input_fields.dart';
import 'package:assignment/widgets/components/empty_space.dart';
import 'package:assignment/widgets/header_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrganizeEventScreen extends StatefulWidget {
  const OrganizeEventScreen({super.key});

  @override
  State<OrganizeEventScreen> createState() => _OrganizeEventScreenState();
}

class _OrganizeEventScreenState extends State<OrganizeEventScreen> {
  bool _isFirstPage = true;
  List<DateTime> _eventDateTime = [];
  List<int> _testing123 = [];

  LatLng? _location;

  // Future<void> _onMapCreated(GoogleMapController controller) {
  //   final currentLocation
  // }

  @override
  Widget build(BuildContext context) {
    List<Widget> firstPage = [
      Text(
        'Step 1: Event Info',
        style: largeTextStyle.copyWith(decoration: TextDecoration.underline),
      ),
      const VerticalEmptySpace(),
      const Text(
        'Event Type',
        style: mediumTextStyle,
      ),

      const VerticalEmptySpace(),

      Row(
        children: [
          const Text(
            'Venue :',
            style: mediumTextStyle,
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.map)),
        ],
      ),
      // Container(
      //     child: GoogleMap(
      //   // onMapCreated: _onMapCreated,
      //   initialCameraPosition:
      //       const CameraPosition(target: LatLng(0, 0), zoom: 8),
      //   // markers: _markers.values.toSet(),
      // )),

      const VerticalEmptySpace(),
      Text(
        'Datetime',
        style: mediumTextStyle.copyWith(decoration: TextDecoration.underline),
      ),
      Container(
        height: _testing123.length * 50,
        child: ListView.builder(
            itemCount: _testing123.length,
            itemBuilder: (context, index) {
              return Text(
                _testing123[index].toString(),
              );
            }),
      ),
      CustomLink(
          displayText: 'Add one more day',
          actionOnPressed: () {
            setState(() {
              _testing123.add(1);
            });
          }),
      // Row(
      //   children: [
      //     IconButton(onPressed: () {}, icon: Icon(Icons.add)),

      //   ],
      // ),

      CustomActionButton(
          displayText: 'Continue',
          actionOnPressed: () {
            setState(() {
              _isFirstPage = !_isFirstPage;
            });
          })
    ];
    List<Widget> secondPage = [
      Text(
        'Step 1: Event Info',
        style: largeTextStyle.copyWith(decoration: TextDecoration.underline),
      ),
      const VerticalEmptySpace(),
      CustomActionButton(
          displayText: 'Organize',
          actionOnPressed: () {
            Navigator.pop(context);
            // Navigator.of(context).push();
          })
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
            child: MapTesting(
              setLocation: (LatLng val) {
              LatLng loc = val;
            }),
            // child: Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   mainAxisSize: MainAxisSize.min,
            //   children: _isFirstPage ? firstPage : secondPage,
            // ),
          ),
        ));
  }
}
