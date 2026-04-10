//import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

import 'package:favorite_places/model/place.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE user_places(id TEXT PRIMARY KEY, name TEXT, image TEXT)',
      );
    },
    version: 1,
  );
  return db;
}

class UserPlacesNotifier extends StateNotifier<List<Places>> {
  UserPlacesNotifier() : super(const []);

  Future<void> loadPlaces() async {
    final db = await _getDatabase();
    final data = await db.query('user_places');
    final places = data
        .map(
          (row) => Places(
            id: row['id'] as String,
            name: row['name'] as String,
            image: File(row['image'] as String),
          ),
        )
        .toList();
    state = places;
  }

  void addPlace(String title, File? image) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(image!.path);
    final savedImage = await image.copy('${appDir.path}/$fileName');

    final newPlace = Places(name: title, image: savedImage);
    final db = await _getDatabase();
    db.insert('user_places', {
      'id': newPlace.id,
      'name': newPlace.name,
      'image': savedImage.path,
    });
    state = [newPlace, ...state];
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Places>>(
      (ref) => UserPlacesNotifier(),
    );
