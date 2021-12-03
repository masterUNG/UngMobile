import 'package:badges/badges.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungmobile/models/authen_model.dart';
import 'package:ungmobile/utility/my_constant.dart';
import 'package:ungmobile/utility/my_dialog.dart';
import 'package:ungmobile/utility/my_setting.dart';
import 'package:ungmobile/widgets/show_image.dart';
import 'package:ungmobile/widgets/show_progress.dart';
import 'package:ungmobile/widgets/show_title.dart';

class Authen extends StatefulWidget {
  const Authen({Key? key}) : super(key: key);

  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  bool redEye = true;
  final formKey = GlobalKey<FormState>();
  final drawKey = GlobalKey<ScaffoldState>();

  int? index;

  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FlutterLocalNotificationsPlugin flutterLocalNotificationPlugin =
      FlutterLocalNotificationsPlugin();
  InitializationSettings? initialiZationSettings;
  AndroidInitializationSettings? androidInitializationSettings;
  IOSInitializationSettings? iosInitializationSettings;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readIndex();
    setupMessaging();
    setupLocalNoti();
  }

  Future<void> setupLocalNoti() async {
    androidInitializationSettings =
        const AndroidInitializationSettings('app_icon');

    iosInitializationSettings = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNoti);

    initialiZationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await flutterLocalNotificationPlugin.initialize(
      initialiZationSettings!,
      onSelectNotification: onSelectNoti,
    );
  }

  Future onDidReceiveLocalNoti(
      int id, String? title, String? body, String? payload) async {
    return CupertinoAlertDialog(
      title: Text(title!),
      content: Text(body!),
      actions: [
        CupertinoDialogAction(
          onPressed: () {},
          isDefaultAction: true,
          child: const Text('OK'),
        ),
      ],
    );
  }

  Future<void> onSelectNoti(String? string) async {
    if (string != null) {
      print('## string onSelect => $string');
    }
  }

  Future<void> setupMessaging() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    String? token = await firebaseMessaging.getToken();
    print('## token ==> $token');

    //for fontEnd Service
    FirebaseMessaging.onMessage.listen((event) {
      String? title = event.notification!.title;
      String? message = event.notification!.body;
      print('## onMessage ==> title = $title, message = $message');
      // MyDialog().normalDialog(context, title!, message!, index!);

      processShowLocalNoti(title!, message!);
    });

    //for BackEnd Service
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      String? title = event.notification!.title;
      String? message = event.notification!.body;
      print('## onMessageOpenApp ==> title = $title, message = $message');
    });
  }

  Future<void> processShowLocalNoti(String title, String message) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      'channelId',
      'channelName',
      priority: Priority.high,
      importance: Importance.max,
      ticker: 'test',
    );

    IOSNotificationDetails iosNotificationDetails = const IOSNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );
    await flutterLocalNotificationPlugin.show(
        0, title, message, notificationDetails);
  }

  Future<void> readIndex() async {
    await MySetting().findIndex().then((value) {
      setState(() {
        index = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: drawKey,
      endDrawer: index == null ? const SizedBox() : newDrawer(context),
      body: SafeArea(
        child: index == null ? const ShowProgress() : newContent(),
      ),
    );
  }

  LayoutBuilder newContent() {
    return LayoutBuilder(
      builder: (context, constraints) => GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: Container(
          decoration: MyConstant().planBox(index!),
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      drawKey.currentState!.openEndDrawer();
                    },
                    icon: Icon(
                      Icons.settings,
                      color: MyConstant.lightHot,
                    ),
                  ),
                ],
              ),
              Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        newImage(constraints),
                        newAppName(),
                        newUser(constraints),
                        newPassword(constraints),
                        newLogin(constraints),
                        Badge(
                          badgeContent: const Text('3'),
                          child: const Icon(Icons.android),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Drawer newDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(accountName: null, accountEmail: null),
          RadioListTile(
            title: ShowTitle(
              title: 'Hot Theme',
              textStyle: MyConstant().h2Style(index!),
              index: index!,
            ),
            value: 0,
            groupValue: index,
            onChanged: (value) {
              Navigator.pop(context);
              index = 0;
              setupIndex();
            },
          ),
          RadioListTile(
            title: ShowTitle(
              title: 'Cool Theme',
              textStyle: MyConstant().h2Style(index!),
              index: index!,
            ),
            value: 1,
            groupValue: index,
            onChanged: (value) {
              Navigator.pop(context);
              index = 1;
              setupIndex();
            },
          ),
          RadioListTile(
            title: ShowTitle(
              title: 'Green Theme',
              textStyle: MyConstant().h2Style(index!),
              index: index!,
            ),
            value: 2,
            groupValue: index,
            onChanged: (value) {
              Navigator.pop(context);
              index = 2;
              setupIndex();
            },
          ),
        ],
      ),
    );
  }

  Container newLogin(BoxConstraints constraints) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      width: constraints.maxWidth * 0.6,
      child: ElevatedButton(
        style: MyConstant().buttonStyle(),
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            String user = userController.text;
            String password = passwordController.text;
            var endPassword = Uri.encodeComponent(password);
            print('user = $user, password = $password');
            MyDialog().progressDialog(context);
            String path =
                '${MyConstant.domainAuthen}?userName=$user&password=$endPassword';

            print('path ==> $path');

            await Dio().get(path).then((value) async {
              print('value Authen ==> $value');
              AuthenModel model = AuthenModel.fromMap(value.data);
              print('IsAuthen ==>> ${model.isAuthenticate}');
              if (model.isAuthenticate) {
                Navigator.pop(context);
                String token = model.token;
                print('token ==>> $token');

                List<String> strings = []; // [token, empid, user]
                strings.add(token);
                strings.add(user);
                strings.add(user);

                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                preferences.setStringList('userdata', strings).then((value) =>
                    Navigator.pushNamedAndRemoveUntil(
                        context, MyConstant.routeMainHome, (route) => false));
              } else {
                Navigator.pop(context);
                MyDialog().normalDialog(context, 'Authen False ?',
                    model.processResult.message, index!);
              }
            });
          }
        },
        child: const Text('Login'),
      ),
    );
  }

  Container newUser(BoxConstraints constraints) {
    return Container(
      // decoration: MyConstant().whiteBox(),
      margin: const EdgeInsets.only(top: 16),
      width: constraints.maxWidth * 0.6,
      // height: 50,
      child: TextFormField(
        controller: userController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Fill User in Blank';
          } else {
            return null;
          }
        },
        style: MyConstant().h3Style(index!),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white.withOpacity(0.7),
          contentPadding: const EdgeInsets.symmetric(vertical: 4),
          label: ShowTitle(
            title: 'User :',
            index: index!,
          ),
          prefixIcon: Icon(
            Icons.perm_identity,
            color: MyConstant.darkHot,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.darkHot),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.lightHot),
            borderRadius: BorderRadius.circular(20),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.lightHot),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  Container newPassword(BoxConstraints constraints) {
    return Container(
      // decoration: MyConstant().whiteBox(),
      margin: const EdgeInsets.only(top: 16),
      width: constraints.maxWidth * 0.6,
      // height: 50,
      child: TextFormField(
        controller: passwordController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Fill Password in Blank';
          } else {
            return null;
          }
        },
        style: MyConstant().h2Style(index!),
        obscureText: redEye,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white.withOpacity(0.7),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                redEye = !redEye;
              });
            },
            icon: redEye
                ? Icon(
                    Icons.remove_red_eye,
                    color: MyConstant.darkHot,
                  )
                : Icon(
                    Icons.remove_red_eye_outlined,
                    color: MyConstant.lightHot,
                  ),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 4),
          label: ShowTitle(
            title: 'Password :',
            index: index!,
          ),
          prefixIcon: Icon(
            Icons.lock_outline,
            color: MyConstant.darkHot,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.darkHot),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.lightHot),
            borderRadius: BorderRadius.circular(20),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstant.lightHot),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  ShowTitle newAppName() => ShowTitle(
        title: MyConstant.appName,
        textStyle: MyConstant().h1Style(index!),
        index: index!,
      );

  SizedBox newImage(BoxConstraints constraints) {
    return SizedBox(
      width: constraints.maxWidth * 0.6,
      child: ShowImage(path: MyConstant.authenImages[index!]),
    );
  }

  Future<void> setupIndex() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt('index', index!).then((value) {
      setState(() {});
    });
  }
}
