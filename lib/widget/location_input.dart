import 'package:favorite_places/model/place.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _pickedLocation;
  var _isGettingLocation = false;
  void _getCurrentLocation() async {
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
    if (locationData.latitude == null && locationData.longitude == null) {
      return;
    }
    setState(() {
      _pickedLocation = PlaceLocation(
        latitude: locationData.latitude!,
        longitude: locationData.longitude!,
      );
      _isGettingLocation = false;
    });
    // print(locationData.latitude);
    // print(locationData.longitude);//inorder to change this Numbers in to a readable location we need the google map api but we can't get it since it cost 200$ per month and we are not going to pay that much for this project so we will just show the lat and long in the preview container
  }

  @override
  Widget build(BuildContext context) {
    Widget preview = Text(
      'no location chosen',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
    if (_isGettingLocation) {
      preview = CircularProgressIndicator();
    }
    return Column(
      children: [
        Container(
          height: 160,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.2),
            ),
          ),
          child: preview,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              icon: Icon(Icons.location_on),
              label: Text("Get currrent location"),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.map),
              label: Text("selecte on map"),
            ),
          ],
        ),
      ],
    );
  }
}
