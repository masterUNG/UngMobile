import 'package:flutter/material.dart';
import 'package:ungmobile/utility/my_constant.dart';

class ShowTitle extends StatelessWidget {
  final String title;
  final int index;
  final TextStyle? textStyle;
  const ShowTitle({Key? key, required this.title,required this.index, this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: textStyle ?? MyConstant().h3Style(index),
    );
  }
}
