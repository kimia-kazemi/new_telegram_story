import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telegram_story/views/root/widgets/common/story_content.dart';
import '../../../../app/responsive/responsive.dart';
import '../../../../common/constant/constant_mesurements.dart';
import '../../../../common/debouncer/debouncer.dart';
import '../../../../common/widgets/video_player/custom_video_player.dart';
import '../../../../controllers/root/root_controller.dart';

class StoryPage extends GetView<RootController> {
  StoryPage({super.key});

  final Debouncer _debouncer = Debouncer(milliseconds: 500);
  final int userIndex = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RootController>(
        id: 'storyFrame',
        builder: (_) {
          if (controller.storyList.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          int currentIndex = controller.findFirstUnseenMediaIndex();
          return Stack(
            children: [
              GestureDetector(
                onTapDown: (details) => controller.onTapDown(details),
                onVerticalDragUpdate: (dragDetails) =>
                    controller.onVerticalDragUpdate(dragDetails),
                onLongPress: controller.pauseStory,
                onLongPressUp: controller.resumeStory,
                child: controller.storyList[currentIndex].type == 'video'
                    ? CustomVideoPlayer(
                        url: controller.storyList[currentIndex].url)
                    : ImageFrame(url: controller.storyList[currentIndex].url),
              ),
              Positioned(
                top: TSDefaultMeasurement.defaultDesktopPadding,
                left: 0,
                right: 0,
                child: Row(
                  children: List.generate(
                    controller.storyList.length,
                    (index) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: AnimatedBuilder(
                          animation: controller.progressController,
                          builder: (context, child) {
                            return LinearProgressIndicator(
                              value: index == currentIndex
                                  ? controller.progressController.value
                                  : (index < currentIndex ? 1.0 : 0.0),
                              backgroundColor: Colors.grey[500],
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  index <= currentIndex
                                      ? Colors.white
                                      : Colors.grey),
                              minHeight: 8,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (controller.userStoryList[userIndex].isAdmin)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    margin: EdgeInsets.all(
                        TSDefaultMeasurement.defaultDesktopPadding),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        controller.pauseStory();
                        Get.bottomSheet(
                          Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.all(16),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16)),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextButton(
                                  onPressed: () => _debouncer.run(() {
                                    controller.onDeleteStory(
                                        currentIndex, userIndex);
                                  }),
                                  child: const Text('delete story',
                                      style: TextStyle(color: Colors.red)),
                                ),
                                const SizedBox(height: 10),
                                TextButton(
                                  onPressed: () => _debouncer.run(() {
                                    Get.back();
                                  }),
                                  child: const Text('back'),
                                ),
                              ],
                            ),
                          ),
                        ).then((_) => controller.resumeStory());
                      },
                      icon: const Icon(Icons.more_vert),
                    ),
                  ),
                ),
              if(TSResponsive.isDesktop(context))
                Positioned(
                  left: 0,
                  top: TSDefaultMeasurement.defaultPadding,
                  child: Container(
                    margin: EdgeInsets.all(
                        TSDefaultMeasurement.defaultDesktopPadding),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ),
                ),
            ],
          );
        });
  }
}
