import 'package:app_merchants_association/src/config/app_assets.dart';
import 'package:app_merchants_association/src/model/forums.dart';
import 'package:flutter/material.dart';
import '../../../api/api_client.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_styles.dart';
import '../../../model/post.dart';
import '../../../model/shop.dart';
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
    getCreatorShop();
  }

  Shop? shopCreator;

  getCreatorShop() async {
    var response = await ApiClient().getShopData(widget.post.idCreator!);
    shopCreator = Shop.fromJson(response);
    setState(() {});


    print("SHOP CREATOR a${shopCreator!.sector.runtimeType}a");
  }

  @override
  Widget build(BuildContext context) {
    if (widget.post == null || shopCreator == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Detalle del post"),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

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
                        "http://52.86.76.124:8000/shops/${widget.post.idCreator}/image/",
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          // Return an Image widget that displays a default image
                          return Image.asset(AppAssets.market,
                              fit: BoxFit.cover);
                        },
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
                          shopCreator!.name!,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyles.textTheme.labelLarge!.copyWith(
                              fontWeight: FontWeight.w700, fontSize: 16.0),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          shopCreator!.sector != null &&
                              shopCreator!.sector != "" &&
                              shopCreator!.sector != " "
                              ? Container(
                                  constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.3),
                                  decoration: BoxDecoration(
                                    color:
                                        AppColors.primaryBlue.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: Text(
                                      shopCreator!.sector!,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppStyles.textTheme.bodySmall!
                                          .copyWith(
                                        color: AppColors.white,
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                          SizedBox(
                              width: shopCreator!.sector != null &&
                                  shopCreator!.sector! != "" &&
                                  shopCreator!.sector != " "
                                  ? 10
                                  : 0),
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

              widget.post.medias!.isNotEmpty
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
                            child: widget.post.medias!.isNotEmpty
                                ? InkWell(
                                    onTap: () {
                                      // Crear una lista de URLs de imágenes
                                      List<String> images =
                                          widget.post.medias!.map((media) {
                                        return "http://52.86.76.124:8000/forums/${widget.forum.id}/posts/${widget.post.id}/media/$media/";
                                      }).toList();

                                      // Navegar a SliderShowFullImages con la lista de imágenes
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SliderShowFullImages(images, 0),
                                        ),
                                      );
                                    },
                                    child: Image.network(
                                      "http://52.86.76.124:8000/forums/${widget.forum.id}/posts/${widget.post.id}/media/${widget.post.medias!.first}/",
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
                                widget.post.medias!.length > 1
                                    ? Image.network(
                                        "http://52.86.76.124:8000/forums/${widget.forum.id}/posts/${widget.post.id}/media/${widget.post.medias![1]}/",
                                        fit: BoxFit.cover,
                                      )
                                    : Container(),
                                widget.post.medias!.length > 1
                                    ? Container(
                                        color: AppColors.background
                                            .withOpacity(0.5),
                                      )
                                    : Container(),
                                Center(
                                  child: widget.post.medias!.length > 1
                                      ? Text(
                                          "+${widget.post.medias!.length - 1}",
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
              const SizedBox(height: 20.0),
              // Mostrar cantidad de comentarios
              Row(
                children: [
                  Icon(
                    Icons.mode_comment_outlined,
                    color: AppColors.appDarkGrey,
                    size: 20.0,
                  ),
                  const SizedBox(width: 5.0),
                  Text(
                    "${widget.post.comments!.length}",
                    style: AppStyles.textTheme.bodySmall!.copyWith(
                      color: AppColors.appDarkGrey,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
