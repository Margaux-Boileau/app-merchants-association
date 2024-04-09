import 'package:app_merchants_association/src/config/app_styles.dart';
import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';
import '../../../model/post.dart';

class PostDetail extends StatelessWidget {
  const PostDetail({Key? key, required this.post}) : super(key: key);

  // Atributo para recibir el post seleccionado
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalle del post"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /// Imagen | nombre de la tienda | hora del post
              _postInfoShop(context),

              /// Título del post | Descripción | Imagenes
              _postBody(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _postInfoShop(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100.0),
            child: Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(color: AppColors.background),
              child: Image.network(
                // TODO Cambiar por la imagen del usuario
                post.profileImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 20),
          // Nombre de la tienda | Hora del post
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                child: Text(
                  post.localName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.textTheme.labelLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 19.0,
                  ),
                ),
              ),
              Text(
                post.date,
                overflow: TextOverflow.ellipsis,
                style: AppStyles.textTheme.bodySmall!.copyWith(
                  color: AppColors.appGrey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _postBody() {
    return Column(
      children: [
        Text(
          post.title,
          //overflow: TextOverflow.ellipsis,
          //maxLines: 2,
          style: AppStyles.textTheme.labelLarge!.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 17.0,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          post.body,
          textAlign: TextAlign.justify,
          style: AppStyles.textTheme.labelSmall!.copyWith(
            fontSize: 12.0,
          ),
        ),
        const SizedBox(height: 20),
        // Hero images
        if (post.images.isNotEmpty)
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: post.images.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      post.images[index].imageUrl,
                      fit: BoxFit.cover,
                      height: 200,
                      width: 200,
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
