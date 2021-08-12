import 'package:afghanistan_law_app/src/data/datasources/offline/sqlite_provider.dart';
import 'package:afghanistan_law_app/src/data/datasources/online/firestore_provider.dart';
import 'package:afghanistan_law_app/src/models/favorite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Repository {
  SqliteProvider _sqliteProvider = SqliteProvider();
  FirestoreProvider _firestoreProvider = FirestoreProvider();

  // online resource which comes from cloud firestore
  Future<QuerySnapshot?> readItems(String lang) =>
      _firestoreProvider.readItems(lang);

  // offline resource which comes from local storage -> sqlife
  Future<List<Map<String, dynamic>>> retrieveFavorite(String lang) =>
      _sqliteProvider.retrieveFavorite(lang);

  Future<int> insertFavorite(FavoriteModel favorite) =>
      _sqliteProvider.insertFavorite(favorite);

  Future<void> deleteFavorite(String title, String lang) =>
      _sqliteProvider.deleteFavorite(title, lang);

  Future<bool> isFavorite(String title, String lang) =>
      _sqliteProvider.isFavorite(title, lang);
}
