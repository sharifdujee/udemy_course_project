import 'dart:convert';
import 'package:favourite_place/model/place.dart';
import 'package:favourite_place/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LocationInput extends StatefulWidget {
  final void Function(PlaceLocation location) onSelectLocation;
  const LocationInput({super.key, required this.onSelectLocation});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _pickedLocation;
  var _isGettingLocation = false;
  String? _errorMessage; // Variable to store error messages

  String get locationImage {
    if (_pickedLocation == null) return '';

    final lat = _pickedLocation!.latitude;
    final lng = _pickedLocation!.longitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:S%7C$lat,$lng&key=AIzaSyApI6Q0HVMkDMXkGhJ_NogD5aX997HJV_w';
  }

  void _savePlaces(double latitude, double longitude) async {
    final location = Location();
    try {
      final locationData = await location.getLocation();
      final lat = locationData.latitude;
      final lng = locationData.longitude;

      if (lat == null || lng == null) {
        throw Exception('Failed to get location');
      }

      final url = Uri.parse(
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=AIzaSyApI6Q0HVMkDMXkGhJ_NogD5aX997HJV_w');
      final response = await http.get(url);
      final resData = json.decode(response.body);

      if (resData['results'].isEmpty) {
        throw Exception('No address found');
      }

      final address = resData['results'][0]['formatted_address'];

      setState(() {
        _pickedLocation =
            PlaceLocation(latitude: lat, longitude: lng, address: address);
        _isGettingLocation = false;
      });
    } catch (error) {
      setState(() {
        _isGettingLocation = false;
        _errorMessage =
            'Failed to fetch location. Please try again.'; // Set error message
      });
    }
  }

  void _getCurrentLocation() async {
    final location = Location();
    final locationData = await location.getLocation();
    final lat = locationData.latitude;
    final lng = locationData.longitude;
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    setState(() {
      _isGettingLocation = true;
      _errorMessage = null; // Reset error message
    });

  }

  /// select from map
  void _selectOnMap() async {


    final pickedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (context) => const MapScreen(),
      ),
    );
    if (pickedLocation == null) {
      return;
    }
    _savePlaces(pickedLocation.latitude, pickedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent;

    if (_isGettingLocation) {
      previewContent = const CircularProgressIndicator();
    } else if (_errorMessage != null) {
      previewContent = Text(
        _errorMessage!,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.red),
      );
    } else if (_pickedLocation != null) {
      previewContent = Image.network(
        locationImage,
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        errorBuilder: (context, error, stackTrace) =>
            const Text('Failed to load map image'),
      );
    } else {
      previewContent = Text(
        'No Location Chosen',
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: Colors.white),
      );
    }

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            ),
          ),
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          child: previewContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              label: const Text('Get user current location'),
              icon: const Icon(Icons.location_on),
            ),
            TextButton.icon(
              onPressed: () {
                _selectOnMap();
              }, // Functionality for map selection can be added here
              label: const Text('Select on Map'),
              icon: const Icon(Icons.map),
            )
          ],
        ),
      ],
    );
  }
}
