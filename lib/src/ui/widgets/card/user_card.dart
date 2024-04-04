import 'package:app_merchants_association/src/config/app_styles.dart';
import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';
import '../../../model/user.dart';

class UserCard extends StatelessWidget {
  UserCard({super.key, required this.user});

  late final User user;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
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
        child: _cardContent(),
      ),
    );
  }

  Widget _cardContent(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
      child: Row(
        children: [
          const Icon(
            Icons.person,
            size: 50,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                user.name!,
                style: AppStyles.textTheme.titleMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const SizedBox(width: 5,),
          ElevatedButton(
            onPressed: () => deleteUser(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryRed,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),

              ),
            ),
            child: Text(
              "Eliminar"
            ),
          )
        ],
      ),
    );
  }

  deleteUser(){

  }
}
