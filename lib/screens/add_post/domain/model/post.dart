import 'package:myfeed/screens/home/domain/model/user.dart';
import 'package:myfeed/screens/home/domain/repository/user_repository.dart';

class Post {
  final int id;
  final String description;
  final String media;
  final User user;

  const Post(
      {required this.id,
      required this.description,
      required this.media,
      required this.user});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['data']['id'],
      description: json['data']['attributes']['description'],
      media:
          'http://localhost:1337${json['data']['attributes']['media']['data']['attributes']['url']}',
      user: User.fromJson(json['data']['attributes']['user']),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "descriptions": description,
        "media": media,
        "user": user.id,
      };
}
