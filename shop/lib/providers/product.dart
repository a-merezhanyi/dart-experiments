import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  void _setStatus(bool newStatus) {
    isFavorite = newStatus;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String authToken, String userId) async {
    final oldStatus = isFavorite;
    _setStatus(!isFavorite);

    final url = Uri.https(
      'flutter-project-b59e5-default-rtdb.europe-west1.firebasedatabase.app',
      'userFavorites/$userId/products/$id.json',
      {'auth': authToken},
    );
    try {
      final response = await http.put(url, body: json.encode(isFavorite));
      if (response.statusCode >= 400) {
        _setStatus(oldStatus);
      }
    } catch (error) {
      _setStatus(oldStatus);
    }
  }
}
