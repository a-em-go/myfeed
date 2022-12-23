import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

const host = 'localhost:1337';
const authorizationHeader =
    'Bearer 92e917f11b2ff32ff8e1a9530afe659a18d59dc965318b857a2a904a4920a893a2a7bc34365e5aa6864849efea5c283ff4da83c54cb7dc7133d8286489f75979c7324835e2f275e9b1621bd44d5204cc2dce1e528c685bd87297cfae7bf8499ee35d8f8503e7fd56dfe87b5fabd4c5c6b973d2d8f98475f1c50d0e0934ee9da9';

Future<http.StreamedResponse> createPost({
  required String description,
  required Uint8List file,
  required int uid,
}) async {
  var request = MultipartRequest('POST', Uri.http(host, '/api/posts'));
  request.fields['data'] = jsonEncode(
      {'description': description, 'profile': uid});
  request.files.add(http.MultipartFile.fromBytes('files.media', file,
      filename: 'post.png'));
  return request.send();
}

Future<http.StreamedResponse> createUser({
  required String email,
  required String password,
  required String username,
  required String bio,
  required Uint8List file,
}) async {
  var request = MultipartRequest('POST', Uri.http(host, '/api/profiles'));
  request.fields['data'] = jsonEncode(
      {'email': email, 'password': password, 'username': username, 'bio': bio});
  request.files.add(http.MultipartFile.fromBytes('files.avatar', file,
      filename: 'avatar.png'));
  return request.send();
}

Future<http.Response> getUser({required int id}) async {
  return get(Uri.http(host, '/api/profiles/$id', {'populate':'*'}));
}

Future<Response> get(Uri url, {Map<String, String>? headers}) {
  return http.get(url, headers: _setHeaders(headers));
}

Future<Response> post(Uri url,
    {Map<String, String>? headers, Object? body, Encoding? encoding}) {
  return http.post(url,
      headers: _setHeaders(headers), body: body, encoding: encoding);
}

Future<Response> put(Uri url,
    {Map<String, String>? headers, Object? body, Encoding? encoding}) {
  return http.put(url,
      headers: _setHeaders(headers), body: body, encoding: encoding);
}

Future<Response> patch(Uri url,
    {Map<String, String>? headers, Object? body, Encoding? encoding}) {
  return http.patch(url,
      headers: _setHeaders(headers), body: body, encoding: encoding);
}

Future<Response> delete(Uri url,
    {Map<String, String>? headers, Object? body, Encoding? encoding}) {
  return http.delete(url,
      headers: _setHeaders(headers), body: body, encoding: encoding);
}

Map<String, String>? _setHeaders(Map<String, String>? headers) {
  if (headers == null) {
    headers = {
      'Authorization': authorizationHeader,
      'Content-Type': 'application/json'
    };
  } else {
    headers['Authorization'] = authorizationHeader;
    headers['Content-Type'] = 'application/json';
  }
  return headers;
}

class MultipartRequest extends http.MultipartRequest {
  MultipartRequest(super.method, super.url);

  @override
  Future<http.StreamedResponse> send() {
    super.headers['Authorization'] = authorizationHeader;
    return super.send();
  }
}
