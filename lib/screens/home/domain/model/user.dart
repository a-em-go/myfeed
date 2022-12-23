import 'package:myfeed/screens/home/domain/repository/user_repository.dart';

class User {
  final int id;
  final String email;
  final String photo;
  final String username;
  final String bio;
  final List followers;
  final List following;

  const User(
      {required this.id,
      required this.email,
      required this.photo,
      required this.username,
      required this.bio,
      required this.followers,
      required this.following});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['data']['id'],
      email: json['data']['attributes']['email'],
      photo:
          'http://localhost:1337${json['data']['attributes']['avatar']['data']['attributes']['url']}',
      username: json['data']['attributes']['username'],
      bio: json['data']['attributes']['bio'],
      followers: [],
      following: [],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "photo": photo,
        "bio": bio,
        "followers": username,
        "following": username,
      };
}
