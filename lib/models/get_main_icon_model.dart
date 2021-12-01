import 'dart:convert';

class GetMainIconModel {

  final int id;
  final String tab;
  final String href;
  final String hrefIframe;
  final String imgSrc;
  final String text;
  final  String intranet;
  final String display;
  final String newpage;
  GetMainIconModel({
    required this.id,
    required this.tab,
    required this.href,
    required this.hrefIframe,
    required this.imgSrc,
    required this.text,
    required this.intranet,
    required this.display,
    required this.newpage,
  });
  

  Map<String, dynamic> toMap() {
    return {
      'Id': id,
      'Tab': tab,
      'Href': href,
      'Href_iframe': hrefIframe,
      'ImgSrc': imgSrc,
      'Text': text,
      'Intranet': intranet,
      'Display': display,
      'Newpage': newpage,
    };
  }

  factory GetMainIconModel.fromMap(Map<String, dynamic> map) {
    return GetMainIconModel(
      id: map['Id'],
      tab: map['Tab'],
      href: map['Href'],
      hrefIframe: map['Href_iframe'],
      imgSrc: map['ImgSrc'],
      text: map['Text'],
      intranet: map['Intranet'] ?? '',
      display: map['Display'],
      newpage: map['Newpage'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GetMainIconModel.fromJson(String source) => GetMainIconModel.fromMap(json.decode(source));
}
