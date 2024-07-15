import 'dart:async';

import 'package:assignment/theme/fonts.dart';
import 'package:assignment/widgets/components/custom_buttons.dart';
import 'package:assignment/widgets/components/empty_space.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapTesting extends StatefulWidget {
  const MapTesting({super.key});

  @override
  State<MapTesting> createState() => _MapTestingState();
}

class _MapTestingState extends State<MapTesting> {

  // static const LatLng _initialLocation = LatLng(3.140853, 101.693207);
  //get location API url = https://maps.googleapis.com/maps/api/geocode/json?latlng=0.00,0.00&key=

  final Location _locationController = Location();

  LatLng _currentLocation = LatLng(3.140853, 101.693207);

  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> getLocationUpdates() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    

    serviceEnabled = await _locationController.serviceEnabled();
    if(serviceEnabled) {
      serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }
  
    permissionGranted = await _locationController.hasPermission();
    if(permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _locationController.requestPermission();
      if(permissionGranted != PermissionStatus.granted) {
        return;
      } 
    } else if (permissionGranted == PermissionStatus.granted) {

        LocationData currentLocation = await _locationController.getLocation();

        if (currentLocation.latitude != null && currentLocation.longitude != null) {
          setState(() {
            _currentLocation = LatLng(currentLocation.latitude!, currentLocation.longitude!);
            _cameraToPosition(_currentLocation);
          });
        }
    }

  }

  Future<void> _cameraToPosition(LatLng position) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition newCameraPosition = CameraPosition(target: position, zoom: 15,);

    await controller.animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
  }

  void _onCameraMove(CameraPosition postision) {
    setState(() {
      _currentLocation = postision.target;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomLink(displayText: 'Get current location', actionOnPressed: getLocationUpdates),
            IconButton(onPressed: getLocationUpdates, icon: const Icon(Icons.location_pin)),
          ],
        ),
        // const VerticalEmptySpace(),
        SizedBox(
          height: 300,
          child: 
        GoogleMap(
          onMapCreated: ((GoogleMapController controller) => _mapController.complete(controller)),
          initialCameraPosition: CameraPosition(target: _currentLocation, zoom: 15),
        markers: {
          Marker(
            markerId: const MarkerId('_location'),
            icon: BitmapDescriptor.defaultMarker,
            position: _currentLocation,
          )
        },
        onCameraMove: _onCameraMove,
        
        ),
        ),

      ],
    );
  }
}