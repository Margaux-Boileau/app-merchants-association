import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_styles.dart';


class ForumCard extends StatelessWidget {
  const ForumCard({super.key});

  @override
  Widget build(BuildContext context) {
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
            children: [
              Row(
                children: [
                  // Imagen
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: Container(
                      width: 55,
                      height: 55,
                      decoration:
                      BoxDecoration(color: AppColors.background),
                      child: Image.network(
                        // TODO Cambiar por la imagen del usuario
                        'https://picsum.photos/200',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(width: 15.0),
                  // Column ('Title' | Row('Category', 'Send text'))
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Cafè els amics",
                        style: AppStyles.textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.w700, fontSize: 19.0
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.4),
                        decoration: BoxDecoration(
                          color: AppColors.primaryBlue.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: Text(
                            // TODO Cambiar por el nombre del usuario
                            'Cafeteria i granja',
                            overflow: TextOverflow.ellipsis,
                            style:
                            AppStyles.textTheme.bodySmall!.copyWith(
                              color: AppColors.white,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),
                    ],
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
