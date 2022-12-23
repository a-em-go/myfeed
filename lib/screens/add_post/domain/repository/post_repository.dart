import 'dart:convert';
import 'dart:typed_data';

import 'package:myfeed/core/network/http_api_client.dart' as http;
import 'package:myfeed/screens/home/domain/model/user.dart';

class PostRepository {
  Future<String> createPost({
    required String description,
    required int uid,
    required Uint8List file,
  }) async {
    var res = "Some error occured";
    try {
      if (description.isNotEmpty || file != null) {
        var resp = await http.createPost(
            description: description, file: file, uid: uid);

        res = "success";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
  //
  // Future<String> getUser({required int id}) async {
  //   var res = "Some error occured";
  //   try {
  //     http.getUser(id: id);
  //     res = "success";
  //   } catch (e) {
  //     res = e.toString();
  //   }
  //   return res;
  // }
  //
  // Future<User> getProfileUser() async {
  //   try {
  //     var resp = await http.getUser(id: 12);
  //     if (resp.statusCode == 200) {
  //       return User.fromJson(jsonDecode(resp.body));
  //     } else {
  //       throw Exception("Failed to get User with id = 12");
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
