import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyConstant {
  // field
  static String domainAuthen = 'https://play.intouchcompany.com/MobileService2/api/ad/Authenticated';

  static String routeAuthen = '/authen';
  static String routeMainHome = '/mainHome';

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

  static String pathImage1cool = 'images/cool1.png';
  static String pathImage2cool = 'images/cool2.png';
  static String pathImage3cool = 'images/cool3.png';
  static String pathImage4cool = 'images/cool4.png';
  static String pathImage5cool = 'images/cool5.png';

  static String pathImage1gr = 'images/green1.png';
  static String pathImage2gr = 'images/green2.png';
  static String pathImage3gr = 'images/green3.png';
  static String pathImage4gr = 'images/green4.png';
  static String pathImage5gr = 'images/green5.png';

  static String appName = 'Ung Moble';

  static List<Color> primarys = [primaryHot, primaryCool, primaryGreen];
  static List<Color> lights = [lightHot, lightCool, lightGreen];
  static List<Color> darts = [darkHot, darkCool, darkGreen];
  static List<String> authenImages = [
    pathImage1hot,
    pathImage1cool,
    pathImage1gr,
  ];
  static List<String> drawerImages = [
    pathImage2hot,
    pathImage2cool,
    pathImage2gr,
  ];

  // method
  BoxDecoration planBox(int index) => BoxDecoration(
        color: lights[index].withOpacity(0.3),
      );

  BoxDecoration whiteBox() => BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withOpacity(0.7),
      );

  ButtonStyle buttonStyle() => ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        primary: MyConstant.primaryHot,
      );

  TextStyle h1Style(int index) => GoogleFonts.prompt(
          textStyle: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: darts[index],
      ));

  TextStyle h2Style(int index) => GoogleFonts.prompt(
          textStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: darts[index],
      ));

  TextStyle h3Style(int index) => GoogleFonts.prompt(
          textStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: darts[index],
      ));

      TextStyle h3WhiteStyle() => GoogleFonts.prompt(
          textStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      ));
}
