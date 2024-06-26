import 'package:app_merchants_association/src/api/api_client.dart';
import 'package:app_merchants_association/src/config/app_styles.dart';
import 'package:app_merchants_association/src/utils/dialog_manager.dart';
import 'package:app_merchants_association/src/utils/helpers/user_helper.dart';
import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserCard extends StatefulWidget {
  const UserCard({super.key, required this.user, required this.reloadScreen});

  final String user;
  final Function reloadScreen;

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: _cardContent(),
      ),
    );
  }

  Widget _cardContent(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          const Icon(
            Icons.person,
            size: 50,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                widget.user,
                style: AppStyles.textTheme.titleMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const SizedBox(width: 5,),
          ElevatedButton(
            onPressed: () async => await showDeleteDialog(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryRed,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),

              ),
            ),
            child: Text(
                AppLocalizations.of(context)!.delete
            ),
          )
        ],
      ),
    );
  }

  showDeleteDialog() async {
    await DialogManager().showDeleteDialog(
      context: context,
      title: AppLocalizations.of(context)!.atention,
      text: AppLocalizations.of(context)!.delete_user_confirm,
      onDelete: deleteUser
    );
  }

  deleteUser() async {
    var response = await ApiClient().deleteEmployer(widget.user, UserHelper.shop!.id!);


    widget.reloadScreen();
  }
}
