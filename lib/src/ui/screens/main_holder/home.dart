import 'package:app_merchants_association/src/config/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../config/app_colors.dart';
import '../../widgets/forum/forum_card.dart';

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
            const ForumCard(),
          ],
        ),
      ),
    );
  }
}


