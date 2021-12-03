import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:ungmobile/bodys/approve.dart';
import 'package:ungmobile/bodys/personal.dart';
import 'package:ungmobile/bodys/work.dart';
import 'package:ungmobile/utility/my_constant.dart';

class MainPage extends StatefulWidget {
  final int index;
  const MainPage({Key? key, required this.index}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int indexBody = 0;
  int? index;
  List<BottomNavigationBarItem> bottomNavigationBarItems = [];

  List<Widget> widgets = [];
  List<String> titles = [
    'Personal',
    'Work',
    'Approve',
  ];
  List<IconData> iconDatas = [
    Icons.filter_1,
    Icons.filter_2,
    Icons.filter_3,
  ];

  List<Widget> iconWidgets = [
    const Icon(Icons.filter_1),
    const Icon(Icons.filter_2),
    Badge(
      badgeContent: const Text('3'),
      child: const Icon(Icons.android),
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    index = widget.index;

    widgets.add(Personal(index: index!));
    widgets.add(Work());
    widgets.add(Approve());

    mySetUp();
  }

  void mySetUp() {
    int i = 0;
    for (var title in titles) {
      bottomNavigationBarItems.add(
        BottomNavigationBarItem(
          icon: iconWidgets[i],
          label: title,
        ),
      );

      i++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgets[indexBody],
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavigationBarItems,
        onTap: (value) {
          setState(() {
            indexBody = value;
          });
        },
        selectedItemColor: MyConstant.primarys[index!],
        currentIndex: indexBody,
      ),
    );
  }
}
