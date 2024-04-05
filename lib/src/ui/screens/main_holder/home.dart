import 'package:app_merchants_association/src/config/app_styles.dart';
import 'package:app_merchants_association/src/model/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import '../../../config/app_colors.dart';
import '../../../model/post_image.dart';
import '../../widgets/forum/forum_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Llave para el Scaffold para poder abrir el drawer desde el appbar.
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Lista de categorías para el menú lateral (temporal)
  final List<String> categories = [
    'Activitats de la construcció',
    'Aparcament',
    'Arranjament de roba i sabates i claus',
    'Artesania',
    'Articles per a nens',
    'Arts Gràfiques',
    'Assegurances',
    'Audiovisual',
    'Bar de tapes',
    'Basar',
    'Cafeteria i granja',
    'Cansaladeria',
    'Carnisseria',
    'Celler',
    'Centres Mèdics',
    'Centres comercials i supermercats',
    'Dietètica',
    'Dolços i pastissos',
    'Electrodomèstics',
    'Escola',
    'Escola de ball',
    'Especialitats',
    'Estanc',
    'Estètica i bellesa',
    'Farmàcia i ortopèdia',
    'Ferreteria',
    'Fisioteràpia',
    'Floristeria',
    'Forn de pa',
    'Fruita i verdura',
    'Gelateries',
    'Gimnàs i acadèmia',
    'Hotels i similars',
    'Immobiliària',
    'Informàtica',
    'Instal·lacions i subministraments',
    'Jocs i atraccions',
    'Joieria, rellotjeria i bijuteria',
    'Llar, decoració i mobiliari',
    'Llegums i cereals',
    'Loteries i apostes de l\'Estat',
    'Mascotes',
    'Materials de construcció',
    'Menjar ràpid',
    'Merceria i llenceria',
    'Mobles i articles de fusta i metall',
    'Música',
    'Odontologia',
    'Papereria, llibreria i copisteria',
    'Perfumeria i drogueria',
    'Perruqueria',
    'Regals i souvenirs',
    'Restaurant',
    'Roba i complements',
    'Sabateria',
    'Serveis professionals',
    'Taller mecànic',
    'Varietats',
    'Xarcuteria i embotits',
    'Òptica'
  ];

  String currentCategory = 'General';

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
            // TODO Mostrar snackbar de momento
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Crear foro'),
              ),
            );
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
              DrawerHeader(
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue,
                ),
                child: SvgPicture.asset(
                  'assets/images/LogoSants.svg',
                  height: 50.0, // Ajusta la altura de la imagen
                  width: 50.0, // Ajusta la anchura de la imagen
                  color: AppColors.black,
                ),
              ),
              // Genera los ListTile para cada categoría
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      categories[index],
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 15.0,
                      ),
                    ),
                    tileColor: index % 2 == 0 ? Colors.white : Colors.grey[100],
                    onTap: () {
                      setState(() {
                        currentCategory = categories[index]; // Actualiza la categoría actual
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
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
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
          ),
        ),
      ],
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
      body:
          ' ¡Disfruta del mejor café de la ciudad en un ambiente acogedor! En Café El Aroma, nos enorgullecemos de servir café de alta calidad y deliciosos pasteles caseros. ¡Ven y relájate con nosotros!',
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
      body:
          'Descubre las últimas tendencias en moda en nuestra tienda Fashion Trends. Desde elegantes vestidos hasta cómodos conjuntos casuales, tenemos todo lo que necesitas para lucir fabuloso en cualquier ocasión.',
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
      body:
          'Encuentra el par de zapatos perfecto para complementar tu estilo en Footwear Haven. Con una amplia selección de calzado de marcas reconocidas, estamos aquí para satisfacer todas tus necesidades de calzado.',
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
      body:
          'Satisface tus antojos culinarios en nuestro restaurante La Parrilla Dorada',
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
    Post(
      id: 5,
      profileImage: 'https://picsum.photos/505',
      category: 'Bar de tapes',
      localName: 'Tapas deliciosas',
      title: 'Ven a disfrutar de nuestras tapas exquisitas',
      date: 'Hace 4 h',
      body:
      'En Tapas deliciosas, te ofrecemos una amplia variedad de tapas españolas tradicionales y creativas para satisfacer tu paladar. ¡No te lo pierdas!',
      images: [
        PostImage(
          id: 1,
          imageUrl: 'https://picsum.photos/112',
          idPost: 5,
        ),
        PostImage(
          id: 2,
          imageUrl: 'https://picsum.photos/113',
          idPost: 5,
        ),
      ],
      idCreator: 1,
    ),
    // Post para la categoría de "Escola"
    Post(
      id: 6,
      profileImage: 'https://picsum.photos/506',
      category: 'Escola',
      localName: 'Academia de idiomas Bright',
      title: 'Aprende idiomas con los mejores profesionales',
      date: 'Hace 5 h',
      body:
      'En Academia de idiomas Bright, ofrecemos cursos de idiomas impartidos por profesores altamente calificados y con amplia experiencia. ¡Únete a nosotros y mejora tus habilidades lingüísticas!',
      images: [],
      idCreator: 1,
    ),
    Post(
      id: 7,
      profileImage: 'https://picsum.photos/507',
      category: 'Joieria, rellotjeria i bijuteria',
      localName: 'Gems & Watches',
      title: 'Descubre las joyas más elegantes y los relojes más finos',
      date: 'Hace 6 h',
      body:
      'En Gems & Watches, te ofrecemos una selección exclusiva de joyas preciosas y relojes de lujo de las mejores marcas. Visítanos y encuentra la pieza perfecta para complementar tu estilo.',
      images: [
        PostImage(
          id: 1,
          imageUrl: 'https://picsum.photos/114',
          idPost: 7,
        ),
        PostImage(
          id: 2,
          imageUrl: 'https://picsum.photos/115',
          idPost: 7,
        ),
      ],
      idCreator: 1,
    ),
  ];
}
