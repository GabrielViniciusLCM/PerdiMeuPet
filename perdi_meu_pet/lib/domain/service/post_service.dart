import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../utils/urls.dart';
import '../model/post.dart';

class PostService {

  static Future<Map<String, Post>> addPost(Post post) async {
    final response = await http.post(
      Uri.parse('${Urls.BASE_URL}/posts.json'),
      body: json.encode(post),
    );
    if (response.statusCode == 200) {
      final id = json.decode(response.body)['name'];
      final Map<String, Post> postMap = {id: post};
      return postMap;
    } else {
      throw Exception('Erro ao cadastrar post');
    }
  }

  static Future<Map<String, Post>> getPosts() async {
    final response = await http.get(Uri.parse('${Urls.BASE_URL}/posts.json'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final Map<String, Post> postMap = {};
      data.forEach((key, value) {
        postMap[key] = Post.fromJson(value);
      });
      return postMap;
    } else {
      throw Exception('Erro ao buscar posts');
    }
  }

  static Future<Map<String, Post>> getPostById(String id) async {
    final response = await http.get(Uri.parse('${Urls.BASE_URL}/posts/$id.json'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final Map<String, Post> postMap = {id: Post.fromJson(data)};
      return postMap;
    } else {
      throw Exception('Erro ao buscar post');
    }
  }
}