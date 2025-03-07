import 'package:flutter/material.dart';

class TSResponsive extends StatelessWidget {
  final Widget mobile;
  final Widget ?tablet;
  final Widget? desktop;

  const TSResponsive({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  static Size size(context)=> MediaQuery.of(context).size;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width <= 425;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1024 &&
          MediaQuery.of(context).size.width > 425;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, boxConstraints) {
      if (boxConstraints.maxWidth <= 767) {
        return mobile;
      } else if (boxConstraints.maxWidth <= 1024) {
        return tablet??mobile;
      } else {
        return desktop??mobile;
      }
    });
  }
}
