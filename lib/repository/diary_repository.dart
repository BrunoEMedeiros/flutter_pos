import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projeto/model/Diario.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiarysRepository {
  static Future<List<Diario>> getDiarys(int tripId) async {
    final client = http.Client();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final auth = prefs.getString('token');
    final token = {'Authorization': 'Bearer $auth'};
    final uri = Uri.parse("http://192.168.0.121:21035/diary/$tripId");
    final response = await client.get(uri, headers: Map.from(token));

    if (response.statusCode == 200) {
      // final teste = Viagem.fromJson(json.decode(response.body));
      // return Viagem.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      //print(Viagem.fromJsonToList(jsonDecode(response.body)));
      return Diario.fromJsonToList(jsonDecode(response.body));
    } else {
      throw Exception('Error to get diarys');
    }
  }

  static Future<bool> newDiaryEntry(
      int tripId, String date, String location, String description) async {
    try {
      final client = http.Client();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final auth = prefs.getString('token');
      Map<String, dynamic> request = {
        'date': date,
        'description': description,
        'location': location
      };
      final token = {'Authorization': 'Bearer $auth'};
      final uri = Uri.parse("http://192.168.0.121:21035/diary/$tripId");
      final response = await client.post(
        uri,
        headers: Map.from(token),
        body: request,
      );
      if (response.statusCode == 201) {
        return Future.value(true);
      } else {
        return Future.value(false);
      }
    } catch (e) {
      print("Error to create diary entry: $e");
      return Future.value(false);
    }
  }

  static Future<bool> editDiary(int id, int tripId, String date,
      String location, String description) async {
    try {
      final client = http.Client();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final auth = prefs.getString('token');
      Map<String, dynamic> request = {
        'date': date,
        'description': description,
        'location': location
      };
      final token = {'Authorization': 'Bearer $auth'};
      final uri = Uri.parse("http://192.168.0.121:21035/diary/$tripId/$id");
      final response = await client.put(
        uri,
        headers: Map.from(token),
        body: request,
      );
      if (response.statusCode == 200) {
        return Future.value(true);
      } else {
        return Future.value(false);
      }
    } catch (e) {
      print("Error to update diary: $e");
      return Future.value(false);
    }
  }

  static Future<bool> deleteDiary(int id, int tripId) async {
    try {
      final client = http.Client();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final auth = prefs.getString('token');
      final token = {'Authorization': 'Bearer $auth'};
      final uri = Uri.parse("http://192.168.0.121:21035/diary/$tripId/$id");
      final response = await client.delete(
        uri,
        headers: Map.from(token),
      );
      if (response.statusCode == 200) {
        return Future.value(true);
      } else {
        return Future.value(false);
      }
    } catch (e) {
      print("Error to delete diary: $e");
      return Future.value(false);
    }
  }
}
