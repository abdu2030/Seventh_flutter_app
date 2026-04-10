import 'dart:io';

import 'package:uuid/uuid.dart';

final uuid = Uuid();

class Places {
  Places({required this.name, this.image}) : id = uuid.v4();
  final String id;
  final String name;
  final File? image;
}
