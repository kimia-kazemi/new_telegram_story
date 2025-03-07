part of 'telegram_story_pages.dart';


abstract class TSRoutes {
  static const String notFound = '/not-found';
  static const String home = '/home';
  static const String messages = '/messages';
  static const String profile = '/profile';
  static String story(String val) => (val != "") ? '/story/$val' : '/story/:storyId';
}