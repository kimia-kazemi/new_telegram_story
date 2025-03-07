import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/routes/telegram_story_pages.dart';

class UnknownPage extends StatelessWidget {
  const UnknownPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            spacing: 24,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                  "404",
                  style:
                  Get.textTheme.displaySmall
              ),
              Text(
                  "The page you looking for, not found",
              ),
              ElevatedButton(
                child:const Text(
                    'Go back to Home page'
                ),
                onPressed: () => Get.offAndToNamed(TSRoutes.home),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
