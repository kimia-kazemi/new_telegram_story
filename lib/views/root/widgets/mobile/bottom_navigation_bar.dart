import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget myBottomNavigationBar(ValueChanged<int> onTap) {
  final Map<String, int> routeToIndex = {
    '/home': 0,
    '/messages': 1,
    '/profile': 2,
  };

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      boxShadow: [
        BoxShadow(
          spreadRadius: 0,
          blurRadius: 3,
        ),
      ],
    ),
    child: BottomNavigationBar(
      currentIndex: routeToIndex[Get.currentRoute] ?? 0,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: "messages",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "profile",
        ),
      ],
      onTap: (int index) {
        onTap.call(index);
      },
    ),
  );
}
