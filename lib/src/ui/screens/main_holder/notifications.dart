import 'package:app_merchants_association/src/config/app_styles.dart';
import 'package:app_merchants_association/src/utils/helpers/notification_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../config/app_colors.dart';
import '../../../model/PushNotificaton.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<PushNotification> notificationsList = [];

  @override
  void initState() {
    super.initState();
    getNotifications();
  }

  getNotifications() async {
    notificationsList = await NotificationManager.getNotifications();
    setState(() {});
  }

  removeNotification(int index) {
    notificationsList.removeAt(index);
    NotificationManager.saveDeletedNotifications(notificationsList);
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: notificationsList.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListView.builder(
                itemCount: notificationsList.length,
                itemBuilder: (BuildContext context, int index) {
                  if (notificationsList[index].content != null &&
                      notificationsList[index].title != null) {
                    return notificationCard(notificationsList[index], index);
                  } else {
                    return Container();
                  }
                },
              ),
            )
          : Center(
              child: Text(
                AppLocalizations.of(context)!.no_notifications,
                textAlign: TextAlign.center,
                style: AppStyles.textTheme.labelLarge,
              ),
            ),
    );
  }

  Widget notificationCard(PushNotification notification, int index) {
    return Padding(
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
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Icon(
                Icons.notifications_active,
                color: AppColors.primaryBlue,
                size: 30,
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.title!,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.textTheme.labelLarge!
                          .copyWith(fontWeight: FontWeight.w700, fontSize: 16.0),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      notification.content!,
                      textAlign: TextAlign.justify,
                      style: AppStyles.textTheme.labelSmall,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              IconButton(
                onPressed: () => removeNotification,
                icon: Icon(
                  Icons.close,
                  color: AppColors.appLightGrey,
                  size: 30,
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
