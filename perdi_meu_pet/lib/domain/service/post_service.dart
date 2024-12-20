import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:perdi_meu_pet/domain/service/user_service.dart';
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

  static Future<Map<String, Post>> getPostsByPetId(String petId) async {
    final response = await http.get(Uri.parse('${Urls.BASE_URL}/posts.json'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final Map<String, Post> postMap = {};
      data.forEach((key, value) {
        final post = Post.fromJson(value);
        if (post.petId == petId) {
          postMap[key] = post;
        }
      });
      return postMap;
    } else {
      throw Exception('Erro ao buscar posts');
    }
  }
  static Future<void> deletePostsByPetId(String key, String userId) async {
    // final response = await http.get(Uri.parse('${Urls.BASE_URL}/posts.json'));
    final posts = await PostService.getPostsByUser(userId);
    final postToDelete = posts.entries.where((element) => element.value.petId == key);
    try {
      for (var post in postToDelete) {
        await http.delete(Uri.parse('${Urls.BASE_URL}/posts/${post.key}.json'));
      }
    } catch (error) {
      throw Exception('Erro ao deletar posts');
    }
  }

  
}