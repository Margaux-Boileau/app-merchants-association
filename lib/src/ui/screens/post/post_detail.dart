import 'package:app_merchants_association/src/config/app_styles.dart';
import 'package:app_merchants_association/src/model/forums.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';
import '../../../model/post.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../utils/helpers/user_helper.dart';

class PostDetail extends StatefulWidget {
  const PostDetail({Key? key, required this.post, required this.forum}) : super(key: key);

  // Atributo para recibir el post seleccionado
  final Post post;
  final Forums forum;

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    for(String? image in widget.post!.media!){
      print(image);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalle del post"),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _postInfoShop(context),
                  _postBody(),
                  _commentsBody(context),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _commentTextField(context),
          ),
        ],
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
                "http://172.23.6.211:8000/shops/${UserHelper.shop!.id}/image/",
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
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7),
                child: Text(
                  widget.post!.title!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.textTheme.labelLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 19.0,
                  ),
                ),
              ),
              Text(
                widget.post!.date!,
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
          widget.post!.title!,
          style: AppStyles.textTheme.labelLarge!.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 17.0,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          widget.post!.body!,
          textAlign: TextAlign.justify,
          style: AppStyles.textTheme.labelSmall!.copyWith(
            fontSize: 12.0,
          ),
        ),
        const SizedBox(height: 20),
        // Hero images
        if (widget.post.media!.isNotEmpty)
          Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 300, // Ajusta este valor para cambiar el tamaño de la imagen
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 2.0,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                  onPageChanged: (index, reason) {
                    // Actualiza el estado para reflejar el cambio de página
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                items: widget.post.media!.map((item) {
                  return Padding(
                    padding: const EdgeInsets.all(2), // Ajusta este valor según tus necesidades
                    child: Material(
                      elevation: 1.0,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network("http://172.23.6.211:8000/forums/${widget.forum.id}/posts/${widget.post.id}/media/$item/", fit: BoxFit.cover, width: 1500),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              /// Indicadores de posición
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.post.media!.map((url) {
                  int index = widget.post.media!.indexOf(url);
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == index
                          ? const Color.fromRGBO(0, 0, 0, 0.9)
                          : const Color.fromRGBO(0, 0, 0, 0.4),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
      ],
    );
  }

  /// Comentarios
  Widget _commentsBody(BuildContext context) {
    return Padding(
      padding: widget.post.media!.isNotEmpty ? const EdgeInsets.only(top: 20.0, bottom: 70) : const EdgeInsets.only(top: 10.0, bottom: 70),
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
          const SizedBox(height: 20),

          /// Lista de  Commentarios
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: comments.length > 5 ? 5 : comments.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Imagen de la tienda
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration:
                                BoxDecoration(color: AppColors.background),
                            child: Image.network(
                              // TODO Cambiar por la imagen del usuario
                              comments[index]["profileImage"],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),

                        /// Nombre de tienda | Hora del comentario
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.7),
                              child: Text(
                                // TODO reemplazar por el nombre del usuario
                                comments[index]["localName"],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: AppStyles.textTheme.labelLarge!.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 11.0,
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
                                fontSize: 10.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),

                    /// Comentario
                    Text(
                      // TODO reemplazar por el contenido del comentario
                      comments[index]["comment"],
                      textAlign: TextAlign.justify,
                      style: AppStyles.textTheme.labelSmall!.copyWith(
                        fontSize: 11.8,
                      ),
                    ),
                    const SizedBox(height: 5),

                    /// Divider
                    Divider(
                      color: AppColors.primaryBlue.withOpacity(0.2),
                      height: 1,
                    ),
                  ],
                ),
              );
            },
          ),

          /// Ver más
          /// Si los comentarios son mayores a 5, se muestra el botón "Ver más"
          comments.length > 5 ? Center(
            child: TextButton(
              onPressed: () {
                // Mostrar snackbar por ahora
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Ver más comentarios"),
                  ),
                );
              },
              child: Text("Ver más",
                  style: TextStyle(color: AppColors.primaryBlue)),
            ),
          ) : Container(),

        ],
      ),
    );
  }

  /// Textfield para escribir un comentario
  Widget _commentTextField(BuildContext context) {
    return Material(
      elevation: 15.0,
      shadowColor: AppColors.black,
      child: SizedBox(
        width: double.infinity,
        child: Container(
          constraints: const BoxConstraints(maxHeight: 200),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            reverse: true,
            child: TextField(
              minLines: 1,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              style: AppStyles.textTheme.bodyMedium!.copyWith(
                color: AppColors.black,
              ),
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: "Comentar...",
                hintStyle: AppStyles.textTheme.bodyMedium!.copyWith(
                  color: AppColors.appGrey,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Comentario enviado"),
                      ),
                    );
                  },
                  icon: IconButton(
                    icon: Icon(Icons.send, color: AppColors.primaryBlue),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Comentario enviado"),
                        ),
                      );
                    },
                  ),
                  color: AppColors.primaryBlue,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


  /// Comentarios hardcoded
  // Lista Hardcodeada de comentarios.
  final List<Map<String, dynamic>> comments = [
    {
      "profileImage": "https://picsum.photos/201",
      "localName": "Zapatería los 3 hermanos",
      "date": "Hace 2",
      "comment":
      "Me encanta La Parrilla Dorada! Siempre que voy me atienden muy bien y la comida es deliciosa. Recomiendo el corte de carne especial.",
    },
    {
      "profileImage": "https://picsum.photos/202",
      "localName": "Ropa de moda para viejas como tú!",
      "date": "Hace 3",
      "comment":
      "A todas las abuelas les encanta vuestra comida. A las abuelas de verdad les encanta La Parrilla Dorada! (Y el pollo frito)",
    },
    {
      "profileImage": "https://picsum.photos/203",
      "localName": "La tienda de la esquina",
      "date": "Hace 4",
      "comment":
      "He ido un par de veces y me ha gustado mucho. La comida es muy buena y el servicio es excelente. Recomiendo el pollo frito.",
    },
    {
      "profileImage": "https://picsum.photos/204",
      "localName": "Pescadería MePeronas?",
      "date": "Hace 5",
      "comment":
      "Me encanta La Parrilla Dorada! Siempre que voy me atienden muy bien y la comida es deliciosa. Recomiendo el corte de carne especial.",
    },
    {
      "profileImage": "https://picsum.photos/205",
      "localName": "Tienda 5",
      "date": "Hace 6",
      "comment": "Comentario 5",
    },
    {
      "profileImage": "https://picsum.photos/206",
      "localName": "Tienda 6",
      "date": "Hace 7",
      "comment": "Comentario 6",
    },
    {
      "profileImage": "https://picsum.photos/207",
      "localName": "Tienda 7",
      "date": "Hace 8",
      "comment": "Comentario 7",
    },
    {
      "profileImage": "https://picsum.photos/208",
      "localName": "Tienda 8",
      "date": "Hace 9",
      "comment": "Comentario 8",
    },
    {
      "profileImage": "https://picsum.photos/209",
      "localName": "Tienda 9",
      "date": "Hace 10",
      "comment": "Comentario 9",
    },
    {
      "profileImage": "https://picsum.photos/210",
      "localName": "Tienda 10",
      "date": "Hace 11",
      "comment": "Comentario 10",
    }
  ];
}


