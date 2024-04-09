import 'package:app_merchants_association/src/model/user.dart';
import 'package:app_merchants_association/src/ui/widgets/card/user_card.dart';
import 'package:app_merchants_association/src/ui/widgets/dialog/create_user_dialog.dart';
import 'package:app_merchants_association/src/utils/dialog_manager.dart';
import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';

class UserManage extends StatefulWidget {
  const UserManage({super.key});

  @override
  State<UserManage> createState() => _UserManageState();
}

class _UserManageState extends State<UserManage> {
  List<User> users = [];

  @override
  void initState() {
    users = getUsers();
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
      body: _content(),
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

  List<User> getUsers() {
    List<User> usersList = [
      User(
          id: 1,
          name: "Manel",
          password: "password",
          address: "address",
          schedule: "schedule",
          image: "image",
          sector: 1),
      User(
          id: 1,
          name: "Manel",
          password: "password",
          address: "address",
          schedule: "schedule",
          image: "image",
          sector: 1),
      User(
          id: 1,
          name: "Oscar",
          password: "password",
          address: "address",
          schedule: "schedule",
          image: "image",
          sector: 1),
      User(
          id: 1,
          name: "Manel",
          password: "password",
          address: "address",
          schedule: "schedule",
          image: "image",
          sector: 1),
      User(
          id: 1,
          name: "Lorenzo",
          password: "password",
          address: "address",
          schedule: "schedule",
          image: "image",
          sector: 1),
      User(
          id: 1,
          name: "Manel",
          password: "password",
          address: "address",
          schedule: "schedule",
          image: "image",
          sector: 1),
      User(
          id: 1,
          name: "Marguax",
          password: "password",
          address: "address",
          schedule: "schedule",
          image: "image",
          sector: 1),
      User(
          id: 1,
          name: "Manel",
          password: "password",
          address: "address",
          schedule: "schedule",
          image: "image",
          sector: 1),
      User(
          id: 1,
          name: "A",
          password: "password",
          address: "address",
          schedule: "schedule",
          image: "image",
          sector: 1),
      User(
          id: 1,
          name: "Manel",
          password: "password",
          address: "address",
          schedule: "schedule",
          image: "image",
          sector: 1),
      User(
          id: 1,
          name: "Aduwuwfw",
          password: "password",
          address: "address",
          schedule: "schedule",
          image: "image",
          sector: 1),
      User(
          id: 1,
          name: "Manel",
          password: "password",
          address: "address",
          schedule: "schedule",
          image: "image",
          sector: 1),
      User(
          id: 1,
          name:
              "efuieuieigueueueueueueueueueueueueueueueueueueueueueueueueueeueueuu",
          password: "password",
          address: "address",
          schedule: "schedule",
          image: "image",
          sector: 1),
      User(
          id: 1,
          name: "Manel",
          password: "password",
          address: "address",
          schedule: "schedule",
          image: "image",
          sector: 1),
      User(
          id: 1,
          name: "AAAFwf",
          password: "password",
          address: "address",
          schedule: "schedule",
          image: "image",
          sector: 1),
      User(
          id: 1,
          name: "Manel",
          password: "password",
          address: "address",
          schedule: "schedule",
          image: "image",
          sector: 1),
      User(
          id: 1,
          name: "Cpcp",
          password: "password",
          address: "address",
          schedule: "schedule",
          image: "image",
          sector: 1),
      User(
          id: 1,
          name: "Manel",
          password: "password",
          address: "address",
          schedule: "schedule",
          image: "image",
          sector: 1),
      User(
          id: 1,
          name: "Coco",
          password: "password",
          address: "address",
          schedule: "schedule",
          image: "image",
          sector: 1),
      User(
          id: 1,
          name: "Manel",
          password: "password",
          address: "address",
          schedule: "schedule",
          image: "image",
          sector: 1),
      User(
          id: 1,
          name: "Albaro",
          password: "password",
          address: "address",
          schedule: "schedule",
          image: "image",
          sector: 1),
      User(
          id: 1,
          name: "Manel",
          password: "password",
          address: "address",
          schedule: "schedule",
          image: "image",
          sector: 1),
      User(
          id: 1,
          name: "Joseluis",
          password: "password",
          address: "address",
          schedule: "schedule",
          image: "image",
          sector: 1),
      User(
          id: 1,
          name: "Manel",
          password: "password",
          address: "address",
          schedule: "schedule",
          image: "image",
          sector: 1),
      User(
          id: 1,
          name: "Luci",
          password: "password",
          address: "address",
          schedule: "schedule",
          image: "image",
          sector: 1),
      User(
          id: 1,
          name: "Manel",
          password: "password",
          address: "address",
          schedule: "schedule",
          image: "image",
          sector: 1),
      User(
          id: 1,
          name: "Carla",
          password: "password",
          address: "address",
          schedule: "schedule",
          image: "image",
          sector: 1),
      User(
          id: 1,
          name: "Manel",
          password: "password",
          address: "address",
          schedule: "schedule",
          image: "image",
          sector: 1),
      User(
          id: 1,
          name: "Gay",
          password: "password",
          address: "address",
          schedule: "schedule",
          image: "image",
          sector: 1),
      User(
          id: 1,
          name: "Manel",
          password: "password",
          address: "address",
          schedule: "schedule",
          image: "image",
          sector: 1),
      User(
          id: 1,
          name: "ooooo",
          password: "password",
          address: "address",
          schedule: "schedule",
          image: "image",
          sector: 1),
      User(
          id: 1,
          name: "Manel",
          password: "password",
          address: "address",
          schedule: "schedule",
          image: "image",
          sector: 1),
      User(
          id: 1,
          name: "increible",
          password: "password",
          address: "address",
          schedule: "schedule",
          image: "image",
          sector: 1),
      User(
          id: 1,
          name: "Manel",
          password: "password",
          address: "address",
          schedule: "schedule",
          image: "image",
          sector: 1),
      User(
          id: 1,
          name: "qqqqoqqqq",
          password: "password",
          address: "address",
          schedule: "schedule",
          image: "image",
          sector: 1),
      User(
          id: 1,
          name: "Manel",
          password: "password",
          address: "address",
          schedule: "schedule",
          image: "image",
          sector: 1),
      User(
          id: 1,
          name: "eeeeeoeeeeoeeeeoeeeeoeeeeeo",
          password: "password",
          address: "address",
          schedule: "schedule",
          image: "image",
          sector: 1),
      User(
          id: 1,
          name: "Manel",
          password: "password",
          address: "address",
          schedule: "schedule",
          image: "image",
          sector: 1),
      User(
          id: 1,
          name: "aaaaaaaaaoaaaaoaaaaoaaao",
          password: "password",
          address: "address",
          schedule: "schedule",
          image: "image",
          sector: 1),
      User(
          id: 1,
          name: "Manel",
          password: "password",
          address: "address",
          schedule: "schedule",
          image: "image",
          sector: 1),
    ];
    return usersList;
  }
}
