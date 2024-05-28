import 'dart:io';

import 'package:favourite_places/providers/user_places.dart';
import 'package:favourite_places/widget/image_input.dart';
import 'package:favourite_places/widget/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Newplace extends ConsumerStatefulWidget{
  Newplace({super.key});


  @override
  ConsumerState<Newplace> createState() => _NewplaceState();
}

class _NewplaceState extends ConsumerState<Newplace> {
  final _titleController=TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? _selectedImage;

  void _saveplace(){
final enteredtext=_titleController.text;  // titlecontroller ensures that text is never null

if(_selectedImage==null||enteredtext.isEmpty){
return;
}


ref.read(userPlacesProvider.notifier).addPlace(enteredtext,_selectedImage!);

Navigator.of(context).pop();
  }

  @override
  void dispose() {
  _titleController.dispose();
    super.dispose();
    
  }

  @override
  Widget build(BuildContext context) {
    
    // TODO: implement build
    return Scaffold(appBar: AppBar(title: 
    Text('Add a new place'),),body:
    SingleChildScrollView(
      child: Padding(padding: EdgeInsets.all(16),
      child: Form(key:_formKey,child: 
      Column(children: [TextFormField(
        maxLength: 50,decoration: const InputDecoration(label: Text('Title'),),
         controller: _titleController,
         style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
      ),
ImageInput(onPickImage: (image) => _selectedImage=image,),

const SizedBox(height: 10,),


LocationInput(),

   const   SizedBox(height: 16,),
      ElevatedButton.icon(onPressed: _saveplace,icon: Icon(Icons.add), label: Text('Add Place'))
         ],) ,)),
    ),);
  }
}