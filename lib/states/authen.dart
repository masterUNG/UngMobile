import 'package:flutter/material.dart';
import 'package:ungmobile/utility/my_constant.dart';
import 'package:ungmobile/widgets/show_image.dart';
import 'package:ungmobile/widgets/show_title.dart';

class Authen extends StatefulWidget {
  const Authen({Key? key}) : super(key: key);

  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  bool redEye = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: Container(
            decoration: MyConstant().planBox(),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    newImage(constraints),
                    newAppName(),
                    newUser(constraints),
                    newPassword(constraints),
                    newLogin(constraints),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container newLogin(BoxConstraints constraints) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      width: constraints.maxWidth * 0.6,
      child: ElevatedButton(
        style: MyConstant().buttonStyle(),
        onPressed: () {},
        child: const Text('Login'),
      ),
    );
  }

  Container newUser(BoxConstraints constraints) {
    return Container(
      decoration: MyConstant().whiteBox(),
      margin: const EdgeInsets.only(top: 16),
      width: constraints.maxWidth * 0.6,
      height: 50,
      child: TextFormField(
        style: MyConstant().h3Style(),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 4),
          label: const ShowTitle(title: 'User :'),
         
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
        ),
      ),
    );
  }

  Container newPassword(BoxConstraints constraints) {
    return Container(
      decoration: MyConstant().whiteBox(),
      margin: const EdgeInsets.only(top: 16),
      width: constraints.maxWidth * 0.6,
      height: 50,
      child: TextFormField(style: MyConstant().h2Style(),
        obscureText: redEye,
        decoration: InputDecoration(
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
          label: const ShowTitle(title: 'Password :'),
         
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
        ),
      ),
    );
  }

  ShowTitle newAppName() => ShowTitle(
        title: MyConstant.appName,
        textStyle: MyConstant().h1Style(),
      );

  SizedBox newImage(BoxConstraints constraints) {
    return SizedBox(
      width: constraints.maxWidth * 0.6,
      child: ShowImage(path: MyConstant.pathImage3hot),
    );
  }
}
