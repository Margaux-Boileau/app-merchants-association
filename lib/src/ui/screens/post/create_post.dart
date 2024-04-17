import 'dart:io';

import 'package:app_merchants_association/src/utils/dialog_manager.dart';
import 'package:app_merchants_association/src/utils/image_picker_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  // Lista de imagenes subidas (puede estar vacía o tener una o más imagenes)
  List<File> imagesUploaded = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.create_post),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _content(context),
          ),
          _bottomButton(context),
        ],
      ),
    );
  }

  /// Contenido de la pantalla
  Widget _content(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 25.0, left: 25.0, right: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Post title
            Text(
              AppLocalizations.of(context)!.post_title,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 15),
            TextField(
              style: const TextStyle(fontSize: 12),
              maxLines: 2,
              maxLength: 100,
              decoration: InputDecoration(
                filled: true,
                border: InputBorder.none,
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 25),

            /// Post description
            Text(
              AppLocalizations.of(context)!.post_description,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 15),
            TextField(
              style: const TextStyle(fontSize: 12),
              maxLines: 18,
              decoration: InputDecoration(
                filled: true,
                border: InputBorder.none,
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.grey[300],
              ),
            ),

            // Cargar imagenes por defecto ahora para mostrar el diseño
            const SizedBox(height: 25),
            imagesUploaded.isNotEmpty ? _imageList(context) : Container(),
          ],
        ),
      ),
    );
  }

  Widget _imageList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "",
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 15),
        // Mostrar la primera imagen. En caso de que haya mas de 1 mostrar la segunda con
        // el número de imagenes restantes
        Row(
          children: [
            if (imagesUploaded.isNotEmpty)
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(imagesUploaded[0]),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            const SizedBox(width: 10),
            if (imagesUploaded.length > 1)
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Opacity(
                      opacity: 0.5,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(imagesUploaded[1]),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        imagesUploaded.length > 2
                            ? "+${imagesUploaded.length - 2}"
                            : "",
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w700, fontSize: 25),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 25),
      ],
    );
  }

  /// Bottom Button para subir imagenes y crear el post
  Widget _bottomButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.image),
            onPressed: () => _showImagePickerDialog(context),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO Mostrar Snackbar por ahora
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Crear post'),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(AppLocalizations.of(context)!.create_post),
          ),
        ],
      ),
    );
  }


  /// Función para mostrar un dialog para escoger galería o camara
  _showImagePickerDialog(BuildContext context) {
    DialogManager().showCameraDialog(
        context: context,
        title: AppLocalizations.of(context)!.select_image,
        cameraFunction: (){
          ImagePickerHelper.getImage(source: ImageSource.camera)
              .then((selectedImage) {
            setState(() {
              imagesUploaded.add(selectedImage!);
            });
          });
        },
        galleryFunction: (){
          ImagePickerHelper.getImage(source: ImageSource.gallery)
              .then((selectedImage) {
            setState(() {
              imagesUploaded.add(selectedImage!);
            });
          });
        }
    );
  }
}
