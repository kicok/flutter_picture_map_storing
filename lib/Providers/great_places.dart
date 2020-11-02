import 'dart:io';

import 'package:flutter/foundation.dart';

import '../model/place.dart';
import '../helpers/db_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String pickedTitle, File pickedImage) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      location: null,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path // 로컬 하드 드라이브에 이미지 경로를 저장하려면 .path 가 반드시 필요
    });
  }
}
