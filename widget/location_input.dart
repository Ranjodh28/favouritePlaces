import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:favourite_places/models/place.dart';

class LocationInput extends StatefulWidget {
  LocationInput({super.key});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _pickedLocation;
  var _isGettingLocation = false;

// whole _getLocation code copied from internet
  void _getLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _isGettingLocation = true;
    });

    locationData = await location.getLocation();
    final lat = locationData.latitude;
    final lng = locationData.longitude;

    if (lat == null || lng == null) {
      return;
    }

    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=YOUR_API_KEY');

    final response = await http.get(url);
    final resdata = json.decode(response.body);
    final address = resdata['results'][0]['formatted_address'];

    setState(() {
      _pickedLocation =
          PlaceLocation(address: address, latitude: lat, longitude: lng);
      _isGettingLocation = false;
    });
    print(locationData.latitude);
  }

  @override
  Widget build(BuildContext context) {
    Widget _previewContent = Text(
      'No Location chosen',
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(color: Theme.of(context).colorScheme.onBackground),
    );

    if (_isGettingLocation) {
      _previewContent = const CircularProgressIndicator();
    }

    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            ),
          ),
          child: _previewContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
                onPressed: _getLocation,
                icon: Icon(Icons.location_on),
                label: Text('Get Current Location')),
            TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.map),
                label: Text('Select on map'))
          ],
        )
      ],
    );
  }
}
