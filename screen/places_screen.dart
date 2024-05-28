

import 'package:favourite_places/widget/new_place.dart';
import 'package:favourite_places/models/place.dart';
import 'package:favourite_places/providers/user_places.dart';
import 'package:favourite_places/widget/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerWidget{
  PlacesScreen({super.key});


  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final userPlaces=ref.watch(userPlacesProvider);
   
    return Scaffold(appBar: AppBar(title: Text('Your Places'), actions: [IconButton(
      onPressed:(){
        Navigator.of(context ).push<Place>(MaterialPageRoute(builder: ((context) => Newplace())));
      }, icon:Icon(Icons.add) )],),body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PlacesListScreen(places: userPlaces,),
      )
      
      
      
      
      
      
      
      
      
      
      
      
      
      ,);
  }
}