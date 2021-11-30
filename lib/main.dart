import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ungmobile/states/authen.dart';
import 'package:ungmobile/states/main_home.dart';
import 'package:ungmobile/utility/my_constant.dart';

Map<String, WidgetBuilder> map = {
  MyConstant.routeAuthen: (BuildContext context) => const Authen(),
  MyConstant.routeMainHome: (BuildContext context) => const MainHome(),
};

String? firstState;

void main() {
  HttpOverrides.global = MyHttpOverrides();
  firstState = MyConstant.routeAuthen;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: map,
      initialRoute: firstState,
      title: MyConstant.appName,
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    // TODO: implement createHttpClient
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
