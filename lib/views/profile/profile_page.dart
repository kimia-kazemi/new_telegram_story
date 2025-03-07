import 'package:flutter/material.dart';

import '../../app/responsive/responsive.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TSResponsive(
          mobile: Text('Profile mobile page'),
          desktop: Text('Profile desktop page'),
          tablet: Text('Profile tablet page')),
    );
  }
}
