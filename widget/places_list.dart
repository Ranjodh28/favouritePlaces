import 'package:favourite_places/models/place.dart';
import 'package:favourite_places/screen/place_detail.dart';
import 'package:flutter/material.dart';

class PlacesListScreen extends StatelessWidget {
  PlacesListScreen({super.key, required this.places});
  final List<Place> places;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (places.isEmpty) {
      return Center(
          child: Text(
        'No Places Inserted',
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
      ));
    }
    return ListView.builder(
        itemCount: places.length,
        itemBuilder: ((context, index) => ListTile(
              leading: CircleAvatar( // leading makes an image in front of the text
                radius: 26,
                backgroundImage: FileImage(places[index].image),
              ),
              title: Text(
                places[index].title,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => PlaceDetailScreen(place: places[index]))),
            )));
  }
}
