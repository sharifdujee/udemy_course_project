import 'dart:io';

import 'package:favourite_place/main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final void Function(File image) onPickImage;
  const ImageInput({super.key, required this.onPickImage});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? selectedImage;

  void _takePicture() async {
    final ImagePicker _picker = ImagePicker();
    final pickedImage =
        await _picker.pickImage(source: ImageSource.camera, maxWidth: 600);
    if (pickedImage == null) {
      return;
    }
    setState(() {
      selectedImage = File(pickedImage.path);
    });
    widget.onPickImage(selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Container(
      child: TextButton.icon(
        onPressed: () {
          _takePicture();
        },
        label: const Text('Camera'),
        icon: const Icon(Icons.camera),
      ),
    );
    if (selectedImage != null) {
      content = GestureDetector(
        onTap: _takePicture,
        child: Image.file(
          selectedImage!,
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
            color: colorScheme.primary.withOpacity(0.2),
          ),
        ),
        height: 250,
        width: double.infinity,
        alignment: Alignment.center,
        child: content);
  }
}
