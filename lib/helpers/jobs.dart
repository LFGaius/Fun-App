import 'package:shared_preferences/shared_preferences.dart';

class Jobs{
  static Future<SharedPreferences> getUserPreferences() async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs;
  }
}