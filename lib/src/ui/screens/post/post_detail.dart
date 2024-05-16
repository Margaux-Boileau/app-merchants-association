import 'package:app_merchants_association/src/api/api_client.dart';
import 'package:app_merchants_association/src/config/app_styles.dart';
import 'package:app_merchants_association/src/model/forums.dart';
import 'package:app_merchants_association/src/ui/widgets/card/comments_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../../config/app_assets.dart';
import '../../../config/app_colors.dart';
import '../../../config/navigator_routes.dart';
import '../../../model/post.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/shop.dart';
import '../../widgets/textField/comment_text_field.dart';

class PostDetail extends StatefulWidget {
  const PostDetail({Key? key, required this.post, required this.forum})
      : super(key: key);

  // Atributo para recibir el post seleccionado
  final Post post;
  final Forums forum;


  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  int _currentIndex = 0;

  Post? post;
  Shop? shopCreator;
  Map<String, dynamic>? imagesMap;

  @override
  void initState() {
    super.initState();
    post = widget.post;
    post!.comments = post!.comments!.reversed.toList();
    getPostDetail();
    getCreatorShop();
    if(post!.medias != null){
      createImagesMap(post!.medias!);
    }
  }

  createImagesMap(List<String> strings) async {
    Map<String, dynamic> resultMap = {};

    for (String str in strings) {
      dynamic result = await ApiClient().getPostImage(widget.forum.id, post!.id,str); // Reemplaza asyncFunction() con la función asíncrona que desees llamar.
      resultMap[str] = result;
    }

    imagesMap = resultMap;
    setState(() {

    });
  }

  getPostDetail() async {
    var response = await ApiClient().getPostDetail(
        widget.forum.id, widget.post.id);
    post = response;
    post!.comments = post!.comments!.reversed.toList();
    setState(() {});
  }

  getCreatorShop() async {
    var response = await ApiClient().getShopData(widget.post.idCreator!);
    shopCreator = Shop.fromJson(response);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.post == null || shopCreator == null) {
      return Container(
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
          child: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalle del post"),
      ),
      body: SizedBox(
        height: MediaQuery
            .of(context)
            .size
            .height,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 20.0),
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
              child: CommentTextField(forum: widget.forum, post: post!, updateScreen: getPostDetail,),
            ),
          ],
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
                "http://52.86.76.124:8000/shops/${widget.post.idCreator}/image/",
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                  // Return an Image widget that displays a default image
                  return Image.asset(AppAssets.market, fit: BoxFit.cover);
                },
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
                    maxWidth: MediaQuery
                        .of(context)
                        .size
                        .width * 0.7),
                child: Text(
                  shopCreator!.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.textTheme.labelLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 19.0,
                  ),
                ),
              ),
              Text(
                post!.date!,
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
          post!.title!,
          style: AppStyles.textTheme.labelLarge!.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 17.0,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          post!.body!,
          textAlign: TextAlign.justify,
          style: AppStyles.textTheme.labelSmall!.copyWith(
            fontSize: 12.0,
          ),
        ),
        const SizedBox(height: 20),
        // Hero images
        if (post!.medias!.isNotEmpty)
          imagesMap != null
              ? Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 300,
                  // Ajusta este valor para cambiar el tamaño de la imagen
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
                items: post!.medias!.map((item) {

                  return Padding(
                    padding: const EdgeInsets.all(2),
                    // Ajusta este valor según tus necesidades
                    child: Material(
                      elevation: 1.0,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.memory(
                              imagesMap![item],
                              fit: BoxFit.cover, width: 1500),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              /// Indicadores de posición
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: post!.medias!.map((url) {
                  int index = post!.medias!.indexOf(url);
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 2.0),
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
          )
        : CircularProgressIndicator(),
      ],
    );
  }

  /// Comentarios
  Widget _commentsBody(BuildContext context) {
    return Padding(
      padding: post!.medias!.isNotEmpty ? const EdgeInsets.only(
          top: 20.0, bottom: 70) : const EdgeInsets.only(top: 10.0, bottom: 70),
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
            itemCount: post!.comments!.length > 5 ? 5 : post!.comments!.length,
            itemBuilder: (context, index) {
              return CommentCard(comment: post!.comments![index]!,
                  post: post!,
                  forum: widget.forum, onDelete: getPostDetail);
            },
          ),

          /// Ver más
          /// Si los comentarios son mayores a 5, se muestra el botón "Ver más"
          post!.comments!.length > 5 ? Center(
            child: TextButton(
              onPressed: () {
                // Mostrar snackbar por ahora
                Navigator.pushNamed(
                    context, NavigatorRoutes.comments,
                    arguments: [widget.post, widget.forum]);
              },
              child: Text(
                  "Ver más",
                  style: TextStyle(color: AppColors.primaryBlue)),
            ),
          ) : Container(),

        ],
      ),
    );
  }
}