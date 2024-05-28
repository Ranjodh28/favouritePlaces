import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favourite_places/models/place.dart';

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super(const []);

  void addPlace(String title, File image) {
    final newPlace = Place(title: title,image:image

    );
    state = [newPlace,...state];  // newly added item will be shown upper side 
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
        (ref) => UserPlacesNotifier());
