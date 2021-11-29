import 'package:flutter/material.dart';
import 'package:ungmobile/states/authen.dart';
import 'package:ungmobile/states/my_service.dart';
import 'package:ungmobile/utility/my_constant.dart';

Map<String, WidgetBuilder> map = {
  MyConstant.routeAuthen: (BuildContext context) => const Authen(),
  MyConstant.routeMyServie: (BuildContext context) => const MyService(),
};

String? firstState;

void main() {
  firstState = MyConstant.routeAuthen;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: map,
      initialRoute: firstState,
      title: MyConstant.appName,
    );
  }
}
