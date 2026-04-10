import 'dart:io';

import 'package:uuid/uuid.dart';

final uuid = Uuid();

class PlaceLocation {
  const PlaceLocation({
    required this.latitude,
    required this.longitude,
    this.address,
  });
  final double latitude;
  final double longitude;
  final String? address;
}

class Places {
  Places({required this.name, this.image, this.location, id})
    : id = id ?? uuid.v4();
  final String id;
  final String name;
  final File? image;
  final PlaceLocation? location;
}
