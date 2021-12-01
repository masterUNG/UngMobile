import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ungmobile/models/get_main_icon_model.dart';
import 'package:ungmobile/utility/get_main_icon.dart';
import 'package:ungmobile/utility/my_constant.dart';
import 'package:ungmobile/widgets/show_image.dart';
import 'package:ungmobile/widgets/show_progress.dart';
import 'package:ungmobile/widgets/show_title.dart';
import 'package:url_launcher/url_launcher.dart';

class Personal extends StatefulWidget {
  final int index;
  const Personal({Key? key, required this.index}) : super(key: key);

  @override
  _PersonalState createState() => _PersonalState();
}

class _PersonalState extends State<Personal> {
  List<GetMainIconModel> personalModels = [];
  int? index;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    index = widget.index;
    getPersonalData();
  }

  Future<void> getPersonalData() async {
    String path = MyConstant.apiGetMainIcon;

    Dio dio = Dio();

    await dio.get(path).then((value) {
      for (var item in value.data) {
        GetMainIconModel model = GetMainIconModel.fromMap(item);

        if (model.tab == 'PERSONAL') {
          setState(() {
            personalModels.add(model);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: personalModels.isEmpty
          ? const ShowProgress()
          : GridView.builder(
              itemCount: personalModels.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 160,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  launchWebsite(personalModels[index].href);
                },
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        child: CachedNetworkImage(
                          imageUrl: convertToUrl(personalModels[index].imgSrc),
                          placeholder: (context, url) => const ShowProgress(),
                          errorWidget: (context, url, error) =>
                              ShowImage(path: MyConstant.pathImage1hot),
                        ),
                      ),
                      ShowTitle(
                          title: cutWord(personalModels[index].text),
                          index: this.index!),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  String convertToUrl(String imgSrc) {
    String string = imgSrc;
    string = string.substring(1);
    string = '${MyConstant.domainIcon}$string';
    return string;
  }

  String cutWord(String text) {
    String string = text;

    if (string.length >= 11) {
      string = string.substring(0, 7);
      string = '$string...';
    }

    return string;
  }

  Future<void> launchWebsite(String href) async {
    if (await canLaunch(href)) {
      await launch(href);
    }
  }
}
