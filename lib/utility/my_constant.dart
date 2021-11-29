import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyConstant {
  // field
  static String routeAuthen = '/authen';
  static String routeMyServie = '/myService';

  static Color primaryHot = const Color(0xffd85e00);
  static Color lightHot = const Color(0xffff8e3b);
  static Color darkHot = const Color(0xff9f2f00);

  static Color primaryCool = const Color(0xff125db2);
  static Color lightCool = const Color(0xff5a8ae5);
  static Color darkCool = const Color(0xff003482);

  static Color primaryGreen = const Color(0xff689f38);
  static Color lightGreen = const Color(0xff99d066);
  static Color darkGreen = const Color(0xff387002);

  static String pathImage1hot = 'images/hot1.png';
  static String pathImage2hot = 'images/hot2.png';
  static String pathImage3hot = 'images/hot3.png';
  static String pathImage4hot = 'images/hot4.png';
  static String pathImage5hot = 'images/hot5.png';

  static String appName = 'Ung Moble';

  // method
  BoxDecoration planBox() => BoxDecoration(
        color: lightHot.withOpacity(0.3),
      );

  BoxDecoration whiteBox() => BoxDecoration(borderRadius: BorderRadius.circular(20),
        color: Colors.white.withOpacity(0.7),
      );

  ButtonStyle buttonStyle() => ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        primary: MyConstant.primaryHot,
      );

  TextStyle h1Style() => GoogleFonts.prompt(
          textStyle: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: darkHot,
      ));

  TextStyle h2Style() => GoogleFonts.prompt(
          textStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: darkHot,
      ));

  TextStyle h3Style() => GoogleFonts.prompt(
          textStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: darkHot,
      ));
}
