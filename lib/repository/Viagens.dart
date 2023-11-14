class Viagem {
  int _id;
  DateTime _startDate;
  DateTime _endDate;
  String _status;
  DateTime _createdAt;
  DateTime _updatedAt;
  DateTime _deletedAt;
  String _destination;
  int _userId;

  Viagem(
      this._id,
      this._startDate,
      this._endDate,
      this._status,
      this._createdAt,
      this._updatedAt,
      this._deletedAt,
      this._destination,
      this._userId);

  int get id => _id;
  DateTime get startDate => _startDate;
  DateTime get endDate => _endDate;
  String get status => _status;
  DateTime get createdAt => _createdAt;
  DateTime get updatedAt => _updatedAt;
  DateTime get deletedAt => _deletedAt;
  String get destination => _destination;
  int get userId => _userId;

  set startDate(DateTime startDate) {
    _startDate = startDate;
  }

  set endDate(DateTime endDate) {
    _endDate = endDate;
  }

  set status(String status) {
    _status = status;
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

  set destination(String destination) {
    _destination = destination;
  }

  set userId(int userId) {
    _userId = userId;
  }
}
