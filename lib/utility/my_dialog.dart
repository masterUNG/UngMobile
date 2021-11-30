import 'package:flutter/material.dart';
import 'package:ungmobile/utility/my_constant.dart';
import 'package:ungmobile/widgets/show_image.dart';
import 'package:ungmobile/widgets/show_title.dart';

class MyDialog {
  Future<void> progressDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => WillPopScope(
          child: const Center(
              child: CircularProgressIndicator(
            color: Colors.white,
          )),
          onWillPop: () async {
            return false;
          }),
    );
  }

  Future<void> normalDialog(
      BuildContext context, String title, String message, int index) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: ShowImage(path: MyConstant.authenImages[index]),
          title: ShowTitle(
            title: title,
            index: index,
            textStyle: MyConstant().h2Style(index),
          ),
          subtitle: ShowTitle(title: message, index: index),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: ShowTitle(title: 'OK', index: index),
          ),
        ],
      ),
    );
  }

  Future<void> backAuthenDialog(
      BuildContext context, String title, String message, int index) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: ShowImage(path: MyConstant.authenImages[index]),
          title: ShowTitle(
            title: title,
            index: index,
            textStyle: MyConstant().h2Style(index),
          ),
          subtitle: ShowTitle(title: message, index: index),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, MyConstant.routeAuthen, (route) => false);
            },
            child: ShowTitle(title: 'OK', index: index),
          ),
        ],
      ),
    );
  }
}
