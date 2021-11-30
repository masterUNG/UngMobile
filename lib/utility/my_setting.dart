import 'package:shared_preferences/shared_preferences.dart';

class MySetting {
  Future<int> findIndex() async {
    int index = 0;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? result = preferences.getInt('index');
    if (result != null) {
      index = result;
    }
    return index;
  }

  Future<List<String>> findUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String>? strings =
        preferences.getStringList('userdata'); // [token, empid, user]

    return strings!;
  }
}
