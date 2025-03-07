import 'package:flutter/material.dart';
import '../../app/responsive/responsive.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TSResponsive(
          mobile: Text('Message mobile page'),
          desktop: Text('Message desktop page'),
          tablet: Text('Message tablet page')),
    );
  }
}
