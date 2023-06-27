// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String email;
  final String password;
  final String confrimP;
  final String name;

  const UserModel({
    required this.email,
    required this.password,
    required this.confrimP,
    required this.name,
  });

  @override
  List<Object> get props => [email, password, confrimP, name];
  @override
  String toString() {
    return 'UserModel { email: $email, password: $password, name: $name }';
  }

  static UserModel fromString(String string) {
    final parts = string.split(', ');
    final email = parts[0].split(': ')[1];
    final password = parts[1].split(': ')[1];
    final confrimP = parts[2].split(': ')[1];
    final name = parts[3].split(': ')[1];
    return UserModel(email: email, password: password, name: name, confrimP: confrimP);
  }
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'confrimP': confrimP,
      'name': name,

    };
  }

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] as String,
      password: json['password'] as String,
       confrimP: json['name'] as String,
       name: json['name'] as String,
    );
  }


  UserModel copyWith({
    String? email,
    String? password,
    String? confrimP,
    String? name,
  }) {
    return UserModel(
      email: email ?? this.email,
      password: password ?? this.password,
      confrimP: confrimP ?? this.confrimP,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'confrimP': confrimP,
      'name': name,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] as String,
      password: map['password'] as String,
      confrimP: map['confrimP'] as String,
      name: map['name'] as String,
    );
  }

  @override
  bool get stringify => true;
}
