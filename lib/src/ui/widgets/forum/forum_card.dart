import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_styles.dart';
import '../../../model/post.dart';

class ForumCard extends StatelessWidget {
  ForumCard({super.key, required this.post});

  Post post;

  @override
  Widget build(BuildContext context) {
    bool hasImages = false;

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        decoration: BoxDecoration(
          // Colors
          color: AppColors.white,
          // BorderRadius
          borderRadius: BorderRadius.circular(10.0),
          // Sombra
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Imagen
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

                  const SizedBox(width: 15.0),
                  // Column ('Title' | Row('Category', 'Send text'))
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.6,
                        ),
                        child: Text(
                          /// TODO Cambiar por el nombre del usuario
                          post.localName,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyles.textTheme.labelLarge!.copyWith(
                              fontWeight: FontWeight.w700, fontSize: 19.0),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Container(
                            constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.3),
                            decoration: BoxDecoration(
                              color: AppColors.primaryBlue.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Text(
                                // TODO Cambiar por el nombre del usuario
                                post.category,
                                overflow: TextOverflow.ellipsis,
                                style: AppStyles.textTheme.bodySmall!.copyWith(
                                  color: AppColors.white,
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Text(
                            // TODO Cambiar por la fecha de envío
                            post.date,
                            style: AppStyles.textTheme.bodySmall!.copyWith(
                              color: AppColors.appGrey,
                              fontSize: 10.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              // Título del foro
              Text(
                // TODO Cambiar por el título del foro
                post.title,
                style: AppStyles.textTheme.labelLarge!.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 17.0,
                ),
              ),
              const SizedBox(height: 10.0),

              // Descripción del foro
              Text(
                post.body,
                style: AppStyles.textTheme.labelSmall,
              ),

              const SizedBox(height: 20.0),
              // Imagenes del foro

              /// Si el foro tiene imagenes cargarlas, de lo contrario se quedaría así
              /// Por ahora se ha creado un booleano provisional que simula si hay imágenes o no.

              post.images.isNotEmpty
                  ? Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: AppColors.background,
                            ),
                            child: post.images.isNotEmpty
                                ? Image.network(
                                    post.images[0].imageUrl,
                                    fit: BoxFit.cover,
                                  )
                                : Container(),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        // Si hay más de una imagen, mostrar el número de imágenes restantes y la imagen con opacidad
                        // Si no, no mostrar nada
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            width: 120,
                            height: 120,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                post.images.isNotEmpty
                                    ? Image.network(
                                        post.images[1].imageUrl,
                                        fit: BoxFit.cover,
                                      )
                                    : Container(),
                                Opacity(
                                  opacity: 0.5,
                                  child: Container(
                                    color: AppColors.background,
                                  ),
                                ),
                                Center(
                                  child: post.images.isNotEmpty
                                      ? Text(
                                          "+${post.images.length - 1}",
                                          style: AppStyles.textTheme.labelLarge!
                                              .copyWith(
                                            color: AppColors.black,
                                            fontSize: 30.0,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        )
                                      : Container(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
