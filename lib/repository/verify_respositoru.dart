import 'package:shared_preferences/shared_preferences.dart';

class VerifyRepository {
  static Future<String> getToken() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('token')!;
    } catch (e) {
      throw Exception(e);
    }
  }
}
