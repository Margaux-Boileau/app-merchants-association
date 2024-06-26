import 'dart:io';
import 'package:app_merchants_association/src/model/forums.dart';
import 'package:app_merchants_association/src/utils/dialog_manager.dart';
import 'package:app_merchants_association/src/utils/image_picker_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import '../../../api/api_client.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key, required this.forum});

  // Recibir el forum
  final Forums forum;

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final TextEditingController _postTitleController = TextEditingController();
  final TextEditingController _postDescriptionController =
      TextEditingController();
  List<File> imagesUploaded =
      []; // Lista de imagenes subidas (puede estar vacía o tener una o más imagenes)

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
              controller: _postTitleController,
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
              controller: _postDescriptionController,
              minLines: 1,
              // new line
              maxLines: null,
              // new line
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
            imagesUploaded.isNotEmpty ? _imageList(context) : Container(),
          ],
        ),
      ),
    );
  }

  /// Este widget muestra las imagenes subidas en la parte inferior de la pantalla
  Widget _imageList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.images_uploaded,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 15),
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
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontWeight: FontWeight.w700, fontSize: 25),
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
            onPressed: () => _sendPost(
              context,
              _postTitleController.text.toString(),
              _postDescriptionController.text.toString(),
            ),
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
        cameraFunction: () {
          ImagePickerHelper.getImage(source: ImageSource.camera)
              .then((selectedImage) {
            setState(() {
              imagesUploaded.add(selectedImage!);
            });
          });
        },
        galleryFunction: () {
          ImagePickerHelper.getImage(source: ImageSource.gallery)
              .then((selectedImage) {
            setState(() {
              imagesUploaded.add(selectedImage!);
            });
          });
        });
  }

  /// Función para enviar el post
  _sendPost(BuildContext context, postTitle, postDescription) async {
    if (postTitle.isEmpty || postDescription.isEmpty) {
      DialogManager().showSimpleDialog(
        context: context,
        title: "Campos vacíos",
        content: "Debes introducir un título y una descripción para el post.",
      );
    } else {
      // Convertir las imágenes a base64
      List<String> mediaContents =
          await ImagePickerHelper.imagesToBase64(imagesUploaded);

      // Llamar a la API para crear el post
      bool response = await ApiClient().createForumPost(
        widget.forum.id,
        postTitle,
        postDescription,
        mediaContents,
      );

      if (response == true) {
        DialogManager().showSimpleDialog(
          context: context,
          title: "Post creado",
          content: "Tu post ha sido creado con éxito.",
        );

        // Retorna a la página anterior
        Navigator.pushNamedAndRemoveUntil(context, '/main_holder', (Route<dynamic> route) => false);
        print(response);
      } else {
        DialogManager().showSimpleDialog(
          context: context,
          title: "Error",
          content: "Ha ocurrido un error al crear el post.",
        );
      }
    }
  }
}
