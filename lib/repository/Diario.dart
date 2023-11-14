// Subir midea: id, path e diaryId

class Diario {
  final int _id;
  DateTime _date;
  String _description;
  String _location;
  DateTime _createdAt;
  DateTime _updatedAt;
  DateTime _deletedAt;
  int _trip_id;

  Diario(this._id, this._date, this._description, this._location,
      this._createdAt, this._updatedAt, this._deletedAt, this._trip_id);

  int get id => _id;
  DateTime get date => _date;
  String get description => _description;
  DateTime get createdAt => _createdAt;
  DateTime get updatedAt => _updatedAt;
  DateTime get deletedAt => _deletedAt;
  String get location => _location;
  int get trip_id => _trip_id;

  set date(DateTime date) {
    _date = date;
  }

  set description(String description) {
    _description = description;
  }

  set createdAt(DateTime createdAt) {
    _createdAt = createdAt;
  }

  set updatedAt(DateTime updatedAt) {
    _updatedAt = updatedAt;
  }

  set deletedAt(DateTime deletedAt) {
    _deletedAt = deletedAt;
  }

  set location(String location) {
    _location = location;
  }

  set trip_id(int trip_id) {
    _trip_id = trip_id;
  }
}
