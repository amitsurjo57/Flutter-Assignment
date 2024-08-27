import 'package:flutter/material.dart';
import '../Custom Widgets/responsive_builder.dart';
import 'desktop_home_layout.dart';
import 'mobile_home_layout.dart';
import 'tablet_home_layout.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveBuilder(
      mobile: MobileHomeLayout(),
      tablet: TabletHomeLayout(),
      desktop: DesktopHomeLayout(),
    );
  }
}
