import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// for picking up image from gallery
pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source);
  if (file != null) {
    return await file.readAsBytes();
  }
  const Text('No Image Selected');
}

Size getScreenSize() {
  return MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
}

Future<Uint8List?> productImage() async {
  ImagePicker picker = ImagePicker();
  XFile? file = await picker.pickImage(source: ImageSource.gallery);
  return file!.readAsBytes();
}

// for displaying snackbars
showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20.0),
      ),
      backgroundColor: Colors.orange,
    ),
  );
}

String getUid() {
  return (100000 + Random().nextInt(10000)).toString();
}
