import 'package:dio/dio.dart';
import 'package:ungmobile/models/get_main_icon_model.dart';
import 'package:ungmobile/utility/my_constant.dart';

class GetMainIcon {
  List<GetMainIconModel> personalModels = [];
  List<GetMainIconModel> workModels = [];

  GetMainIcon() {
    // processReadAllData();
  }

  Future<void> processReadAllData() async {
    String path = MyConstant.apiGetMainIcon;

    Dio dio = Dio();

    await dio.get(path).then((value) {
      print('## value for GetMainIcon ==> $value');

      for (var item in value.data) {
        GetMainIconModel model = GetMainIconModel.fromMap(item);

        if (model.tab == 'PERSONAL') {
          personalModels.add(model);
        }

        if (model.tab == 'WORK') {
          workModels.add(model);
        }
      }
    });
  }

  Future<List<GetMainIconModel>> processReadPersonal() async {
    await processReadAllData().then((value) {});

    return personalModels;
  }
}
