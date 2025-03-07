import 'package:flutter/material.dart';
import '../../../../common/widgets/dotted_border/doted_border.dart';
import '../../../../models/view_models/home/story_user_info.dart';

class UserStoryTile extends StatelessWidget {
  const UserStoryTile(
      {super.key, required this.userStory, required this.onTap});

  final UserStoryViewModel userStory;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap.call(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            alignment: Alignment.center,
            children: [
              //regarding a constant max size for each user story tile which is 50
              SizedBox(
                width: 50,
                height: 50,
                child: CustomPaint(
                  painter: DottedBorder(
                      numberOfSeen: userStory.seenStoriesNum,
                      numberOfStories: userStory.numberOfStories,
                      spaceLength: 4),
                ),
              ),
              Container(
                //0.9 percent smaller that tacked dotted box
                width: 50 * 0.9,
                height: 50 * 0.9,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(userStory.avatar),
                    fit: BoxFit.fill,
                  ),
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
