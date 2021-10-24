import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserProfilePicker extends StatefulWidget {
  final void Function(File? pickedImageFile) _imagePickFn;

  const UserProfilePicker({
    Key? key,
    required imagePickFn,
  })  : _imagePickFn = imagePickFn,
        super(key: key);

  @override
  _UserProfilePickerState createState() => _UserProfilePickerState();
}

class _UserProfilePickerState extends State<UserProfilePicker> {
  XFile? _pickedPhoto;
  File? _pickedPhotoFile;

  void _pickImage() async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_ctx) => AlertDialog(
        title: const Text(
          'Choose Source',
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.spaceAround,
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              _pickedPhoto = await ImagePicker().pickImage(
                source: ImageSource.camera,
              );
              Navigator.pop(context);
            },
            child: const Text('Camera'),
          ),
          TextButton(
            onPressed: () async {
              _pickedPhoto = await ImagePicker().pickImage(
                source: ImageSource.gallery,
              );
              Navigator.pop(context);
            },
            child: const Text('Gallery'),
          ),
        ],
      ),
    );
    setState(() {
      _pickedPhotoFile = _pickedPhoto == null ? null : File(_pickedPhoto!.path);
    });
    widget._imagePickFn(_pickedPhotoFile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey,
          backgroundImage: _pickedPhotoFile == null
              ? null
              : FileImage(_pickedPhotoFile as File),
        ),
        TextButton.icon(
          icon: const Icon(Icons.image_rounded),
          label: const Text('Add Image'),
          onPressed: _pickImage,
        ),
      ],
    );
  }
}
