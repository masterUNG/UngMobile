import 'package:flutter/material.dart';
import 'package:ungmobile/utility/my_constant.dart';
import 'package:ungmobile/utility/my_setting.dart';

class MyService extends StatefulWidget {
  const MyService({Key? key}) : super(key: key);

  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  int? index;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findIndex();
  }

  Future<void> findIndex() async {
    await MySetting().findIndex().then((value) {
      setState(() {
        index = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: index == null ? null : AppBar(backgroundColor: MyConstant.primarys[index!],) ,
    );
  }
}
