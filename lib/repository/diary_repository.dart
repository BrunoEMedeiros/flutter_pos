import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:projeto/model/Diario.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:projeto/utils.dart';

class DiarysRepository {
  static Future<List<Diario>> getDiarys(int tripId) async {
    final client = http.Client();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final auth = prefs.getString('token');
    final token = {'Authorization': 'Bearer $auth'};
    final uri = Uri.parse("http://$host:21035/diary/$tripId");
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

  static Future<bool> newImageDiary(
      int tripId, int diaryId, File imagem) async {
    try {
      BaseOptions baseOptions = BaseOptions(
        baseUrl: "http://$host:21035",
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(minutes: 1),
        receiveTimeout: const Duration(minutes: 1),
      );

      Dio dio = Dio(baseOptions);

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final auth = prefs.getString('token');

      String fileName = imagem.path.split('/').last;
      String fileExt = fileName.split('.').last;
      String newFileName =
          fileName.substring(0, fileName.length - fileExt.length - 1);

      // Authorization header
      dio.options.headers.addAll({'Authorization': 'Bearer $auth'});
      Map<String, dynamic> formDataFields = {
        'file': await MultipartFile.fromFile(imagem.path,
            filename: "$newFileName.$fileExt",
            contentType: MediaType('image', 'jpg'))
      };
      final formData = FormData.fromMap(formDataFields);

      final response =
          await dio.patch("/diary/$tripId/$diaryId", data: formData);

      if (response.statusCode == 200) {
        return Future.value(true);
      } else {
        return Future.value(false);
      }
    } catch (e) {
      // Handle errors
      print(e);
      return Future.value(false);
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
      final uri = Uri.parse("http://$host:21035/diary/$tripId");
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
      final uri = Uri.parse("http://$host:21035/diary/$tripId/$id");
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
      final uri = Uri.parse("http://$host:21035/diary/$tripId/$id");
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
