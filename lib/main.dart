import 'package:flutter/material.dart';
import 'package:myfeed/core/utils/colors.dart';
import 'package:myfeed/core/widgets/mobile_screen_layout.dart';
import 'package:myfeed/core/widgets/responsive_layout_screen.dart';
import 'package:myfeed/core/widgets/web_screen_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Myfeed',
        theme: ThemeData.dark()
            .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
        home: const ResponsiveLayout(
          mobileScreenLayout: MobileScreenLayout(),
          webScreenLayout: WebScreenLayout(),
        ));
  }
}
