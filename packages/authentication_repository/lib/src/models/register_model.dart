import 'dart:convert';

class RegisterModel {
  final String username;
  final String email;
  final String? password;

  const RegisterModel({
    required this.username,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      if (password != null) 'password': password,
    };
  }

  String toJson() => json.encode(toMap());
}
