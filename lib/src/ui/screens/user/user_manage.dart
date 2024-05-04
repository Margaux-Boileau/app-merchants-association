import 'package:app_merchants_association/src/api/api_client.dart';
import 'package:app_merchants_association/src/config/app_styles.dart';
import 'package:app_merchants_association/src/model/user.dart';
import 'package:app_merchants_association/src/ui/widgets/card/user_card.dart';
import 'package:app_merchants_association/src/ui/widgets/dialog/create_user_dialog.dart';
import 'package:app_merchants_association/src/utils/dialog_manager.dart';
import 'package:app_merchants_association/src/utils/helpers/user_helper.dart';
import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserManage extends StatefulWidget {
  const UserManage({super.key});

  @override
  State<UserManage> createState() => _UserManageState();
}

class _UserManageState extends State<UserManage> {
  List<String> users = [];

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.users),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showCreateDialog(),
        backgroundColor: AppColors.primaryBlue,
        child: Icon(
          Icons.add,
          color: AppColors.white,
        ),
      ),
      body: users.isNotEmpty ? _content() : Center(child: Text(AppLocalizations.of(context)!.no_employees,style: AppStyles.textTheme.bodyLarge,)),
    );
  }

  Widget _content(){
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          return UserCard(user: users[index], reloadScreen: getUsers,);
        },
      ),
    );
  }

  Future<void> showCreateDialog() async {
    await DialogManager().showRegisterDialog(context);
    getUsers();
  }

  getUsers() async {
    users = [];
    var employeesList = await ApiClient().getShopEmployees(UserHelper.shop!.id!);
    users = employeesList;
    setState(() {
      
    });
  }
}
