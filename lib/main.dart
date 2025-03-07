import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telegram_story/views/unknown_page/unknown_page.dart';
import 'app/routes/telegram_story_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Telegram Story',
      debugShowCheckedModeBanner: false,
      getPages: TSPages.routes,
      initialRoute: TSPages.initial,
      unknownRoute: GetPage(
          name: TSRoutes.notFound, page: () => const UnknownPage()),
    );
  }
}
