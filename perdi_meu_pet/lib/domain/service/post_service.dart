import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../utils/urls.dart';
import '../model/post.dart';

class PostService {

  static Future<MapEntry<String, Post>> addPost(Post post) async {
    final response = await http.post(
      Uri.parse('${Urls.BASE_URL}/posts.json'),
      body: json.encode(post.toJson()),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return MapEntry(data['name'], post);
    } else {
      throw Exception('Erro ao cadastrar post');
    }
  }

  static Future<List<String>> getFavoritePosts(String userId) async {
    final response = await http.get(Uri.parse('${Urls.BASE_URL}/users/$userId/favorites.json'));
    if (response.statusCode == 200) {
      final List<String> data = json.decode(response.body).cast<String>();
      return data;
    } else {
      throw Exception('Erro ao buscar posts favoritos');
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

  static Future<Map<String, Post>> getPostsByUser(String userId) async {
    final response = await http.get(Uri.parse('${Urls.BASE_URL}/posts.json'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final Map<String, Post> postMap = {};
      data.forEach((key, value) {
        final post = Post.fromJson(value);
        if (post.userId == userId) {
          postMap[key] = post;
        }
      });
      return postMap;
    } else {
      throw Exception('Erro ao buscar posts');
    }
  }

  static Future<MapEntry<String, Post>> getPostById(String id) async {
    final response = await http.get(Uri.parse('${Urls.BASE_URL}/posts/$id.json'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return MapEntry(id, Post.fromJson(data));
    } else {
      throw Exception('Erro ao buscar post');
    }
  }

  
}