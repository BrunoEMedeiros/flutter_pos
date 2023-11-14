import 'package:projeto/repository/Viagens.dart';

class ViagensRepository {
  static List<Viagem> minhasViagens = [
    Viagem(1, DateTime.now(), DateTime.now(), "Ja fui!", DateTime.now(),
        DateTime.now(), DateTime.now(), "Bebedouro-SP", 1),
    Viagem(2, DateTime.now(), DateTime.now(), "Ja fui!", DateTime.now(),
        DateTime.now(), DateTime.now(), "Barcelona", 1),
    Viagem(3, DateTime.now(), DateTime.now(), "Quero ir", DateTime.now(),
        DateTime.now(), DateTime.now(), "Roma", 1),
    Viagem(4, DateTime.now(), DateTime.now(), "Quero ir", DateTime.now(),
        DateTime.now(), DateTime.now(), "Cairo", 1),
  ];
}
