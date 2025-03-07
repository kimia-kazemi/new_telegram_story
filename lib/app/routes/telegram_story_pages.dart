import 'package:get/get.dart';
import 'package:telegram_story/views/message/message_page.dart';
import 'package:telegram_story/views/profile/profile_page.dart';
import '../../views/home_page/home_page.dart';
import '../../views/root/root_page.dart';
import '../../views/root/widgets/common/story_page.dart';
import '../bindings/root/root_binding.dart';
part 'telegram_story_routes.dart';

class TSPages {
  static const initial = TSRoutes.home;

  static final List<GetPage> routes = [
    GetPage(
      name: TSRoutes.home,
      page: () => RootPage(
        body: HomeBody(),
      ),
      transition: Transition.noTransition,
      binding: RootBinding()
    ),
    GetPage(
      name: TSRoutes.story(""),
      page: () => StoryPage(),
      transition: Transition.cupertinoDialog,
    ),
    GetPage(
      name: TSRoutes.profile,
      page: () => RootPage(body: const ProfilePage()),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: TSRoutes.messages,
      page: () => RootPage(body: const MessagePage()),
      transition: Transition.noTransition,
    ),
  ];
}
