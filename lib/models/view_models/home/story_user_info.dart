import 'package:get/get.dart';
import 'package:telegram_story/models/view_models/home/story_view_models.dart';

class UserStoryViewModel {
  final String name;
  final String avatar;
  final String id;
  final bool isAdmin;
  int numberOfStories;
  int seenStoriesNum;
  int unSeenId;
  RxList<StoryViewModels> media;

  UserStoryViewModel({
    required this.name,
    required this.avatar,
    required this.isAdmin,
    required this.numberOfStories,
    required this.seenStoriesNum,
    required this.id,
    required this.unSeenId,
    required this.media,
  });

  factory UserStoryViewModel.fromJson(Map<String, dynamic> json) {
    return UserStoryViewModel(
      name: json["name"],
      id: json["id"],
      isAdmin: json["is_admin"],
      unSeenId: json["unseen_id"],
      seenStoriesNum: json["seen_stories"],
      numberOfStories: json["number_of_stories"],
      avatar: json["avatar"],
      media: RxList<StoryViewModels>.from(
          (json["media"] as List).map((x) => StoryViewModels.fromJson(x))),
    );
  }
}
