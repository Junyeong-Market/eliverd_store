class User {
  int _pid;
  String _user_id;
  String _password;
  String _nickname;
  bool _isSeller;

  int get pid => _pid;
  String get user_id => _user_id;
  String get password => _password;
  String get nickname => _nickname;
  bool get isSeller => _isSeller;
}

class Session {
  String _id;
  String _pid;
  DateTime _expireAt;

  String get id => _id;
  String get pid => _pid;
  DateTime get expireAt => _expireAt;
}