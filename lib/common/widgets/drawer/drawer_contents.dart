import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/responsive/responsive.dart';
import '../../../app/routes/telegram_story_pages.dart';
import '../../constant/constant_mesurements.dart';

class DrawerContent extends StatelessWidget {
  const DrawerContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.zero)),
      child: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: TSDefaultMeasurement.defaultPadding),
        children: [
          const SizedBox(
            height: 70,
          ),
          Icon(Icons.person_2_rounded),
          SizedBox(
            height: TSResponsive.isDesktop(context) ? 40 : 26,
          ),
          const Divider(),
          SizedBox(
            height: TSResponsive.isDesktop(context) ? 40 : 26,
          ),
          drawerTile(' Home ', Icon(Icons.home), 0, TSRoutes.home, () {
            Get.offAndToNamed(TSRoutes.home);
          }, context),
          drawerTile(' Messages', Icon(Icons.supervised_user_circle_outlined),
              1, TSRoutes.messages, () {
            Get.offAndToNamed(TSRoutes.messages);
          }, context),
          drawerTile(
              ' profile ', Icon(Icons.person_pin_rounded), 2, TSRoutes.profile,
              () {
            Get.offAndToNamed(TSRoutes.profile);
          }, context),
        ],
      ),
    );
  }

  Widget drawerTile(String title, Widget leading, int index, String viewPath,
      VoidCallback onPressed, BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Match the hover radius
        ),
        visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
        leading: leading,
        title: Text(
          ' $title ',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        selected: Get.currentRoute == viewPath,
        onTap: Get.currentRoute == viewPath ? null : onPressed,
      ),
    );
  }
}
