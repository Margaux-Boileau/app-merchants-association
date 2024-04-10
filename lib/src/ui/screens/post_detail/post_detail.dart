import 'package:app_merchants_association/src/config/app_styles.dart';
import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';
import '../../../model/post.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PostDetail extends StatelessWidget {
  PostDetail({Key? key, required this.post}) : super(key: key);

  // Atributo para recibir el post seleccionado
  final Post post;

  // Lista Hardcodeada de comentarios.
  // Imagen | Nombre de la tienda | Hora del comentario | Descripción del comentario
  final List<Map<String, dynamic>> comments = [
    {
      "profileImage": "https://picsum.photos/201",
      "localName": "Zapatería los 3 hermanos",
      "date": "Hace 2",
      "comment": "Me encanta La Parrilla Dorada! Siempre que voy me atienden muy bien y la comida es deliciosa. Recomiendo el corte de carne especial.",
    },
    {
      "profileImage": "https://picsum.photos/202",
      "localName": "Ropa de moda para viejas como tú!",
      "date": "Hace 3",
      "comment": "A todas las abuelas les encanta vuestra comida. A las abuelas de verdad les encanta La Parrilla Dorada! (Y el pollo frito)",
    },
    {
      "profileImage": "https://picsum.photos/203",
      "localName": "La tienda de la esquina",
      "date": "Hace 4",
      "comment": "He ido un par de veces y me ha gustado mucho. La comida es muy buena y el servicio es excelente. Recomiendo el pollo frito.",
    },
    {
      "profileImage": "https://picsum.photos/204",
      "localName": "Pescadería MePeronas?",
      "date": "Hace 5",
      "comment": "Me encanta La Parrilla Dorada! Siempre que voy me atienden muy bien y la comida es deliciosa. Recomiendo el corte de carne especial.",
    },
    {
      "profileImage": "https://picsum.photos/205",
      "localName": "Tienda 5",
      "date": "Hace 6",
      "comment": "Comentario 5",
    },
  ];

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

              /// Comments body
              _commentsBody(context),
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
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
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

  Widget _commentsBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.comments,
            style: AppStyles.textTheme.labelLarge!.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 17.0,
            ),
          ),
          const SizedBox(height: 10),

          /// Lista de  Commentarios
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: comments.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(color: AppColors.background),
                        child: Image.network(
                          // TODO Cambiar por la imagen del usuario
                          comments[index]["profileImage"],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                          child: Text(
                            // TODO reemplazar por el nombre del usuario
                            comments[index]["localName"],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.textTheme.labelLarge!.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 10.0,
                            ),
                          ),
                        ),
                        Text(
                          // TODO reemplazar por la fecha del comentario
                          comments[index]["date"],
                          overflow: TextOverflow.ellipsis,
                          style: AppStyles.textTheme.bodySmall!.copyWith(
                            color: AppColors.appGrey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          // TODO reemplazar por el contenido del comentario
                          comments[index]["comment"],
                          textAlign: TextAlign.justify,
                          style: AppStyles.textTheme.labelSmall!.copyWith(
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}




