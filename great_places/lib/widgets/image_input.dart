import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function _onSelectImage;

  const ImageInput({Key? key, required onSelectImage})
      : _onSelectImage = onSelectImage,
        super(key: key);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  // ignore: avoid_init_to_null
  File? _storedImage = null;

  Future<void> _takePicture() async {
    final _imagePicker = ImagePicker();
    final _imageFile = await _imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    final _finalImageFile = File(_imageFile!.path);

    // ignore: unnecessary_null_comparison
    if (_imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = _finalImageFile;
    });
    final _appDir = await syspaths.getApplicationDocumentsDirectory();
    final _fileName = path.basename(_imageFile.path);
    final _savedImage =
        await _finalImageFile.copy('${_appDir.path}/$_fileName');
    widget._onSelectImage(pickedImage: _savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage as File,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextButton.icon(
            icon: const Icon(Icons.camera),
            label: const Text('Take Picture'),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color?>(
                Theme.of(context).primaryColor,
              ),
            ),
            onPressed: _takePicture,
          ),
        ),
      ],
    );
  }
}
