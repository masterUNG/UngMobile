import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ungmobile/bodys/main_page.dart';
import 'package:ungmobile/bodys/news.dart';
import 'package:ungmobile/models/profile_model.dart';
import 'package:ungmobile/utility/my_constant.dart';
import 'package:ungmobile/utility/my_dialog.dart';
import 'package:ungmobile/utility/my_setting.dart';
import 'package:ungmobile/widgets/show_image.dart';
import 'package:ungmobile/widgets/show_progress.dart';
import 'package:ungmobile/widgets/show_title.dart';

class MainHome extends StatefulWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  _MainHomeState createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  int? index;
  ProfileModel? profileModel;
  int indexBody = 0;
  List<Widget> widgets = [];
  List<String> titles = ['Main Page', 'News',];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    findIndex();
    readProfile();
  }

  Future<void> readProfile() async {
    await MySetting().findUserData().then((value) async {
      List<String> strings = value; // [token, empid, user]
      String empid = strings[1];

      String pathAPI =
          'https://play.intouchcompany.com/MobileService2/api/ad/GetUserInfoByPinId?personalID=$empid';

      Dio dio = Dio();
      dio.options.headers['Content-Type'] = 'application/json';
      dio.options.headers['Authorization'] = 'Bearer ${strings[0]}';

      await dio.get(pathAPI).then((value) {
        print('value from myService ==>> $value');

        setState(() {
          profileModel = ProfileModel.fromMap(value.data);
        });
      }).catchError((value) {
        print('value error ==>> $value');
        MyDialog().backAuthenDialog(
            context, 'Have Problem', 'Please Authen Agains', index!);
      });
    });
  }

  Future<void> findIndex() async {
    await MySetting().findIndex().then((value) {
      setState(() {
        index = value;
        widgets.add(MainPage(
          index: index!,
        ));
        widgets.add(const News());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: profileModel == null
          ? const SizedBox()
          : Drawer(
              child: Column(
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        colors: [Colors.white, MyConstant.primarys[index!]],
                        radius: 1,
                      ),
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) => SizedBox(
                        width: double.infinity,
                        child: Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: constraints.maxWidth * 0.35,
                                  child: ShowImage(
                                    path: MyConstant.drawerImages[index!],
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              bottom: 15,
                              child: ShowTitle(
                                title: profileModel!.fullName,
                                index: index!,
                                textStyle: MyConstant().h2Style(index!),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: ShowTitle(
                                title: profileModel!.email,
                                index: index!,
                                textStyle: MyConstant().h3WhiteStyle(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  menuMainPage(context),
                  menuNews(context),
                ],
              ),
            ),
      appBar: index == null
          ? null
          : AppBar(title: Text(titles[indexBody]),
              backgroundColor: MyConstant.primarys[index!],
            ),
      body: index == null ? const ShowProgress() : widgets[indexBody],
    );
  }

  ListTile menuMainPage(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pop(context);
        setState(() {
          indexBody = 0;
        });
      },
      leading: Icon(
        Icons.home_outlined,
        size: 36,
        color: MyConstant.darts[index!],
      ),
      title: ShowTitle(
        title: 'Main Page',
        index: index!,
        textStyle: MyConstant().h2Style(index!),
      ),
      subtitle: ShowTitle(title: 'Display Nav to App', index: index!),
    );
  }

  ListTile menuNews(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pop(context);
        setState(() {
          indexBody = 1;
        });
      },
      leading: Icon(
        Icons.home_max,
        size: 36,
        color: MyConstant.darts[index!],
      ),
      title: ShowTitle(
        title: 'New',
        index: index!,
        textStyle: MyConstant().h2Style(index!),
      ),
      subtitle: ShowTitle(title: 'Display New', index: index!),
    );
  }
}
