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
  late Forums currentCategory;
  List<Post> posts = [];

  late Future<void> forumFuture;

  ScrollController _scrollController = ScrollController();
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _getMorePosts();
      }
    });
    forumFuture = _getForums();
    setState(() {

    });
  }

  @override
  void dispose() {
    super.dispose();
    forums.clear();
    posts.clear();
  }

  Future<void> _getMorePosts()async {
    print("GETTING MORE POSTS");
    if (UserHelper.shop != null && UserHelper.shop!.id != null) {
      currentPage++;
      List<Post> newPosts = await ApiClient().getForumPosts(currentCategory.id, currentPage);
      setState(() {
        posts.addAll(newPosts);
      });
    }
  }

  Future<void> _getForums() async {
    print("GETTING FORUMS");
    try {
      await Future.delayed(Duration.zero);
      if (UserHelper.shop != null && UserHelper.shop!.id != null) {
        forums = await ApiClient().getShopForums(UserHelper.shop!.id!);
        if (forums.isNotEmpty) {
          currentCategory = forums.first;
          posts = await ApiClient().getForumPosts(currentCategory.id, currentPage);
        }
      }
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: forumFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(body: Center(child: CircularProgressIndicator())); // Muestra un indicador de carga mientras se espera la respuesta
          } else if (snapshot.hasError) {
            return Scaffold(body: Center(child: Text('Error: ${snapshot.error}'))); // Muestra un mensaje de error si algo sale mal
          } else {
            return Scaffold(
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
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, NavigatorRoutes.createPost, arguments: currentCategory).then((value) {
                    setState(() {
                      forumFuture = _getForums();
                    });
                  });
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
                      accountName: Text(
                        UserHelper.user?.name! ?? "",
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                      accountEmail: Text(
                        UserHelper.shop?.name! ?? "",
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w400),
                      ),
                      decoration: const BoxDecoration(
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
                    forums.isNotEmpty
                        ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: forums.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            forums[index].title,
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: 14.0,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              // Get del post de la categoria seleccionada
                              currentCategory = forums[index];
                              print("Current category: ${currentCategory.id}");
                              ApiClient().getForumPosts(currentCategory.id, currentPage).then((value) {
                                posts = value;
                                print("Last post: ${posts.last.title}");
                                print("Image: ${posts.last.medias!}");
                                print("Id: ${posts.last.id}");
                                setState(() {});
                              });
                            });
                            Navigator.pop(context);
                          },
                        );
                      },
                    )
                        : Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.no_forums_available,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _body() {
    return forums.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                child: Text(
                  currentCategory.title,
                  style: AppStyles.textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 5.0),
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20.0, bottom: 20.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, NavigatorRoutes.postDetail,
                                    arguments: [posts[index], currentCategory]);
                              },
                              child: ForumCard(
                                post: posts[index],
                                forum: currentCategory,
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
          )
        : const Center(
            child: Text(
              "No hay foros disponibles",
              style: TextStyle(color: Colors.black),
            ),
          );
  }
}
