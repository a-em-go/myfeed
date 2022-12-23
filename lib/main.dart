import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myfeed/core/providers/user_provider.dart';
import 'package:myfeed/core/utils/colors.dart';
import 'package:myfeed/core/widgets/mobile_screen_layout.dart';
import 'package:myfeed/core/widgets/responsive_layout_screen.dart';
import 'package:myfeed/core/widgets/web_screen_layout.dart';
import 'package:myfeed/screens/home/domain/repository/user_repository.dart';
import 'package:myfeed/screens/login/presentation/pages/login.dart';
import 'package:myfeed/screens/login/presentation/pages/signup.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCRuMAbCJHu0VbQEQf6-DFmS-PmQ_YPqGg",
            appId: "1:139386686425:web:8e044bfdb7dfa7f2e327c8",
            messagingSenderId: "139386686425",
            projectId: "myfeed-e7d2f"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Myfeed',
          theme: ThemeData.dark()
              .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
          home: StreamBuilder(
            stream: (() async* {
              var i = 0;
              while (true) {
                var res = await UserRepository().getUser(id: 12);
                if (res == "success") {
                  if (i != 0) {
                    await Future<void>.delayed(Duration(hours: 1));
                  }
                  i++;
                  yield 1;
                }
              }
            })(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return const ResponsiveLayout(
                    mobileScreenLayout: MobileScreenLayout(),
                    webScreenLayout: WebScreenLayout(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("${snapshot.error}"),
                  );
                }
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                );
              }
              return const LoginScreen();
            },
          )),
    );
  }
}
