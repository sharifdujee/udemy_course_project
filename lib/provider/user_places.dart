import 'package:favourite_place/model/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart' as sysPaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database>  getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) {
      return db.execute('CREATE TABLE user_places{id TEXT PRIMARY_KEY, title TEXT, image TEXT, lat REAL, lng REAL, address TEXT }');

    },
    version: 1,
  );
  return db;
}

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super(const []);

  void addPlaces(String title, File image, PlaceLocation location) async {
    final appDir = await sysPaths.getApplicationCacheDirectory();
    final fileName = path.basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$fileName');

    final newPlace =
        Place(title: title, image: copiedImage, location: location);

    final db = await getDatabase();
    db.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'lat' : newPlace.location.latitude,
      'lng': newPlace.location.longitude,
      'address': newPlace.location.address,

    });


    state = [newPlace, ...state];
  }
  Future<void> loadPlaces() async{
    final db = await getDatabase();
    final data = await   db.query('user_places');
   final places = data.map((row)=> Place(id: row['id'], title: row['title'] as String, image: File(row['image'] as String), location: PlaceLocation(latitude: row['lat'] as double, longitude: row['lng'] as double, address: row['address'] as String),),).toList();
    state = places;
  }
}



final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
        (ref) => UserPlacesNotifier());
