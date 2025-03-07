import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import '../../app/routes/telegram_story_pages.dart';
import '../../models/view_models/home/story_user_info.dart';
import 'package:telegram_story/models/view_models/home/story_view_models.dart';

class RootController extends GetxController with GetTickerProviderStateMixin {
  RootController();

  RxList<UserStoryViewModel> userStoryList = <UserStoryViewModel>[].obs;
  RxList<StoryViewModels> storyList = <StoryViewModels>[].obs;

  RxBool isLoadingStories = true.obs;
  final isCollapsed = false.obs;
  var isVideoInitialized = false.obs;

  RxInt unseenMediaIndex = 0.obs;
  int userStoryIndex = 0;
  late AnimationController progressController;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
    loadStories();
  }

  void openStory(int index) {
    userStoryIndex = index;
    storyList.assignAll(userStoryList[index].media);
    int unseenIndex = findFirstUnseenMediaIndex();

    //if any media left
    if (unseenIndex != -1) {
      _startAnimation(unseenIndex);
      Get.toNamed(
        TSRoutes.story(userStoryList[userStoryIndex].id),
        arguments: userStoryIndex,
      );
    }
  }

  int findFirstUnseenMediaIndex() {
    int unseenIndex = storyList.indexWhere(
        (element) => element.id == userStoryList[userStoryIndex].unSeenId);
    return unseenIndex != -1 ? unseenIndex : 0;
  }

  void _startAnimation(int storyIndex) {
    int unseenIndex = findFirstUnseenMediaIndex();

    progressController = AnimationController(
      vsync: this,
      duration: storyList[storyIndex].duration,
    );

    progressController.forward().then((value) {
      _resetProgress();
      nextStory(unseenIndex);
    });
  }

  void nextStory(int unseenIndex) {
    _resetProgress();

    int nextIndex = unseenIndex + 1;
    if (nextIndex < storyList.length) {
      seenStory(storyList[nextIndex].id); // Mark as seen
      // unseenMediaIndex.value = nextIndex;
      update(['storyFrame']);

      _startAnimation(nextIndex);
    } else {
      //end of media of current user
      Get.back();
    }
  }

  void previousStory(int unseenIndex) {
    _resetProgress();

    int prevIndex = unseenIndex - 1;
    if (prevIndex >= 0) {
      seenStory(storyList[prevIndex].id); // Mark as seen
      // unseenMediaIndex.value = prevIndex;
      update(['storyFrame']);
      _startAnimation(prevIndex);
    }
  }

  void _resetProgress() {
    progressController.stop(); // Stop any ongoing animation
    progressController.reset(); // Reset animation progress to 0
  }

  void seenStory(int mediaId) {
    int index = storyList.indexWhere((element) => element.id == mediaId);
    if (index != -1) {
      userStoryList[userStoryIndex].unSeenId = storyList[index].id;
    }
  }

  void pauseStory() {
    progressController.stop();
  }

  void resumeStory() {
    progressController.forward();
  }

  void onTapDown(TapDownDetails details) {
    final double screenWidth = MediaQuery.of(Get.context!).size.width;
    final double dx = details.globalPosition.dx;

    double leftThreshold = screenWidth * 0.3; // 30% from the left
    double rightThreshold =
        screenWidth * 0.7; // 70% from the left (30% from the right)

    if (dx < leftThreshold) {
      // Tap on the left 30% → Go to the previous story
      // percentWatched[unseenMediaIndex.value] = 0;
      int unseenIndex = findFirstUnseenMediaIndex();

      previousStory(unseenIndex);
    } else if (dx > rightThreshold) {
      // Tap on the right 30% → Go to the next story
      // percentWatched[unseenMediaIndex.value] = 1.0;
      int unseenIndex = findFirstUnseenMediaIndex();

      nextStory(unseenIndex);
    }
  }

  void onVerticalDragUpdate(DragUpdateDetails dragDetails) {
    if (dragDetails.primaryDelta! > 10) {
      Get.back();
    }
  }

  void _scrollListener() {
    isCollapsed.value = scrollController.offset > 60;
  }

  void expandAppBar() {
    scrollController.animateTo(0.0,
        duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  @override
  void onClose() {
    progressController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  Future<void> loadStories() async {
    isLoadingStories(true);
    update(['storyList']);

    final String jsonString =
        await rootBundle.loadString('assets/story/stories.json');
    final List<dynamic> jsonData = jsonDecode(jsonString);
    userStoryList.value =
        jsonData.map((data) => UserStoryViewModel.fromJson(data)).toList();
    isLoadingStories(false);
    update(['storyList']);
  }

  void onDeleteStory(int index, int userIndex) {
    storyList.removeAt(index);
    userStoryList[userIndex].numberOfStories--;
    userStoryList[userIndex].media.removeAt(index);
    update(['storyList']);
    update(['storyFrame']);
    Get.back();
  }
}
