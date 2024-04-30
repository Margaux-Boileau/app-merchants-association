import 'package:app_merchants_association/src/model/forums.dart';
import 'package:app_merchants_association/src/utils/helpers/user_helper.dart';
import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_styles.dart';
import '../../../model/post.dart';
import '../../../model/post_image.dart';
import '../image/image_expand.dart';

class ForumCard extends StatefulWidget {
  ForumCard({super.key, required this.post, required this.forum});

  final Post post;
  final Forums forum;

  @override
  State<ForumCard> createState() => _ForumCardState();
}

class _ForumCardState extends State<ForumCard> {

  @override
  void initState() {
    super.initState();
  }

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
                        // Cargar la imagen del usuario
                        "http://172.23.6.211:8000/shops/${widget.post.idCreator}/image/",
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
                          widget.post.title!,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyles.textTheme.labelLarge!.copyWith(
                              fontWeight: FontWeight.w700, fontSize: 16.0),
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
                                widget.post.title!,
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
                            widget.post.date!,
                            overflow: TextOverflow.ellipsis,
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
                widget.post.title!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppStyles.textTheme.labelLarge!.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 17.0,
                ),
              ),
              const SizedBox(height: 10.0),

              // Descripción del foro
              Text(
                widget.post.body!,
                textAlign: TextAlign.justify,
                style: AppStyles.textTheme.labelSmall,
              ),

              const SizedBox(height: 20.0),
              // Imagenes del foro

              /// Si el foro tiene imagenes cargarlas, de lo contrario se quedaría así
              /// Por ahora se ha creado un booleano provisional que simula si hay imágenes o no.

              widget.post.media!.isNotEmpty
                  ? Row(
                children: [
                  /// IMAGEN 1
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: AppColors.background,
                      ),
                      child: widget.post.media!.isNotEmpty
                          ? InkWell(
                        onTap: () {
                          // Bucle que añada la lista de imagenes al listado de imagenes y cargarlas con la url como hemos hecho hasta ahora
                          List<String?> listUrls = widget.post.media!;

                          Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => SliderShowFullImages(listUrls, 0) ));
                        },
                        child: Image.network(
                          "http://172.23.6.211:8000/forums/${widget.forum.id}/posts/${widget.post.id}/media/${widget.post.media!.first}/",
                          fit: BoxFit.cover,
                        ),
                      )
                          : Container(),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  // Si hay más de una imagen, mostrar el número de imágenes restantes y la imagen con opacidad
                  // Si no, no mostrar nada

                  /// IMAGEN 2
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      width: 120,
                      height: 120,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          widget.post.media!.length > 1
                              ? Image.network(
                            "http://172.23.6.211:8000/forums/${widget.forum.id}/posts/${widget.post.id}/media/${widget.post.media![1]}/",
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
                            child: widget.post.media!.length > 1
                                ? Text(
                              "+${widget.post.media!.length - 1}",
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
