import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final int? id;
  final String? accessToken;
  final String? refreshToken;
  final String? username;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? image;

  const AuthEntity({
    this.accessToken,
    this.refreshToken,
    this.id,
    this.username,
    this.email,
    this.firstName,
    this.lastName,
    this.gender,
    this.image,
  });

  AuthEntity copyWith({
    int? id,
    String? accessToken,
    String? refreshToken,
    String? username,
    String? email,
    String? firstName,
    String? lastName,
    String? gender,
    String? image,
  }) {
    return AuthEntity(
      id: id ?? this.id,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      username: username ?? this.username,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      image: image ?? this.image,
    );
  }

  @override
  List<Object?> get props {
    return [
      accessToken,
      refreshToken,
      id,
      username,
      email,
      firstName,
      lastName
    ];
  }
}
