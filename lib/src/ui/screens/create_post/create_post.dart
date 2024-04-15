import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreatePost extends StatelessWidget {
  const CreatePost({super.key});

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
            _imageList(context),
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
          "Imagenes subidas",
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 15),
        // Mostrar la primera imagen. En caso de que haya mas de 1 mostrar la segunda con
        // el número de imagenes restantes
        Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              // TODO: Mostrar la imagen subida de image picker
              child: const Icon(Icons.image),
            ),
            const SizedBox(width: 10),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  // TODO Poner el número de imagenes restantes de la lista de imagenes subidas
                  "+1",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
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
            onPressed: () {
              // TODO: Implementar la funcionalidad para subir imágenes
              // TODO Mostrar Snackbar por ahroa
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Subir imagen'),
                ),
              );
            },
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
}
