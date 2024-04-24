import 'package:app_merchants_association/src/api/api_client.dart';
import 'package:app_merchants_association/src/model/user.dart';
import 'package:app_merchants_association/src/ui/widgets/card/user_card.dart';
import 'package:app_merchants_association/src/ui/widgets/dialog/create_user_dialog.dart';
import 'package:app_merchants_association/src/utils/dialog_manager.dart';
import 'package:app_merchants_association/src/utils/helpers/user_helper.dart';
import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';

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
        title: const Text("Usuarios"),
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
      body: users.isNotEmpty ? _content() : Text("No hay empleados"),
    );
  }

  Widget _content(){
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          return UserCard(user: users[index]);
        },
      ),
    );
  }

  void showCreateDialog(){
    DialogManager().showRegisterDialog(context);
  }

  getUsers() async {
    var employeesList = await ApiClient().getShopEmployees(UserHelper.shop!.id!);
    users = employeesList;
    setState(() {
      
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
