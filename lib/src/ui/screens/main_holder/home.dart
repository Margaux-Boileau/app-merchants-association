import 'package:app_merchants_association/src/api/api_client.dart';
import 'package:app_merchants_association/src/config/app_assets.dart';
import 'package:app_merchants_association/src/config/app_styles.dart';
import 'package:app_merchants_association/src/model/post.dart';
import 'package:app_merchants_association/src/utils/helpers/user_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../config/app_colors.dart';
import '../../../config/navigator_routes.dart';
import '../../../model/forums.dart';
import '../../../model/post_image.dart';
import '../../widgets/card/forum_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Llave para el Scaffold para poder abrir el drawer desde el appbar.
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Forums> forums = [];
  late String currentCategory;
  List<Post> posts = [];

  @override
  void initState() {
    super.initState();
    _getForums();
  }

  void _getForums() async {
    try {
      forums = await ApiClient().getShopForums(UserHelper.shop!.id!);
      if (forums.isNotEmpty) {
        posts = await ApiClient().getForumPosts(forums[0].id);
      }
      setState(() {});
    } catch (e) {
      print(e);
    }
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            icon: const Icon(Icons.menu),
          ),
          title: Text(AppLocalizations.of(context)!.forums),
          centerTitle: true,
        ),
        body: _body(),

        /// Botón flotante para crear un nuevo foro
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, NavigatorRoutes.createPost);
          },
          backgroundColor: AppColors.thirdBlue,
          child: Icon(
            Icons.add,
            color: AppColors.white,
          ),
        ),

        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                // TODO Cambiar el nombre de la cuenta y correo por el del usuario
                accountName: Text(
                  "UserHelper.user!.name!",
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600),
                ),
                accountEmail: Text(
                  UserHelper.shop!.name!,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w400),
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    opacity: 0.3,
                    image: AssetImage(
                      AppAssets.sants_place,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  AppLocalizations.of(context)!.categories,
                  style: AppStyles.textTheme.titleLarge!.copyWith(
                    fontSize: 17.0,
                  ),
                ),
              ),
              // TODO Cambiar lista de items por las categorías reales
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: forums.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      forums[index].title, // Muestra el título del foro
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 14.0,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        currentCategory = forums[index].title; // Actualiza la categoría actual
                      });
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
          child: Text(
            currentCategory, // Usa la categoría actual
            style: AppStyles.textTheme.titleLarge,
          ),
        ),
        const SizedBox(height: 5.0),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                /// TODO Aquí irá el ListView.builder de los foros.
                /// Por ahora se creará un card provisional para poder crear el diseño
                /// del widget del card del foro. Después, ya se creará el ListView.builder.

                /// Card provisional
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  //Si queremos que haga scroll toda la pantalla [desomentarlo]
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 20.0),
                      child: InkWell(
                        onTap: () {
                          // TODO Navegar a la pantalla de detalle del foro y pasar el post
                          Navigator.pushNamed(
                              context, NavigatorRoutes.postDetail,
                              arguments: posts[index]);
                        },
                        child: ForumCard(
                          post: posts[index],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
