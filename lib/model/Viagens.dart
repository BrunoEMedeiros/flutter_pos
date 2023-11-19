class Viagem {
  final int id;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime deletedAt;
  final String destination;
  final int userId;

  Viagem(
      {required this.id,
      required this.startDate,
      required this.endDate,
      required this.status,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt,
      required this.destination,
      required this.userId});

  factory Viagem.fromJson(Map<String, dynamic> json) {
    return Viagem(
        id: json['id'] as int,
        startDate: DateTime.parse(json['startDate']),
        endDate: DateTime.parse(json['endDate']),
        status: json['status'] as String,
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
        deletedAt: DateTime.now(),
        destination: json['destination'] as String,
        userId: json['userId'] as int);
  }

  static List<Viagem> fromJsonToList(Iterable list) {
    return List<Viagem>.from(list.map((e) => Viagem.fromJson(e)));
  }
}
