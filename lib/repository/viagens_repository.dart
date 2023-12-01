import 'dart:convert';
import 'package:projeto/model/Viagens.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:projeto/utils.dart';

class ViagensRepository {
  static Future<List<Viagem>> getViagens() async {
    final client = http.Client();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final auth = await prefs.getString('token');
    final token = {'Authorization': 'Bearer $auth'};
    final uri = Uri.parse("http://$host:21035/trips");
    final response = await client.get(uri, headers: Map.from(token));

    if (response.statusCode == 200) {
      return Viagem.fromJsonToList(jsonDecode(response.body));
    } else {
      throw Exception('Erro ao get trips');
    }
  }

  static Future<bool> newTrip(
      String startDate, String endDate, String destination) async {
    try {
      final client = http.Client();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final auth = await prefs.getString('token');
      Map<String, dynamic> request = {
        'startDate': startDate,
        'endDate': endDate,
        'destination': destination
      };
      final token = {'Authorization': 'Bearer $auth'};
      final uri = Uri.parse("http://$host:21035/trips");
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
      print("Error to create trip: $e");
      return Future.value(false);
    }
  }

  static Future<bool> editTrip(int id, String startDate, String endDate,
      String destination, String status) async {
    try {
      print("Status: $status");
      final client = http.Client();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final auth = prefs.getString('token');
      Map<String, dynamic> request = {
        'startDate': startDate,
        'endDate': endDate,
        'destination': destination,
        'status': status
      };
      final token = {'Authorization': 'Bearer $auth'};
      final uri = Uri.parse("http://$host:21035/trips/$id");
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
      print("Error to update trip: $e");
      return Future.value(false);
    }
  }

  static Future<bool> deleteTrip(int id) async {
    try {
      final client = http.Client();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final auth = prefs.getString('token');
      final token = {'Authorization': 'Bearer $auth'};
      final uri = Uri.parse("http://$host:21035/trips/$id");
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
      print("Error to delete trip: $e");
      return Future.value(false);
    }
  }
}
