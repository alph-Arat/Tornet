import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String? phone;
  final String? image;
  final String token;

  const User({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phone,
    this.image,
    required this.token,
  });

  String get fullName => '$firstName $lastName';

  @override
  List<Object?> get props => [id, username, firstName, lastName, email, phone, image, token];
}
