import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {


  /// Mostra càmera o galeria per obtenir una imatge
  static Future<File?> getImage({
    required ImageSource source
  }) async {
    File? _image;
    try {
      final picker = ImagePicker();
      // Obrim galería o càmera
      final pickedFile = await picker.pickImage(
        //TODO: revisar que esto no afecte a nada
        requestFullMetadata: false,
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
      );

      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }

    } catch(e, s) {
      //print("Error: $e");
      //print(s);
    }

    return _image;
  }

  /// Mostra càmera o galeria per obtenir un vídeo
  static Future<File?> getVideo({
    required ImageSource source
  }) async {
    File? _video;

    try {
      final picker = ImagePicker();

      // Obrim galería o càmera
      final pickedFile = await picker.pickVideo(
        source: source,
      );

      if (pickedFile != null) {
        _video = File(pickedFile.path);
      }
    } catch(e, s) {
      //print("Error: $e");
      //print(s);
    }
    return _video;
  }
}
