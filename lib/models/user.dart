import 'package:equatable/equatable.dart';

import 'package:Eliverd/models/models.dart';

class User extends Equatable {
  final int pid;
  final String userId;
  final String password;
  final String nickname;
  final String realname;
  final List<Store> stores;

  const User({
    this.pid,
    this.userId,
    this.password,
    this.nickname,
    this.realname,
    this.stores,
  });

  @override
  List<Object> get props => [pid, userId, password, nickname, realname, stores];

  @override
  String toString() {
    return 'User{ pid: $pid, userId: $userId, password: $password, nickname: $nickname, realname: $realname, stores: $stores }';
  }

  static User fromJson(dynamic json) {
    return User(
      pid: json['pid'],
      userId: json['user_id'],
      password: json['password'],
      nickname: json['nickname'],
      realname: json['realname'],
      stores: json['stores'].map<Store>((store) => Store.fromJson(store)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'pid': pid,
        'user_id': userId,
        'password': password,
        'nickname': nickname,
        'realname': realname,
      };

  static User fromJsonWithoutStore(dynamic json) {
    return User(
      pid: json['pid'],
      userId: json['user_id'],
      password: json['password'],
      nickname: json['nickname'],
      realname: json['realname'],
    );
  }
}

class Session extends Equatable {
  final int id;
  final int pid;
  final DateTime expireAt;

  const Session({this.id, this.pid, this.expireAt});

  @override
  List<Object> get props => [id, pid, expireAt];

  @override
  String toString() {
    return 'Session{ id: $id, pid: $pid, expireAt: $expireAt }';
  }
}
