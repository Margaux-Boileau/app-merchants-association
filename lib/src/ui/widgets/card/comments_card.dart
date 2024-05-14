import 'package:app_merchants_association/src/api/api_client.dart';
import 'package:app_merchants_association/src/model/comment.dart';
import 'package:app_merchants_association/src/model/user.dart';
import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_styles.dart';
import '../../../model/forums.dart';
import '../../../model/post.dart';
import '../../../model/shop.dart';

class CommentCard extends StatefulWidget {
  const CommentCard({super.key, required this.comment, required this.post, required this.forum});

  final Comment comment;
  final Post post;
  final Forums forum;

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {

  Shop? shopCreator;

  getCreatorShop() async {
    var response = await ApiClient().getShopData(widget.comment.idCreator!);
    shopCreator = Shop.fromJson(response);
    setState(() {

    });
  }

  @override
  void initState() {
    getCreatorShop();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
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
                    "http://52.86.76.124:8000/shops/${widget.comment.idCreator}/image/",
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
                      shopCreator?.name != null ? shopCreator!.name! : "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.textTheme.labelLarge!.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 11.0,
                      ),
                    ),
                  ),
                  Text(
                    widget.comment.date,
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
            widget.comment.content!,
            textAlign: TextAlign.justify,
            style: AppStyles.textTheme.labelSmall!.copyWith(
              fontSize: 11.8,
            ),
          ),
          const SizedBox(height: 5),

          /// Divider
          Divider(
            color: AppColors.primaryBlue.withOpacity(0.2),
          ),
        ],
      ),
    );
  }
}
