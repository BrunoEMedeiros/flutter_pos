class User {
  final int _id;
  String _email;
  DateTime _createdAt;
  DateTime _updatedAt;
  DateTime _deletedAt;
  String _code;

  User(this._id, this._email, this._createdAt, this._updatedAt, this._deletedAt,
      this._code);

  int get id => _id;
  String get email => _email;
  DateTime get createdAt => _createdAt;
  DateTime get updatedAt => _updatedAt;
  DateTime get deletedAt => _deletedAt;
  String get code => _code;

  set email(String email) {
    _email = email;
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

  set code(String code) {
    _code = code;
  }
}
