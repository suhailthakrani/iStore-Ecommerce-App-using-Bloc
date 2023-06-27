import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String email;
  final String password;
  final String name;

  const UserModel({
    required this.email,
    required this.password,
    required this.name,
  });

  @override
  List<Object?> get props => [email, password, name];
  @override
  String toString() {
    return 'UserModel { email: $email, password: $password, name: $name }';
  }

  static UserModel fromString(String string) {
    final parts = string.split(', ');
    final email = parts[0].split(': ')[1];
    final password = parts[1].split(': ')[1];
    final name = parts[2].split(': ')[1];
    return UserModel(email: email, password: password, name: name);
  }
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'name': name,
    };
  }

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] as String,
      password: json['password'] as String,
      name: json['name'] as String,
    );
  }

}
