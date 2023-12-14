// Subir midea: id, path e diaryId

class Diario {
  final int id;
  final DateTime date;
  final String description;
  final String location;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime deletedAt;
  final int tripId;
  final String? imgUrl;

  Diario(
      {required this.id,
      required this.date,
      required this.description,
      required this.location,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt,
      required this.tripId,
      required this.imgUrl});

  factory Diario.fromJson(Map<String, dynamic> json) {
    return Diario(
        id: json['id'] as int,
        date: DateTime.parse(json['date']),
        description: json['description'] as String,
        location: json['location'] as String,
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
        deletedAt: DateTime.now(),
        tripId: json['tripId'] as int,
        imgUrl: json['imgUrl'] as String?);
  }

  static List<Diario> fromJsonToList(Iterable list) {
    return List<Diario>.from(list.map((e) => Diario.fromJson(e)));
  }
}
