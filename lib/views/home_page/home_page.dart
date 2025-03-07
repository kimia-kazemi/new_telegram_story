import 'package:flutter/material.dart';
import 'package:telegram_story/common/constant/constant_mesurements.dart';

class HomeBody extends StatelessWidget {
   const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(TSDefaultMeasurement.defaultPadding),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 50,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text("C"),
            ),
            title: Text("Chat $index"),
            subtitle: Text("Last message..."),
          );
        },
      ),
    );
  }
}

