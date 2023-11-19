import 'dart:convert';
import 'package:projeto/model/Viagens.dart';
import 'package:http/http.dart' as http;

class ViagensRepository {
  // static List<Viagem> minhasViagens = [
  //   Viagem(1, DateTime.now(), DateTime.now(), "Ja fui!", DateTime.now(),
  //       DateTime.now(), DateTime.now(), "Bebedouro-SP", 1),
  //   Viagem(2, DateTime.now(), DateTime.now(), "Ja fui!", DateTime.now(),
  //       DateTime.now(), DateTime.now(), "Barcelona", 1),
  //   Viagem(3, DateTime.now(), DateTime.now(), "Quero ir", DateTime.now(),
  //       DateTime.now(), DateTime.now(), "Roma", 1),
  //   Viagem(4, DateTime.now(), DateTime.now(), "Quero ir", DateTime.now(),
  //       DateTime.now(), DateTime.now(), "Cairo", 1),
  // ];

  static Future<List<Viagem>> getViagens() async {
    final client = http.Client();
    final token = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImVtYWlsIjoiZWRpbmFsZG9wc2pAcHJvdG9uLm1lIiwiaWF0IjoxNjk5NTgwOTY1LCJleHAiOjE3MDIxNzI5NjV9.mmiHDQMkeK4a-TdU0QT4Xiliz1UY8J1yvr4WQVfuRiY'
    };
    final uri = Uri.parse("http://192.168.0.34:21035/trips");
    final response = await client.get(uri, headers: Map.from(token));

    if (response.statusCode == 200) {
      // final teste = Viagem.fromJson(json.decode(response.body));
      // return Viagem.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      //print(Viagem.fromJsonToList(jsonDecode(response.body)));
      return Viagem.fromJsonToList(jsonDecode(response.body));
    } else {
      throw Exception('Erro ao get trips');
    }
  }
}
