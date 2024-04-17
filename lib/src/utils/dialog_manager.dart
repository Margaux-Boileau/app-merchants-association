import 'package:flutter/material.dart';
import '../config/app_colors.dart';
import '../config/app_styles.dart';
import '../ui/widgets/dialog/create_user_dialog.dart';

class DialogManager{

  showSimpleDialog(
      {BuildContext? context,
      String? title,
      String? content,
      Function? onAccept,
      Function? onCancel}){
    showDialog(
        context: context!,
        builder: ((_) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 40,),
          child: SimpleDialog(
            backgroundColor: AppColors.white,
            elevation: 0,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            title: Text(
              title!,
              style: AppStyles.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    content!,
                    style: AppStyles.textTheme.bodyMedium?.copyWith(color: AppColors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: (){
                        if(onCancel != null){
                          onCancel();
                        }
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Cancelar",
                      ),
                    ),
                    TextButton(
                      onPressed: (){
                        if(onAccept != null){
                          onAccept();
                        }
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Aceptar",
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20,)
            ],
          ),
        ))
    );
  }

  showDeleteDialog(
      {required BuildContext context,
      required String title,
      required String text,
      Function? onCancel,
      Function? onDelete}){
    showDialog(
        context: context,
        builder: ((_) => SimpleDialog(

          backgroundColor: AppColors.white,
          elevation: 0,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          title: Text(
            title,
            style: AppStyles.textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  text,
                  style: AppStyles.textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: (){
                      if(onCancel != null){
                        onCancel();
                      }
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.appGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),

                      ),
                    ),
                    child: const Text(
                        "Cancelar"
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if(onDelete != null){
                        onDelete();
                      }
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryRed,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),

                      ),
                    ),
                    child: const Text(
                        "Eliminar"
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20,)
          ],
        ))
    );
  }

  showRegisterDialog(BuildContext context){
    showDialog(
        context: context,
        builder: (_) => const CreateUserDialog()
    );
  }

}