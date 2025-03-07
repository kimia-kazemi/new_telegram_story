import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telegram_story/app/responsive/responsive.dart';
import 'package:telegram_story/app/routes/telegram_story_pages.dart';
import 'package:telegram_story/common/constant/constant_mesurements.dart';
import 'package:telegram_story/views/root/widgets/mobile/bottom_navigation_bar.dart';
import 'package:telegram_story/views/root/widgets/common/user_story_tile.dart';
import '../../common/widgets/drawer/drawer_contents.dart';
import '../../common/widgets/stacked_row_widgets/stack_row_widgets.dart';
import '../../controllers/root/root_controller.dart';

class RootPage extends GetView<RootController> {
  const RootPage({super.key, required this.body});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<RootController>(
          id: 'storyList',
          builder: (_) {
            return TSResponsive(
              desktop: Scaffold(
                body: Row(
                  spacing: TSDefaultMeasurement.defaultDesktopPadding,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 5,
                        child: Card(
                          color: Colors.grey[200],
                          child: ListView(
                            children: [
                              controller.isLoadingStories.value
                                  ? Center(
                                      child: SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  : SizedBox(
                                      height: 120,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            controller.userStoryList.length,
                                        itemBuilder: (context, index) {
                                          return UserStoryTile(
                                            userStory:
                                                controller.userStoryList[index],
                                            onTap: () {
                                              controller.isCollapsed.value
                                                  ? controller.expandAppBar()
                                                  : controller.openStory(index);
                                            },
                                          ).marginOnly(
                                              right: TSDefaultMeasurement
                                                  .defaultPadding);
                                        },
                                      ),
                                    ),
                              body
                            ],
                          ),
                        )),
                    Card(child: const DrawerContent()),
                  ],
                ),
              ),
              mobile: Scaffold(
                backgroundColor: Colors.white,
                body: CustomScrollView(
                  controller: controller.scrollController,
                  slivers: [
                    SliverAppBar(
                      centerTitle: true,
                      expandedHeight: 120,
                      collapsedHeight: 60,
                      floating: false,
                      pinned: true,
                      flexibleSpace: LayoutBuilder(
                        builder: (context, constraints) {
                          //current height
                          double maxHeight = constraints.maxHeight;
                          //shrinkOffset is remaind space of appbar
                          double shrinkOffset = maxHeight - kToolbarHeight;
                          //for Scaling control and transforming the animation position
                          double normalizedShrink =
                              shrinkOffset / (20 - kToolbarHeight);
                          return FlexibleSpaceBar(
                            titlePadding: EdgeInsets.only(left: 40),
                            title: buildStackedImages(normalizedShrink),
                          );
                        },
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate([
                        body,
                      ]),
                    )
                  ],
                ),
                bottomNavigationBar: myBottomNavigationBar((value) {
                  switch (value) {
                    case 0:
                      Get.toNamed(TSRoutes.home);
                      break;
                    case 1:
                      Get.toNamed(TSRoutes.messages);
                      break;
                    case 2:
                      Get.toNamed(TSRoutes.profile);
                      break;
                    default:
                      Get.toNamed(TSRoutes.home);
                      break;
                  }
                }),
                drawer: const DrawerContent(),
              ),
            );
          }),
    );
  }

  Widget buildStackedImages(double normalizedShrink) {
    //making space between each story
    const double xShift = 25;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          StackedWidgets(
            items: List.generate(controller.userStoryList.length, (index) {
              return UserStoryTile(
                userStory: controller.userStoryList[index],
                onTap: () {
                  controller.isCollapsed.value
                      ? controller.expandAppBar()
                      : controller.openStory(index);
                },
              );
            }),
            xShift: xShift *
                (1 - normalizedShrink),
          ),
        ],
      ),
    );
  }
}
