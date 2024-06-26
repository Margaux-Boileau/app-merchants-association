import 'dart:convert';
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
      print("Error: $e");
      print(s);
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
      print("Error: $e");
      print(s);
    }
    return _video;
  }

  /// Transformar lista de imagenes a base64
  static Future<List<String>> imagesToBase64(List<File> images) async {
    List<String> imagesBase64 = [];
    for (File image in images) {
      List<int> imageBytes = await image.readAsBytes();
      print('Longitud de imageBytes: ${imageBytes.length}');
      String base64Image = base64Encode(imageBytes);
      imagesBase64.add(base64Image);
    }
    return imagesBase64;
  }

  /// Esta función es para convertir las imágenes a base64.
  /// El bucle while es para que la longitud de la cadena sea múltiplo de 4.
  /// Esto se hace para evitar errores al decodificar la cadena. Ya que
  /// la longitud de la cadena base64 debe ser múltiplo de 4.
  static Future<List<String>> imagesToBase64M4(List<File> images) async {
    List<String> imagesBase64 = [];
    for (File image in images) {
      List<int> imageBytes = await image.readAsBytes();
      print('Longitud de imageBytes: ${imageBytes.length}');
      String base64Image = base64Encode(imageBytes);
      while (base64Image.length % 4 != 0) {
        base64Image += '=';
      }
      imagesBase64.add(base64Image);
    }
    return imagesBase64;
  }
}
