import 'dart:async';
import 'package:assignment/utils/form_vadidator.dart';
import 'package:assignment/widgets/components/custom_input_fields.dart';
import 'package:assignment/widgets/components/empty_space.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapTesting extends StatefulWidget {
  const MapTesting({super.key, required this.setLocation});

  final void Function(LatLng) setLocation;

  @override
  State<MapTesting> createState() => _MapTestingState();
}

class _MapTestingState extends State<MapTesting> {
  // static const LatLng _initialLocation = LatLng(3.140853, 101.693207);
  //get location API url = https://maps.googleapis.com/maps/api/geocode/json?latlng=0.00,0.00&key=

  final Location _locationController = Location();

  LatLng _currentLocation = const LatLng(3.140853, 101.693207);

  final TextEditingController _venueController = TextEditingController();

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  @override
  void initState() {
    super.initState();
    _venueController.value = TextEditingValue(
        text:
            '${_currentLocation.latitude.toStringAsFixed(6)}, ${_currentLocation.longitude.toStringAsFixed(6)}');
  }

  @override
  void dispose() {
    super.dispose();
    _venueController.dispose();
  }

  Future<void> getLocationUpdates() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await _locationController.serviceEnabled();
    if (serviceEnabled) {
      serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }

    permissionGranted = await _locationController.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _locationController.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    } else if (permissionGranted == PermissionStatus.granted) {
      LocationData currentLocation = await _locationController.getLocation();

      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _currentLocation =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
          _cameraToPosition(_currentLocation);
        });
      }
    }
  }

  Future<void> _cameraToPosition(LatLng position) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition newCameraPosition = CameraPosition(
      target: position,
      zoom: 15,
    );

    await controller
        .animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
  }

  void _onCameraMove(CameraPosition postision) {
    setState(() {
      _currentLocation = postision.target;
      _venueController.value = TextEditingValue(
          text:
              '${_currentLocation.latitude.toStringAsFixed(6)}, ${_currentLocation.longitude.toStringAsFixed(6)}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          text: 'Venue',
          validator: locationValidator(),
          actionOnChanged: (_) {},
          controller: _venueController,
        ),
        const VerticalEmptySpace(),
        SizedBox(
          height: 300,
          child: Stack(
            children: [
              GoogleMap(
                onMapCreated: ((GoogleMapController controller) =>
                    _mapController.complete(controller)),
                initialCameraPosition:
                    CameraPosition(target: _currentLocation, zoom: 15),
                onCameraMove: _onCameraMove,
              ),
              Positioned(
                top: 10,
                right: 10,
                child: FloatingActionButton(
                  onPressed: getLocationUpdates,
                  shape: CircleBorder(),
                  backgroundColor: Color.fromARGB(219, 255, 255, 255),
                  child: Icon(
                    Icons.my_location,
                    color: Colors.black,
                  ),
                ),
              ),
              const Center(
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red,
                  size: 48,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
