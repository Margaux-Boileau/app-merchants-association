import 'package:app_merchants_association/src/config/app_styles.dart';
import 'package:app_merchants_association/src/model/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../config/app_colors.dart';
import '../../../model/post_image.dart';
import '../../widgets/card/forum_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              // TODO Mostrar snackbar de momento
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Mostrar menú lateral'),
                ),
              );
            },
            icon: const Icon(Icons.menu),
          ),
          title: Text(AppLocalizations.of(context)!.forums),
          centerTitle: true,
        ),
        body: _body(),
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.general,
              style: AppStyles.textTheme.titleLarge,
            ),
            const SizedBox(height: 20.0),

            /// TODO Aquí irá el ListView.builder de los foros.
            /// Por ahora se creará un card provisional para poder crear el diseño
            /// del widget del card del foro. Después, ya se creará el ListView.builder.

            /// Card provisional
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(), //Si queremos que haga scroll toda la pantalla [desomentarlo]
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: InkWell(
                    onTap: () {
                      // Mostrar snackbar de momento
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Mostrar foro'),
                        ),
                      );
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
    );
  }


  /// ---- PRUEBAS HARDCODED ----////

  /// Lista [HARDCODED] de posts para pruebas
  List<Post> posts = [
    Post(
      id: 1,
      profileImage: 'https://picsum.photos/501',
      category: 'Cafetería',
      localName: 'El Aroma',
      title: 'Cafetería "El Aroma"',
      date: 'Hace 1 h',
      body: ' ¡Disfruta del mejor café de la ciudad en un ambiente acogedor! En Café El Aroma, nos enorgullecemos de servir café de alta calidad y deliciosos pasteles caseros. ¡Ven y relájate con nosotros!',
      images: [],
      idCreator: 1,
    ),
    Post(
      id: 1,
      profileImage: 'https://picsum.photos/502',
      category: 'Tienda de Ropa',
      localName: 'Fashion Trends',
      title: 'Sobre nosotros',
      date: 'Hace 2 h',
      body: 'Descubre las últimas tendencias en moda en nuestra tienda Fashion Trends. Desde elegantes vestidos hasta cómodos conjuntos casuales, tenemos todo lo que necesitas para lucir fabuloso en cualquier ocasión.',
      images: [
        PostImage(
          id: 1,
          imageUrl: 'https://picsum.photos/102',
          idPost: 2,
        ),
        PostImage(
          id: 2,
          imageUrl: 'https://picsum.photos/103',
          idPost: 2,
        ),
      ],
      idCreator: 1,
    ),
    Post(
      id: 1,
      profileImage: 'https://picsum.photos/503',
      category: 'Zapatería',
      localName: 'Footwear Haven',
      title: 'Nuestros zapatos más cool de Sants',
      date: 'Hace 3 h',
      body: 'Encuentra el par de zapatos perfecto para complementar tu estilo en Footwear Haven. Con una amplia selección de calzado de marcas reconocidas, estamos aquí para satisfacer todas tus necesidades de calzado.',
      images: [
        PostImage(
          id: 1,
          imageUrl: 'https://picsum.photos/104',
          idPost: 3,
        ),
        PostImage(
          id: 2,
          imageUrl: 'https://picsum.photos/105',
          idPost: 3,
        ),
        PostImage(
          id: 2,
          imageUrl: 'https://picsum.photos/106',
          idPost: 3,
        ),
        PostImage(
          id: 2,
          imageUrl: 'https://picsum.photos/107',
          idPost: 3,
        ),
        PostImage(
          id: 2,
          imageUrl: 'https://picsum.photos/108',
          idPost: 3,
        ),
      ],
      idCreator: 1,
    ),
    Post(
      id: 1,
      profileImage: 'https://picsum.photos/504',
      category: 'Restaurante',
      localName: 'La Parrilla Dorada',
      title: 'La Parrilla Dorada: ¡Satisfacción garantizada!',
      date: 'Hace 3 h',
      body: 'Satisface tus antojos culinarios en nuestro restaurante La Parrilla Dorada',
      images: [
        PostImage(
          id: 1,
          imageUrl: 'https://picsum.photos/109',
          idPost: 3,
        ),
        PostImage(
          id: 2,
          imageUrl: 'https://picsum.photos/110',
          idPost: 3,
        ),
        PostImage(
          id: 2,
          imageUrl: 'https://picsum.photos/111',
          idPost: 3,
        ),
      ],
      idCreator: 1,
    ),
  ];
}


