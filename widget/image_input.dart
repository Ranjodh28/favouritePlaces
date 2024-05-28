import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  ImageInput({super.key,required this.onPickImage});

 final void Function(File image) onPickImage;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ImageInputstate();
  }
}

class _ImageInputstate extends State<ImageInput> {
  File? _selectedImage;

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedimage =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);

    if (pickedimage == null) {
      return;
    }
    setState(() {
      _selectedImage =
          File(pickedimage.path); // path tells us where is the file stored
    });
    widget.onPickImage(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
        onPressed: _takePicture,
        icon: Icon(Icons.camera),
        label: Text('Take Picture'));

    if (_selectedImage != null) {
      content = GestureDetector(// widget that recognizes gestures made by the user.
       //It can be used to capture various touch interactions, such as taps, drags, and long presses
       //By wrapping other widgets with GestureDetector, you can make them interactive and respond to user gestures.
      onTap: 
      _takePicture,
        child: Image.file(
          _selectedImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2))),
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      child: content,
    );
  }
}
